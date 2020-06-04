import 'dart:async';
import 'package:flutter/material.dart';
import 'package:janus_sip_client/src/communication/janus.dart';
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
    _startTimer();
    janus.start();
  }

  @override
  void deactivate() {
    janus.removeListener(_onData);
    super.deactivate();
  }

  Widget _buildContent() {
    if (_callStatus == null) _callStatus = "calling...";
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
                      style: TextStyle(fontSize: 24, color: Colors.black54),
                    ))),
            Center(
                child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      '$_callStatus',
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ))),
            Center(
                child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Text(_timeLabel,
                        style: TextStyle(fontSize: 14, color: Colors.black54))))
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
        fillColor: Colors.red,
        onPressed: () {
          janus.hangup();
          if (_timer != null) _timer.cancel();
          Timer(Duration(seconds: 2), () {
            Navigator.of(context).pop();
          });
        });

    var basicActions = <Widget>[];

    // hangup
    basicActions.add(_hangup);

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

  Timer _timer;
  String _timeLabel = '00:00';

  SharedPreferences _preferences;
  String _destination;
  String _callStatus;

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
    _destination = _preferences.getString('destination');
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
            print("DEBUG ::: JANUS NOW FALSE >>> ${janus.status}");
            _backToDialPad();
          } else {
            if (janus.callStatus && !janus.callAnswerd) {
              _callStatus = "ringing...";
            } else if (janus.callAnswerd) {
              _callStatus = "connected!";
            }
          }
        });
      } else {
        _timer.cancel();
      }
    });
  }

  void _backToDialPad() {
    _timer.cancel();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pop();
    });
  }
}
