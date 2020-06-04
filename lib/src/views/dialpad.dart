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
                        "authuser": "08644004295",
                        "display_name": "08644004295",
                        "ha1_secret": "8d669e466c42183cc23139f2c3510807",
                        "proxy": "sip:talk.tauraonline.com:5060",
                        "request": "register",
                        "username": "sip:08644004295@talk.ai.co.zw"
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
                          "uri": "sip:00263775612954@talk.ai.co.zw"
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

// "v=0\r\n"
// "o=- 258042953355505525 2 IN IP4 127.0.0.1\r\n"
// "s=-\r\n"
// "t=0 0\r\n"
// "a=group:BUNDLE 0\r\n"
// "a=msid-semantic: WMS tKvIA9w2TPQSWeFrk3H3xQGhgPX4oOV1soSZ\r\n"
// "m=audio 9 UDP/TLS/RTP/SAVPF 111 103 104 9 0 8 106 105 13 110 112 113 126\r\n"
// "c=IN IP4 0.0.0.0\r\n"
// "a=rtcp:9 IN IP4 0.0.0.0\r\n"
// "a=ice-ufrag:ZsEq\r\n"
// "a=ice-pwd:An7mmDNyTDH5jbMxFqt54WN8\r\n"
// "a=ice-options:trickle\r\n"
// "a=fingerprint:sha-256 05:CE:C7:DC:D0:84:E0:84:E3:1E:59:E9:56:8D:80:DD:72:39:EA:76:C9:BD:2B:42:4C:41:6E:C5:D2:9E:F1:E5\r\n"
// "a=setup:actpass\r\n"
// "a=mid:0\r\n"
// "a=extmap:1 urn:ietf:params:rtp-hdrext:ssrc-audio-level\r\n"
// "a=extmap:2 http://www.webrtc.org/experiments/rtp-hdrext/abs-send-time\r\n"
// "a=extmap:3 http://www.ietf.org/id/draft-holmer-rmcat-transport-wide-cc-extensions-01\r\n"
// "a=extmap:4 urn:ietf:params:rtp-hdrext:sdes:mid\r\n"
// "a=extmap:5 urn:ietf:params:rtp-hdrext:sdes:rtp-stream-id\r\n"
// "a=extmap:6 urn:ietf:params:rtp-hdrext:sdes:repaired-rtp-stream-id\r\n"
// "a=sendrecv\r\n"
// "a=msid:tKvIA9w2TPQSWeFrk3H3xQGhgPX4oOV1soSZ 5affec90-56b1-4954-ac9e-1237b6ec032c\r\n"
// "a=rtcp-mux\r\n"
// "a=rtpmap:111 opus/48000/2\r\n"
// "a=rtcp-fb:111 transport-cc\r\n"
// "a=fmtp:111 minptime=10;useinbandfec=1\r\n"
// "a=rtpmap:103 ISAC/16000\r\n"
// "a=rtpmap:104 ISAC/32000\r\n"
// "a=rtpmap:9 G722/8000\r\n"
// "a=rtpmap:0 PCMU/8000\r\n"
// "a=rtpmap:8 PCMA/8000\r\n"
// "a=rtpmap:106 CN/32000\r\n"
// "a=rtpmap:105 CN/16000\r\n"
// "a=rtpmap:13 CN/8000\r\n"
// "a=rtpmap:110 telephone-event/48000\r\n"
// "a=rtpmap:112 telephone-event/32000\r\n"
// "a=rtpmap:113 telephone-event/16000\r\n"
// "a=rtpmap:126 telephone-event/8000\r\n"
// "a=ssrc:1239556158 cname:agb9/Wasm3Fu45fz\r\n"
// "a=ssrc:1239556158 msid:tKvIA9w2TPQSWeFrk3H3xQGhgPX4oOV1soSZ 5affec90-56b1-4954-ac9e-1237b6ec032c\r\n"
// "a=ssrc:1239556158 mslabel:tKvIA9w2TPQSWeFrk3H3xQGhgPX4oOV1soSZ\r\n"
// "a=ssrc:1239556158 label:5affec90-56b1-4954-ac9e-1237b6ec032c\r\n",

// {
// janus: event,
// session_id: 2604698661453638,
// transaction: tL7y4AQwe23G,
// sender: 875381864261680,
// plugindata: {
//   plugin: janus.plugin.sip,
//   data: {
//     sip: event,
//     result: {
//       event: accepted,
//       username: sip:00263776519399@talk.ai.co.zw
//     },
//   call_id: PKdhtXMmr18n2L9K88eMlGn
//   }
// },
// jsep: {
//   type: answer,
//   sdp: v=0
// }
// }
