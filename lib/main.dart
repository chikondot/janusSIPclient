import 'package:JanusSIPClient/src/utilities/ClientStorage.dart';
import 'package:flutter/material.dart';

// views
import 'src/views/SplashView.dart';
import 'src/views/RegisterView.dart';
import 'src/views/HomeView.dart';
import 'src/views/CallView.dart';

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
      initialRoute: '/call',
      routes: {
        '/splash': (context) => SplashViewWidget(),
        '/register': (context) => RegisterViewWidget(),
        '/home': (context) => HomeViewWidget(),
        '/call': (context) => CallViewWidget(),
      },
    );
  }
}
