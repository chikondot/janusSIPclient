import 'package:flutter/material.dart';

// views
import 'src/views/splash.dart';
import 'src/views/callregisterbasic.dart';
import 'src/views/callhomebasic.dart';
import 'src/views/callscreen.dart';
import 'src/views/dialpad.dart';
import 'src/views/register.dart';
import 'src/views/home.dart';

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
        // '/': (context) => DialPadWidget(
        //       // define connection information of server
        //       channel: IOWebSocketChannel.connect('ws://erp.durihub.co.zw:8188',
        //           protocols: ['janus-protocol']),
        //     ),
        '/splash': (context) => SplashWidget(),
        // '/register': (context) => RegisterWidget(),
        // '/home': (context) => HomeWidget(),
        '/call': (context) => CallScreenWidget(),
        '/test': (context) => CallInputWidget(),
        '/local': (context) => CallSimpleRegisterWidget(),
      },
    );
  }
}
