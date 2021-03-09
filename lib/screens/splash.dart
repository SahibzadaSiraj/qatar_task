import 'dart:async';
import 'package:flutter/material.dart';
import 'package:task/screens/home.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool move = false;

  startTime() async {
    var _duration = new Duration(seconds: 2);
    var animationDuration = Duration(milliseconds: 200);
    Timer(
        animationDuration,
        () => setState(() {
              move = true;
            }));
    return new Timer(_duration, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: AnimatedContainer(
        height: move ? 250 : 100,
        width: move ? 250 : 100,
        curve: Curves.linear,
        duration: Duration(seconds: 2),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/logo.jpg'), fit: BoxFit.contain)),
      ),
    ));
  }
}
