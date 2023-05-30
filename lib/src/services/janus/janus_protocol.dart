// define protocol for call handling here
abstract class JanusProtocol {

  void hangupCall();

  void declineCall();

  void destroyCall();

  void outgoingCall(String callDestination);

  void Function(bool) incoming();

  void startSession();
}
