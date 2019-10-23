import 'package:flutter/material.dart';
import 'package:flutter_pizzadelivaryapp/cart.dart';
import 'package:flutter_pizzadelivaryapp/wowoffer.dart';
import 'package:flutter_pizzadelivaryapp/pizza.dart';
import 'package:flutter_pizzadelivaryapp/drinks.dart';
import 'package:flutter_pizzadelivaryapp/sides.dart';
import 'package:flutter_pizzadelivaryapp/desserts.dart';
import 'package:flutter_pizzadelivaryapp/home_page.dart';

class Tab_Nav extends StatefulWidget {
  var userdata;
  Tab_Nav({Key key}):super(key: key);
  @override
  _Tab_NavState createState() => _Tab_NavState();
}

class _Tab_NavState extends State<Tab_Nav> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.redAccent,
      title: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
//        SizedBox(
//          width: 50,
//        ),
        IconButton(
          icon: Image.asset(
            'assets/logo.png',
            fit: BoxFit.cover,
            width: 100,
            height: 100,
          ),
          alignment: Alignment.center,
          iconSize: 200,
          onPressed:
              () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => Home_Page(

                  )),
            );
          },
        ),
//        IconButton(
//            icon: Icon(
//              Icons.shopping_cart,
//              size: 30,
//              color: Colors.redAccent,
//            ),
//            onPressed: () {
//              Navigator.push(
//                context,
//                new MaterialPageRoute(builder: (context) => Cart()),
//              );
//            })
      ]),
    ),
      body: new TabBarView(
          children: <Widget>[
          //  WowOffer(userdata: widget.userdata,),
            Pizza(),
            Sides(),
            Drinks(),
            Dessert(),
          ],
      controller: tabController,),
      bottomNavigationBar:  new Material(

        color: Colors.black,

        child:  new TabBar(
          isScrollable: true,
          controller: tabController,
            tabs: <Widget>[
//              new Tab(
//                child: new Text("DEALS"),
//              ),
              new Tab(
                child: new Text("PIZZA"),
              ),
              new Tab(
                child: new Text("SIDES"),
              ),
              new Tab(
                child: new Text("BEVERAGES"),
              ),
              new Tab(
                child: new Text("DESSERTS"),
              )
            ],
          labelColor: Colors.red,
          unselectedLabelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.all(15.0),
          indicatorColor: Colors.red,
        ),

      ),
    );
  }
}

