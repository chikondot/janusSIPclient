import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:JanusSIPClient/src/utilities/ClientStorage.dart';
import 'package:JanusSIPClient/src/utilities/ClientStrings.dart';
import 'package:JanusSIPClient/src/utilities/ClientAssets.dart';

class SplashViewWidget extends StatefulWidget {
  @override
  SplashViewWidgetState createState() => SplashViewWidgetState();
}

class SplashViewWidgetState extends State<SplashViewWidget> {
  void initialViewInformation() async {
    checkPermissions();
    navigateRouteWithDelay(true);
  }

  /// PERMISSIONS ---
  Future<Map<Permission, PermissionStatus>>
      requestApplicationPermissions() async => await [
            Permission.contacts,
            Permission.microphone,
            Permission.notification,
            Permission.camera,
          ].request();

  void validateApplicationPermissions(
      Map<Permission, PermissionStatus> permissions) {
    permissions.forEach((key, value) {
      if (!value.isGranted) return;
    });
  }

  void checkPermissions() async {
    Map<Permission, PermissionStatus> permissions =
        await requestApplicationPermissions();
    validateApplicationPermissions(permissions);
  }

  /// ROUTE NAVIGATION ---
  void screenStateUpdate(Function() callback) => this.setState(callback);

  Future<bool> screenStateLoggedIn() async {
    return Storage.containsKey(Strings.loginPref);
  }

  String screenStateSetRoute(bool loggedIn) {
    return loggedIn ? "/home" : "/register";
  }

  void checkScreenState() async {
    var loggedIn = await screenStateLoggedIn();
    Navigator.of(context).popAndPushNamed(screenStateSetRoute(loggedIn));
  }

  void navigateRouteWithDelay(bool delay) {
    !delay
        ? checkScreenState()
        : Timer(Duration(seconds: 10), checkScreenState);
  }

  /// *************************************************************
  /// *********** MAIN BUILD FUNCTION *****************************
  /// *************************************************************

  @override
  void initState() {
    super.initState();
    initialViewInformation();
  }

  @override
  dispose() {
    super.dispose();
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
