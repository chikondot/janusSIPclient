import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/webrtc.dart';
import 'package:web_socket_channel/io.dart';

class DialPadWidget extends StatefulWidget {
  final IOWebSocketChannel channel;

  DialPadWidget({Key key, @required this.channel}) : super(key: key);

  @override
  _DialPadWidget createState() => _DialPadWidget();
}

class _DialPadWidget extends State<DialPadWidget> {
  /// initiate connection to websocket server
  IOWebSocketChannel get _socket => widget.channel;

  Map<String, dynamic> _message;
  int _sessionID;
  int _handleID;

  RTCSessionDescription _description;
  MediaStream _stream;
  RTCPeerConnection _pc;
  dynamic onLocalStream;
  dynamic onRemoteStream;
  dynamic _sdp;

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
  bool _onConnected = false;

  // TOREMOVE
  List<Object> _show = new List<Object>();

  // show time on call
  String _timeLabel = '00:00';
  Future<String> _callState;
  Timer _timer;

  // **********************************************************************
  // _media() async {
  //   try {
  //     final pc = RTCPeerConnection(_sessionID.toString(), configuration);
  //     final _offer = await pc.createOffer(_constraints);
  //     await print("DEBUG ::: CREATED OFFER >>> $_offer");
  //     return _offer;
  //   } catch (e) {
  //     print("DEBUG ::: GOT OFFER CREATION ERROR");
  //     throw e;
  //   }
  // }
  // **********************************************************************

  @override
  void initState() {
    super.initState();
    _makeSDP();
  }

  @override
  void dispose() {
    _socket.sink.close();
    super.dispose();
  }

  /// -------------------------------------------------------------------
  /// Widget funtion to controll UI
  /// -------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final _create = {'janus': 'create', 'transaction': '${_generateID(12)}}'};
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Flutter Janus SIP'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          StreamBuilder(
            stream: _socket.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _message = json.decode(snapshot.data);
                _show.add(snapshot.data);
              } else {
                return Center(child: CircularProgressIndicator());
              }

              print("DEBUG :::: PARSED MESSAGE >> $_message");

              switch (_message['janus']) {
                case 'success':
                  if (!_onAttach) {
                    final _attach = {
                      "janus": "attach",
                      "plugin": "janus.plugin.sip",
                      "transaction": "${_generateID(12)}",
                      "session_id": _message['data']['id'],
                    };
                    _send(_attach);
                    _onAttach = true;
                    _sessionID = _message['data']['id'];
                    break;
                  } else if (!_onRegister) {
                    final _register = {
                      "body": {
                        "authuser": "username",
                        "display_name": "username",
                        "ha1_secret": "md5ha1_password",
                        "proxy": "sip:domain:5060",
                        "request": "register",
                        "username": "sip:username@domain"
                      },
                      "handle_id": _message['data']['id'],
                      "janus": "message",
                      "session_id": _sessionID,
                      "transaction": "${_generateID(12)}"
                    };
                    _send(_register);
                    _onRegister = true;
                    _handleID = _message['data']['id'];
                    break;
                  }

                  break;
                case 'event':
                  if (_message['plugindata']['data']['error'] != null) {
                    print(
                        "EVENT ERROR >>> ${_message['plugindata']['data']['error']} >>> ${_message['plugindata']['data']['error_code']}");
                    print("PARSED MESSAGE >> $_message");

                    break;
                  }

                  switch (_message['plugindata']['data']['result']['event']) {
                    case "registering":
                      print("RESEND REGISTRATION >>>");
                      print("PARSED MESSAGE >> $_message");

                      break;
                    case "registered":
                      print("REGISTERED || MAKE CALL >>>");
                      print("PARSED MESSAGE >> $_message ::: $_description");

                      final _call = {
                        "body": {
                          "request": "call",
                          "uri": "sip:callee@domain"
                        },
                        "handle_id": _handleID,
                        "janus": "message",
                        "session_id": _sessionID,
                        "transaction": "${_generateID(12)}",
                        "jsep": {
                          "sdp": "${_description.sdp}",
                          "type": "${_description.type}"
                        },
                      };
                      _send(_call);
                      break;
                    case "calling":
                      print("CALLING >>>");
                      print("PARSED MESSAGE >> $_message");

                      break;
                    case "proceeding":
                      print("PROCEEDING >>>");
                      print("PARSED MESSAGE >> $_message");

                      break;
                    case "ringing":
                      print("RINGING >>>");
                      print("PARSED MESSAGE >> $_message");

                      break;
                    case "accepted":
                      print("ACCEPTED >>>");
                      print(
                          "PARSED MESSAGE >> $_message ::: ${_message['jsep']['sdp']}");

                      _sdpAnswer(_message['jsep']['sdp']);

                      if (_timeLabel == "00:00") {
                        _startTimer();
                      }

                      _onConnected = true;
                      break;
                    case "progress":
                      print("PROGRESS >>>");
                      print("PARSED MESSAGE >> $_message");

                      break;
                    case "hangup":
                      print("HANGUP >>>");
                      print("PARSED MESSAGE >> $_message");

                      if (_timer != null) _timer.cancel();
                      break;
                    default:
                  }
                  break;
                case 'ack':
                  print("ACK >>> ");
                  print("PARSED MESSAGE >> $_message");

                  break;
                case 'message':
                  print("MESSAGE >>> ");
                  print("PARSED MESSAGE >> $_message");

                  break;
                case 'trickle':
                  print("TRICKLE >>> ");
                  print("PARSED MESSAGE >> $_message");

                  break;
                case 'timeout':
                  print("TIMEOUT >>> CLOSING(); ");
                  print("PARSED MESSAGE >> $_message");

                  if (_timer != null) _timer.cancel();
                  if (_socket.sink != null) _socket.sink.close();
                  break;
                case 'detached':
                  print("DETACHED SESSION >>>");
                  print("PARSED MESSAGE >> $_message");

                  break;
                default:
                  print("PARSED MESSAGE >> $_message");
                  break;
              }
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Text(snapshot.hasData ? '$_message' : ''),
              );

              return new Flexible(
                child: ListView.builder(
                    itemCount: _show.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(children: <Widget>[
                        Text('$_callState + $_timeLabel'),
                        ListTile(
                          title:
                              Text(snapshot.hasData ? '${_show[index]}' : ''),
                        )
                      ]);
                    }),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _send(_create),
        tooltip: 'Start Session',
        child: Icon(Icons.call),
      ),
    );
  }

  /// -------------------------------------------------------------------
  /// functions and methods
  /// -------------------------------------------------------------------

  /// generates random string of specified length
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

  /// send message to server for action
  _send(Object message) {
    if (_socket.sink != null) {
      _socket.sink.add(json.encode(message));
    }
  }

  // keep track of time spent on call
  _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      Duration duration = Duration(seconds: timer.tick);
      if (mounted) {
        this.setState(() {
          _timeLabel = [duration.inMinutes, duration.inSeconds]
              .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
              .join(':');
        });
      } else {
        _timer.cancel();
      }
    });
  }

  _makeSDP() async {
    if (_socket != null) {
      final Map<String, dynamic> mediaConstraints = {
        "audio": true,
        "video": null
      };
      _stream = await navigator.getUserMedia(mediaConstraints);
      if (this.onLocalStream != null) this.onLocalStream(_stream);
      _pc = await createPeerConnection(configuration, _config);
      _pc.onIceGatheringState = (state) async {
        if (state == RTCIceGatheringState.RTCIceGatheringStateComplete) {
          print('DEBUG ::: RTCIceGatheringStateComplete'); // TODO : fix
          RTCSessionDescription sdp = await _pc.getLocalDescription();
        }
      };
      _pc.addStream(_stream);
      _description = await _pc.createOffer(_constraints);
      print('DEBUG ::: SDP >>> createOffer ${_description.sdp}');
      _pc.setLocalDescription(_description);
    }
  }

  _sdpAnswer(data) async {
    if (_pc == null) return;
    _pc.setRemoteDescription(new RTCSessionDescription(data, 'answer'));
  }
}