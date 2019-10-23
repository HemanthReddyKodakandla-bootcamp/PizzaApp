import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_pizzadelivaryapp/home_page.dart';
import 'package:flutter_pizzadelivaryapp/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/animation.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  startTime() async {
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, navigationPage);
  }

  var useremail;
  var password;
  String url = "https://pizzahuttest.herokuapp.com/api/login";

  void getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    var pass = prefs.getString('password');
    setState(() {
      useremail = email;
      password = pass;
    });
  }

  Animation<double> animation;
  AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmail();
    startTime();
    animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = Tween<double>(begin: 20.0,end: 150.0).animate(animationController);

    animation.addListener(
            () {
          setState(() {

          });
        }
    );
    animation.addStatusListener((status) => print(status));
    animationController.forward();
  }


  void navigationPage() async {
    if (useremail == null) {
      Navigator.of(context).pushReplacementNamed('/login');
    } else {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (BuildContext context) {
            return new Home_Page();
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
          child: Center(
            child:Container(
              height: animation.value,
              width: animation.value,
        child: new Image.asset(
          'assets/splash.png',
          height: 150,
          width: 150,
        ),
            ),
      )),
    );
  }

}