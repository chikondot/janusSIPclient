import 'dart:async';
import 'package:flutter/material.dart';
import 'package:JanusSIPClient/src/services/janus.dart';
import 'package:JanusSIPClient/src/utilities/ClientAssets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/action_button.dart';

class CallScreenWidget extends StatefulWidget {
  @override
  _CallScreenWidget createState() => _CallScreenWidget();
}

class _CallScreenWidget extends State<CallScreenWidget> {
  @override
  void initState() {
    super.initState();
    _loadSettings();
    janus.start();
  }

  @override
  void deactivate() {
    janus.removeListener(_onData);
    super.deactivate();
  }

  Widget _buildContent() {
    // set ::: init calling states and information
    if (_callStatus == null) {
      _callStatus = "Calling";
      _callStatusColor = Assets.primaryColor;
    }
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
                      ('$_destination'),
                      style: TextStyle(fontSize: 24, color: Assets.blackColor),
                    ))),
            Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.play_circle_filled,
                  color: _callStatusColor,
                ),
                Padding(
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      '$_callStatus',
                      style: TextStyle(fontSize: 18, color:Assets.blackColor),
                    ))
              ],
            )),
            Center(
                child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Text(_timeLabel,
                        style: TextStyle(fontSize: 14, color: Assets.blackColor))))
          ],
        )),
      ),
    ]);

    return Stack(
      children: stackWidgets,
    );
  }

  Widget _buildButtons() {
    var _hangup = ActionButton(
        title: "hangup",
        icon: Icons.call_end,
        fillColor: Assets.redColor,
        onPressed: () {
          janus.hangup();
          if (_timer != null) _timer?.cancel();
          Timer(Duration(seconds: 2), () {
            Navigator.of(context).pop();
          });
        });

    var basicActions = <Widget>[];
    var advancedActions = <Widget>[];

    // hangup
    basicActions.add(_hangup);

    // mute button
    advancedActions.add(ActionButton(
      title: _audioMuted ? 'unmute' : 'mute',
      icon: _audioMuted ? Icons.mic_off : Icons.mic,
      checked: _audioMuted,
      onPressed: () => _muteAudio(),
    ));

    // speaker button
    advancedActions.add(ActionButton(
      title: _speakerOn ? 'speaker off' : 'speaker on',
      icon: _speakerOn ? Icons.volume_off : Icons.volume_up,
      checked: _speakerOn,
      onPressed: () => _toggleSpeaker(),
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

  Timer? _timer;
  String _timeLabel = '00:00';

  SharedPreferences? _preferences;
  String _destination = "";
  String _callStatus = "";
  Color? _callStatusColor;

  _onData(message) {
    print("DEBUG ::: GOT MESSAGE (CALL SCREEN ) >>> $message");
    switch (message) {
      case '':
        break;
      default:
        print('DEBUG ::: THERES A CASE! >>> $message');
    }
  }

  _loadSettings() async {
    _preferences = await SharedPreferences.getInstance();
    _destination = _preferences!.getString('destination')!;
    this.setState(() {});
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

          if (!janus.status) {
            _backToDialPad();
          } else {
            if (janus.callStatus && !janus.callAnswerd) {
              _callStatus = "Ringing";
              _callStatusColor = Assets.amberColor;
            } else if (janus.callAnswerd) {
              _callStatus = "Connected";
              _callStatusColor = Assets.greenColor;
              _startTimer();
            }
          }
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  void _backToDialPad() {
    _timer?.cancel();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pop();
    });
  }

  bool _audioMuted = false;
  bool _speakerOn = false;
  bool _hold = false;
  String _holdOriginator = "";

  void _muteAudio() {
    if (_audioMuted) {
      // remove from mute

    } else {
      // mute audio
    }
  }

  void _handleHold() {
    if (_hold) {
      // remove from hold
    } else {
      // put on hold
    }
  }

  void _toggleSpeaker() {
    if (janus.onLocalStream != null) {
      // put pa loud
      _speakerOn = !_speakerOn;
      janus.onLocalStream.getAudioTracks()[0].enableSpeakerphone(_speakerOn);
    }
  }
}
