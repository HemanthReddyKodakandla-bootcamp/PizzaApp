import 'package:flutter/material.dart';
import 'package:flutter_pizzadelivaryapp/home_page.dart';
import 'package:flutter_pizzadelivaryapp/splashscreen.dart';
import 'package:flutter_pizzadelivaryapp/login.dart';
import 'package:flutter_pizzadelivaryapp/formtest.dart';
import 'package:flutter_pizzadelivaryapp/orderhistory.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizza Hut',
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new Home_Page(),
        '/login': (BuildContext context) => new Login_User(),
        //'/orderhistory': (BuildContext context) => new Order_History(),
      },
      home: SplashScreen(),
    );
  }
}
