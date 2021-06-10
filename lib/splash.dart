import 'package:flutter/material.dart';
import 'package:listproject/page/home.dart';

class Splash extends StatefulWidget {
  Splash({Key key}) : super(key: key);
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  double _width = 200;
  double _height = 100;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2)).then((_) {
      setState(() {
        _width = 300;
        _height = 150;
      });
    });
    Future.delayed(Duration(seconds: 4)).then((_) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Home()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedContainer(
              width: _width,
              height: _height,
              duration: Duration(milliseconds: 400),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("asset/logo.png"),
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
