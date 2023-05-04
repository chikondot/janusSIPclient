import 'dart:async';
import 'package:JanusSIPClient/src/services/janus.dart';
import 'package:JanusSIPClient/src/services/janus_impl.dart';
import 'package:JanusSIPClient/src/services/janus_manager.dart';
import 'package:flutter/material.dart';

import 'package:JanusSIPClient/src/utilities/ClientStorage.dart';
import 'package:JanusSIPClient/src/utilities/ClientAssets.dart';

import 'widgets/action_button.dart';

class CallViewWidget extends StatefulWidget {
  @override
  CallViewWidgetState createState() => CallViewWidgetState();
}

class CallViewWidgetState extends State<CallViewWidget> with CallAudioManager, CallJanusManager {
  Timer? callScreenTimer;

  String callScreenTimerLabel = "00:00";
  String callScreenDestination = "";

  CallStatusManager currentCallStatus = CallStatusManager.nonActive;

  void initialViewInformation() async {
    callScreenDestination =
        (await Storage.getExistingString('callDestination'))!;
  }

  void persistViewInformation() async {}

  void screenStateUpdate(Function() callback) => this.setState(callback);

  void onBackButtonPressed() {
    janusImpl.outgoingCall("callDestination");

    // screenStateUpdate(handleCallTimerStop);
    // handlePageNavigation();
  }

  void handlePageNavigation() {
    Navigator.pop(context);
  }

  void updateCallStatus(CallStatusManager newCallStatus) {
    if (currentCallStatus != newCallStatus) currentCallStatus = newCallStatus;
  }

  void updateCallScreenTimerLabel(Duration duration) {
    callScreenTimerLabel = [duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  // keep track of time spent on call
  void handleCallTimerStart() async {
    if (callScreenTimer == null || callScreenTimer!.isActive) return;

    callScreenTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      Duration duration = Duration(seconds: timer.tick);
      if (mounted) {
        screenStateUpdate(() {
          updateCallScreenTimerLabel(duration);
        });
      } else {
        callScreenTimer?.cancel();
      }
    });
  }

  void handleCallTimerStop() {
    callScreenTimer?.cancel();
  }

  Widget _buildContent() {
    var stackWidgets = <Widget>[];
    stackWidgets.addAll([
      Positioned(
        top: 48,
        left: 0,
        right: 0,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                  child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(
                        ('$callScreenDestination'),
                        style:
                            TextStyle(fontSize: 24, color: Assets.blackColor),
                      ))),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.play_circle_filled,
                      color: currentCallStatus.color,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(
                        '${currentCallStatus.string}',
                        style:
                            TextStyle(fontSize: 18, color: Assets.blackColor),
                      ),
                    )
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Text(
                    callScreenTimerLabel,
                    style: TextStyle(fontSize: 14, color: Assets.blackColor),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ]);

    return Stack(
      children: stackWidgets,
    );
  }

  Widget _buildButtons() {
    var hangupButton = ActionButton(
        title: "hangup",
        icon: Icons.call_end,
        fillColor: Assets.redColor,
        onPressed: onBackButtonPressed);

    var basicActions = <Widget>[];
    var advancedActions = <Widget>[];

    basicActions.add(hangupButton);

    advancedActions.add(ActionButton(
      title: isMuteActive ? 'Mute On' : 'Mute Off',
      icon: isMuteActive ? Icons.mic : Icons.mic_off,
      checked: isMuteActive,
      onPressed: () => handleMuteAudio,
    ));

    advancedActions.add(ActionButton(
      title: isSpeakerActive ? 'Speaker On' : 'Speaker Off',
      icon: isSpeakerActive ? Icons.volume_up : Icons.volume_off,
      checked: isSpeakerActive,
      onPressed: handleSpeakerAudio,
    ));

    var actionWidgets = <Widget>[];
    actionWidgets.add(Padding(
        padding: const EdgeInsets.all(3),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: basicActions)));

    return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: actionWidgets);
  }

  /// *************************************************************
  /// *********** MAIN BUILD FUNCTION *****************************
  /// *************************************************************

  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: _buildContent()),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 24.0),
        child: Container(width: 320, child: _buildButtons()),
      ),
    );
  }
}

enum CallStatusManager {
  nonActive("No Call", Colors.red),
  initiated("Calling", Colors.amber),
  active("Active", Colors.green),
  held("Hold", Colors.grey);

  const CallStatusManager(this.string, this.color);

  final String string;
  final Color color;
}

class CallJanusManager {
  JanusImplementation janusImpl = JanusImplementation(new JanusManager());
}

class CallAudioManager {
  bool isMuteActive = false;
  bool isSpeakerActive = false;
  bool isHoldActive = false;
  String holdOriginator = "";

  void handleMuteAudio() {
    isMuteActive ? _handleMuteOff() : _handleMuteOn();
  }

  void _handleMuteOn() {
    isMuteActive = false;
  }

  void _handleMuteOff() {
    isMuteActive = true;
  }

  void handleHoldAudio() {
    isHoldActive ? _handleHoldOff() : _handleHoldOn();
  }

  void _handleHoldOn() {}

  void _handleHoldOff() {}

  void handleSpeakerAudio() {
    isSpeakerActive ? _handleSpeakerOff() : _handleSpeakerOn();
  }

  void _handleSpeakerOn() {}

  void _handleSpeakerOff() {}
}
