import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_pizzadelivaryapp/home_page.dart';
import 'package:flutter_pizzadelivaryapp/login.dart';
import 'package:flutter_pizzadelivaryapp/orderhistory.dart';

class OrderSplashScreen extends StatefulWidget {
  var userdata;

  OrderSplashScreen({Key key}) : super(key: key);

  @override
  _OrderSplashScreenState createState() => new _OrderSplashScreenState();
}

class _OrderSplashScreenState extends State<OrderSplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context)
        .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) {
      return new Order_History( );
    }));
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        color: Colors.amber[50],
          child: Center(
        child: new Image.asset(
          'assets/ordersplash.gif',
          height: 400,
          width: 400,
        ),
      )),
    );
  }
}
