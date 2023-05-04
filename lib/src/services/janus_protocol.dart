// define protocol for call handling here
abstract class JanusProtocol {
  void destroyCall();

  void hangupCall();

  void declineCall();

  void outgoingCall(String callDestination);

  void Function(bool) incoming();
}
