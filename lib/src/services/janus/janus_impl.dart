import 'package:JanusSIPClient/src/services/janus/janus_manager.dart';
import 'package:JanusSIPClient/src/services/janus/janus_protocol.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:web_socket_channel/io.dart';

class JanusImplementation implements JanusProtocol {
  JanusImplementation(this.manager);

  final JanusManager manager;

  MediaStream? onLocalStream;
  List<MediaStream>? onRemoteStreams;

  final Map<String, dynamic> mediaConstraints = {
    'mandatory': {
      'OfferToReceiveAudio': true,
      'OfferToReceiveVideo': false,
    },
    'optional': [],
  };

  final Map<String, dynamic> constraints = {
    'mandatory': {},
    'optional': [
      {'DtlsSrtpKeyAgreement': true},
    ],
  };

  final Map<String, dynamic> rtcConfiguration = {
    'iceServers': [
      {'urls': "stun:stun.l.google.com:19302"},
      {'urls': "stun:stun1.l.google.com:19302"},
      {'urls': "stun:stun2.l.google.com:19302"},
      {'urls': "stun:stun3.l.google.com:19302"},
      {'urls': "stun:stun4.l.google.com:19302"}
    ]
  };

  Future initWebsocketConnection() async {
    try {
      manager.webSocketChannel = new IOWebSocketChannel.connect(
        Uri.parse('wss://ws.postman-echo.com/raw'),
      );

      listenWebsocketConnection();
    } catch (error) {
      print('error: $error');
      throw error;
    }
  }

  Future deInitWebsocketConnection() async {
    try {
      manager.webSocketChannel.sink.close();

    } catch (error) {
      print('error: $error');
      throw error;
    }
  }

  void listenWebsocketConnection() {
    manager.webSocketChannel.stream
        .listen(onMessage, onError: onError, onDone: onDone);
  }

  Future initPeerConnection() async {
    manager.peerConnection =
        await createPeerConnection(rtcConfiguration, constraints);
  }

  void configureAudioSession() {}

  void configureLocalAudioSenders() async {
    if (onLocalStream?.active ?? false) return;

    onLocalStream = await manager.mediaStream;
    manager.peerConnection.addStream(onLocalStream!);
  }

  void offer() async {
    await initPeerConnection();

    RTCSessionDescription sessionDescription =
        await manager.peerConnection.createOffer(constraints);
    await manager.peerConnection.setLocalDescription(sessionDescription);
  }

  void answer() {}

  void setRemoteSessionDescription(String sdp) {
    manager.peerConnection
        .setRemoteDescription(new RTCSessionDescription(sdp, 'answer'));
  }

  void send(dynamic message) {
    manager.webSocketChannel.sink.add(message);
  }

  void onMessage(dynamic received) {
    print('onMessage: $received');
  }

  void onError(dynamic error) {
    throw error;
  }

  void onDone() {
    print('onDone');
  }

  @override
  void declineCall() {
    destroyCall();
  }

  @override
  void hangupCall() {
    destroyCall();
  }

  @override
  void destroyCall() async {
    await deInitWebsocketConnection();
  }

  @override
  void Function(bool p1) incoming() {
    throw UnimplementedError();
  }

  @override
  void outgoingCall(String callDestination) async {
    await initWebsocketConnection();
  }

  @override
  void startSession() async {

  }
}
