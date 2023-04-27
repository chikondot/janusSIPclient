import 'package:JanusSIPClient/src/utilities/ClientStorage.dart';
import 'package:flutter/material.dart';

// views
import 'src/views/SplashView.dart';
import 'src/views/RegisterView.dart';
import 'src/views/callhomebasic.dart';
import 'src/views/callscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Storage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Janus SIP Client',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashViewWidget(),
        '/register': (context) => RegisterViewWidget(),
        '/home': (context) => CallInputWidget(),
        '/call': (context) => CallScreenWidget(),
      },
    );
  }
}
