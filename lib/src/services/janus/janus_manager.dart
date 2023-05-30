// protocol that will manage connection && state
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:web_socket_channel/io.dart';

class JanusManager {
  // network connection information
  late IOWebSocketChannel webSocketChannel;
  late RTCPeerConnection peerConnection;
  late RTCSessionDescription remoteSdp, incomingSdp;

  // state management information
  late String transactionId;
  late int sessionId, handleId;
  late bool onConnected, onAttached;

  Future<MediaStream> get mediaStream =>
      navigator.mediaDevices.getUserMedia({"audio": true, "video": null});
}

// TODO :: move bool state management to be more concise [onConnected, onAttached]
enum JanusState {
  CONNECTED,
  ATTACHED
}