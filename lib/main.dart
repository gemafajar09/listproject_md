import 'package:flutter/material.dart';
import 'package:listproject/auth/login.dart';
import 'package:listproject/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final router = <String, WidgetBuilder>{
    '/': (_) => Login(),
    '/splash': (_) => Splash(),
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      routes: router,
      initialRoute: '/',
    );
  }
}
