import 'package:flutter/material.dart';

// views
import 'src/views/splash.dart';
import 'src/views/callregisterbasic.dart';
import 'src/views/callhomebasic.dart';
import 'src/views/callscreen.dart';
import 'src/views/dialpad.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Janus SIP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashWidget(),
        '/call': (context) => CallScreenWidget(),
        '/test': (context) => CallInputWidget(),
        '/local': (context) => CallSimpleRegisterWidget(),
      },
    );
  }
}
