import 'dart:async';
import 'package:flutter/material.dart';
import 'package:JanusSIPClient/src/utilities/ClientAssets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashWidget extends StatefulWidget {
  @override
  _SplashWidgetState createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  // variable definitions
  bool _isLoading = false;
  bool _failed = false;

  // persistent storage
  SharedPreferences? _preferences;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    _preferences = await SharedPreferences.getInstance();
    await _getPermissions();
    await _login();
  }

  @override
  dispose() {
    super.dispose();
  }

  Future _getPermissions() async => await [
      Permission.contacts,
      Permission.microphone,
      Permission.notification,
      Permission.camera,
    ].request();

  // get authorization token for login
  Future _login() async {
    this.setState(() {
      _failed = false;
      _isLoading = true;
    });

    Timer(Duration(seconds: 7), () {
      // check person has ever registered before
      if (_preferences!.containsKey('loggedIn')) {
        Navigator.pop(context);
        Navigator.pushNamed(context, '/test');
      } else {
        // else proceed to registration page
        Navigator.pop(context);
        Navigator.pushNamed(context, '/register');
      }
    });

    this.setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: SizedBox(
                    height: 155.0,
                    child: Image.asset(
                      "${Assets.splashScreenLogo}",
                    ),
                  ),
                ),
                _failed
                    ? SizedBox(
                        height: 30.0,
                      )
                    : Container(),
                _failed
                    ? OutlinedButton(
                        onPressed: () {
                          _login();
                        },
                        child: Text("Retry"),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
