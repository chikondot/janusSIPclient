import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';



// set global variable
Janus janus = new Janus();

SharedPreferences? _preferences;

class Janus {
  static final Janus _janus = new Janus._internal();

  factory Janus() {
    return _janus;
  }

  IOWebSocketChannel? _channel;
  bool _onConnected = false;

  bool get status => _onConnected;

  bool get callStatus => _onRinging;

  bool get callAnswerd => _onAnswered;

  _reset() {
    if (_channel != null) {
      if (_channel?.sink != null) {
        _channel?.sink.close();
        _onConnected = false;
        _onAnswered = false;
        _onRinging = false;
        _onRegister = false;
        _onAttach = false;
        _handleID = 0;
        _sessionID = 0;
        _transactionID = "";
        // _message = null;
      }
    }
  }

  Janus._internal() {
    // clear any active connections
    _reset();

    try {
      /// connect
      _channel = new IOWebSocketChannel.connect('ws://localhost:8188',
          protocols: ['janus-protocol']);
      _onConnected = true;

      if (_channel != null) {
        _loadSettings();
        _sdpOffer();
        _transactionID = _generateID(12);
        _keepAlive();
      }

      /// listen for events
      _channel?.stream.listen(onMessage);
    } catch (e) {
      throw e;
    }
  }

  // JANUS variables for returned information
  Map<String, dynamic> _message = {"key": "value"};
  String _transactionID = "";
  int _sessionID = 0;
  int _handleID = 0;

  // SDP variables used.
  RTCSessionDescription? _description;
  MediaStream? _stream;
  RTCPeerConnection? _pc;
  dynamic onLocalStream;
  dynamic onRemoteStream;

  Map<String, dynamic> configuration = {
    'iceServers': [
      {'urls': 'stun:stun2.l.google.com:19302'},
      {'urls': 'stun:stun4.l.google.com:19302'},
    ]
  };

  final Map<String, dynamic> _config = {
    'mandatory': {},
    'optional': [
      {'DtlsSrtpKeyAgreement': true},
    ],
  };

  final Map<String, dynamic> _constraints = {
    'mandatory': {
      'OfferToReceiveAudio': true,
      'OfferToReceiveVideo': false,
    },
    'optional': [],
  };

  /// bool values to get state
  bool _onAttach = false;
  bool _onRegister = false;
  bool _onRinging = false;
  bool _onAnswered = false;

  send(Object message) {
    if (_channel != null) {
      if (_channel?.sink != null) {
        _channel?.sink.add(json.encode(message));
      }
    }
  }

  onMessage(received) {
    _message = json.decode(received);
    _onConnected = true;

    print("DEBUG ::: GOT SERVER MESSAGE >>> $_message");

    switch (_message['janus']) {
      case 'success':
        if (!_onAttach) {
          final _attach = {
            "janus": "attach",
            "plugin": "janus.plugin.sip",
            "transaction": "$_transactionID",
            "session_id": _message['data']['id'],
          };
          this.send(_attach);
          _onAttach = true;
          _sessionID = _message['data']['id'];
          break;
        } else if (!_onRegister && _onAttach) {
          final _register = {
            "body": {
              "authuser": "${_preferences?.getString('contact')}",
              "display_name": "${_preferences?.getString('display_name')}",
              "ha1_secret": "${_preferences?.getString('hash')}",
              "proxy": "sip:${_preferences?.getString('domain')}:5060",
              "request": "register",
              "username": "${_preferences?.getString('sip_uri')}"
            },
            "handle_id": _message['data']['id'],
            "janus": "message",
            "session_id": _sessionID,
            "transaction": "$_transactionID"
          };
          this.send(_register);
          _onRegister = true;
          _handleID = _message['data']['id'];
          break;
        }

        break;
      case 'event':
        if (_message['plugindata']['data']['error'] != null) {
          print(
              "EVENT ERROR >>> ${_message['plugindata']['data']['error']} >>> ${_message['plugindata']['data']['error_code']}");

          break;
        }

        switch (_message['plugindata']['data']['result']['event']) {
          case "registering":
            print("RESEND REGISTRATION >>>");

            break;
          case "registered":
            print("REGISTERED || MAKE CALL >>>");

            final _call = {
              "body": {
                "request": "call",
                "uri":
                    "sip:${_preferences?.getString('destination')}@${_preferences?.getString('domain')}"
              },
              "handle_id": _handleID,
              "janus": "message",
              "session_id": _sessionID,
              "transaction": "$_transactionID",
              "jsep": {
                "sdp": "${_description?.sdp}",
                "type": "${_description?.type}"
              },
            };
            this.send(_call);
            break;
          case "calling":
            print("CALLING >>>");

            break;
          case "proceeding":
            print("PROCEEDING >>>");

            break;
          case "ringing":
            print("RINGING >>>");
            _onRinging = true;

            break;
          case "accepted":
            print("ACCEPTED >>>");

            _sdpAnswer(_message['jsep']['sdp']);
            _onAnswered = true;
            break;
          case "progress":
            print("PROGRESS >>>");

            break;
          case "hangup":
            print("HANGUP >>>");

            _reset();
            break;
          case "registration_failed":
            print("REGISTRATION FAILED >>>");

            _reset();
            return "failed";
          default:
        }
        break;
      case 'ack':
        print("ACK >>> ");

        break;
      case 'message':
        print("MESSAGE >>> ");

        break;
      case 'webrtcup':
        print("WEBRTC UPDATE >>> ");

        break;
      case 'media':
        print("MEDIA >>> ");

        break;
      case 'trickle':
        print("TRICKLE >>> ");

        break;
      case 'slowlink':
        print("SLOWLINK >>> ");

        // TODO : tell user that internet is not performing well
        break;
      case 'timeout':
        print("TIMEOUT >>> CLOSING(); ");

        _reset();
        break;
      case 'hangup':
        print("HANGUP SESSION >>> CLOSING()");

        _reset();
        break;
      case 'detached':
        print("DETACHED SESSION >>>");

        break;
      case 'error':
        print("ERROR ON  SESSION >>>");

        _reset();
        break;
      case "incomingcall":
        _sdpIncomingAnswer(_message['jsep']['sdp'], _message['jsep']['type']);
        final answer = {
          "body": {
            "request": "accept",
            "uri":
                "sip:${_preferences?.getString('destination')}@${_preferences?.getString('domain')}"
          },
          "janus": "message",
          "handle_id": _handleID,
          "session_id": _sessionID,
          "transaction": "$_transactionID",
          "jsep": {"sdp": "${_description?.sdp}", "type": "answer"},
        };
        this.send(answer);

        break;
      default:
        print("PARSED MESSAGE >> $_message");
        break;
    }
  }

  ObserverList<Function> _listeners = new ObserverList<Function>();

  addListener(Function callback) {
    _listeners.add(callback);
  }

  removeListener(Function callback) {
    _listeners.remove(callback);
    _reset();
  }

  start() {
    if (_channel != null) {
      if (_channel?.sink != null && _onConnected) {
        final String trans = _generateID(12);
        final _create = {'janus': 'create', 'transaction': '$trans'};
        send(_create);
        return;
      }
    }

    print("DEBUG ::: FAILED WITH INITIAL START");
    _reset();
    try {
      /// connect
      _channel = new IOWebSocketChannel.connect('ws://localhost:8188',
          protocols: ['janus-protocol']);
      _onConnected = true;

      if (_channel != null) {
        _loadSettings();
        _sdpOffer();
        _transactionID = _generateID(12);
        _keepAlive();
      }

      final String trans = _generateID(12);
      final _create = {'janus': 'create', 'transaction': '$trans'};
      send(_create);

      /// listen for events
      _channel?.stream.listen(onMessage);
    } catch (e) {
      throw e;
    }
  }

  hangup() {
    print("DEBUG ::: PRESEED HANUP");
    final _hangup = {
      "janus": "message",
      "body": {
        "request": "hangup",
      },
      "handle_id": _handleID,
      "session_id": _sessionID,
      "transaction": "$_transactionID",
    };
    this.send(_hangup);
  }

  _sdpOffer() async {
    if (_channel != null) {
      final Map<String, dynamic> mediaConstraints = {
        "audio": true,
        "video": null
      };
      _stream = await navigator.getUserMedia(mediaConstraints);
      if (this.onLocalStream != null) this.onLocalStream(_stream);
      _pc = await createPeerConnection(configuration, _config);
      _pc?.onIceGatheringState = (state) async {
        if (state == RTCIceGatheringState.RTCIceGatheringStateComplete) {
          await _pc?.getLocalDescription();
        }
      };
      _pc?.addStream(_stream!);
      _description = await _pc?.createOffer(_constraints);
      _pc?.setLocalDescription(_description!);
    }
  }

  _sdpAnswer(data) async {
    if (_pc == null) return;
    _pc?.setRemoteDescription(new RTCSessionDescription(data, 'answer'));
  }

  _sdpIncomingAnswer(String sdp, String type) async {
    if (_channel != null) {
      final Map<String, dynamic> mediaConstraints = {
        "audio": true,
        "video": null
      };
      _stream = await navigator.getUserMedia(mediaConstraints);
      if (this.onLocalStream != null) this.onLocalStream(_stream);
      _pc = await createPeerConnection(configuration, _config);
      _pc?.setRemoteDescription(RTCSessionDescription(sdp, type));
      _pc?.addStream(_stream!);
      _description = await _pc?.createAnswer(_constraints);

      _pc?.setLocalDescription(_description!);
    }
  }

  _loadSettings() async {
    _preferences = await SharedPreferences.getInstance();
  }

  _generateID(int len) {
    String pool =
        "abcdefghilklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
    Random random = new Random();
    List<int> units = new List.generate(
      len,
      (index) {
        return pool.codeUnitAt(random.nextInt(61));
      },
    );
    return String.fromCharCodes(units);
  }

  _keepAlive() {
    Timer.periodic(Duration(seconds: 30), (timer) {
      if (!_onAnswered) {
        timer.cancel();
      }
      final _keep = {
        "janus": "keepalive",
        "session_id": _sessionID,
        "transaction": _transactionID
      };
      this.send(_keep);
    });
  }
}
