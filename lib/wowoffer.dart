import 'package:flutter/material.dart';
import 'package:flutter_pizzadelivaryapp/home_page.dart';
import 'package:flutter_pizzadelivaryapp/cart.dart';
import 'package:flutter_pizzadelivaryapp/tabbarnav.dart';
import 'package:flutter_pizzadelivaryapp/pizza.dart';
class WowOffer extends StatefulWidget {
  WowOffer({Key key, @required this.userdata}) : super(key: key);

  var userdata;

  @override
  _WowOfferState createState() => _WowOfferState();
}

class _WowOfferState extends State<WowOffer> {

  String selected_size=null;
  String selected=null;
  String size_selected=null;
  List<DropdownMenuItem<String>> values = [];

  loadDrop() {
    values.add(new DropdownMenuItem(
      child: new Text('Small'),
      value: 'Small',
    ));
    values.add(new DropdownMenuItem(
      child: new Text('Medium'),
      value: 'Medium',
    ));
    values.add(new DropdownMenuItem(
      child: new Text('Large'),
      value: 'Large',
    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDrop();
  }
     @override
  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        automaticallyImplyLeading: false,
//        backgroundColor: Colors.white70,
//        title: new Row(children: <Widget>[
//          SizedBox(
//            width: 50,
//          ),
//          IconButton(
//            icon: Image.asset(
//              'assets/logo.png',
//              fit: BoxFit.cover,
//              width: 100,
//              height: 100,
//            ),
//            alignment: Alignment.center,
//            iconSize: 200,
//            onPressed: () {
//              Navigator.push(
//                context,
//                new MaterialPageRoute(
//                    builder: (context) => Home_Page(
//                          userdata: widget.userdata,
//                        )),
//              );
//            },
//          ),
//          IconButton(
//              icon: Icon(
//                Icons.shopping_cart,
//                size: 30,
//                color: Colors.redAccent,
//              ),
//              onPressed: () {
//                Navigator.push(
//                  context,
//                  new MaterialPageRoute(builder: (context) => Cart()),
//                );
//              })
//        ]),
//      ),
//      body:
    return new Container(
       child: ListView(
        children: <Widget>[
         // currentPage,
          Row(
           // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new Text(
                'DEALS',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            child: new Card(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.network('https://i.imgur.com/2OnopRT.png',
                      height: 200, width: 400, alignment: Alignment.center),
                  SizedBox(
                    height: 10,
                  ),
                  new Text(
                    'Medium Pizzas At An Amazing Price of 199 Each',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  new Text(
                    'Enjoy 2 Tastiest Medium Pan Pizzas From Margharita Classic Corn & Classic tomato',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //  FloatingActionButton
                  Divider(
                    height: 2,
                    color: Colors.black87,
                  ),
                  new Row(
                   // mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Text('Price:',style: TextStyle(fontSize: 20,color: Colors.black),),
                      new Text('₹199',style: TextStyle(fontSize: 20,color: Colors.redAccent,fontWeight: FontWeight.bold),)
                    ],
                  ),
//                  new Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: <Widget>[
//                      new DropdownButton(
//                        value: selected,
//                        items: values,
//                        hint: Text('Size'),
//                        onChanged: (value) {
//                          selected=value;
//                          setState(() {
//
//                          });
//                        },
//
//                      ),
//                      RaisedButton(
//                        onPressed: () {
//                          Navigator.push(context,
//                              new MaterialPageRoute(builder: (context) => Cart()));
//                        },
//                        child: new Text(
//                          "Order",
//                          style: TextStyle(color: Colors.white,fontSize: 20),
//                        ),
//                        color: Colors.green,
//                      )
//                    ],
//                  ),

                ],
              ),
            ),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => Pizza(userdata: widget.userdata)));
              }
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            child: new Card(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.network('https://i.imgur.com/2OnopRT.png',
                      height: 200, width: 400, alignment: Alignment.center),
                  SizedBox(
                    height: 10,
                  ),
                  new Text(
                    'Medium Pizzas At An Amazing Price of 199 Each',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  new Text(
                    'Enjoy 2 Tastiest Medium Pan Pizzas From Margharita Classic Corn & Classic tomato',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //  FloatingActionButton
                  Divider(
                    height: 2,
                    color: Colors.black87,
                  ),
                  new Row(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Text('Price:',style: TextStyle(fontSize: 20,color: Colors.black),),
                      new Text('₹199',style: TextStyle(fontSize: 20,color: Colors.redAccent,fontWeight: FontWeight.bold),)
                    ],
                  ),
//                  new Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: <Widget>[
//                      new DropdownButton(
//                        value: selected_size,
//                        items: values,
//                        hint: Text('Size'),
//                        onChanged: (value) {
//                          selected_size=value;
//                          setState(() {
//
//                          });
//                        },
//
//                      ),
//                      RaisedButton(
//                        onPressed: () {
//                          Navigator.push(context,
//                              new MaterialPageRoute(builder: (context) => Cart()));
//                        },
//                        child: new Text(
//                          "Order",
//                          style: TextStyle(color: Colors.white,fontSize: 20),
//                        ),
//                        color: Colors.green,
//                      )
//                    ],
//                  ),

                ],
              ),
            ),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => Pizza(userdata: widget.userdata)));
              }
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            child: new Card(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.network('https://i.imgur.com/2OnopRT.png',
                      height: 200, width: 400, alignment: Alignment.center),
                  SizedBox(
                    height: 10,
                  ),
                  new Text(
                    'Medium Pizzas At An Amazing Price of 199 Each',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  new Text(
                    'Enjoy 2 Tastiest Medium Pan Pizzas From Margharita Classic Corn & Classic tomato',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //  FloatingActionButton
                  Divider(
                    height: 2,
                    color: Colors.black87,
                  ),
                  new Row(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Text('Price:',style: TextStyle(fontSize: 20,color: Colors.black),),
                      new Text('₹199',style: TextStyle(fontSize: 20,color: Colors.redAccent,fontWeight: FontWeight.bold),)
                    ],
                  ),
//                  new Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: <Widget>[
//                      new DropdownButton(
//                        value: size_selected,
//                        items: values,
//                        hint: Text('Size'),
//                        onChanged: (value) {
//                          size_selected=value;
//                          setState(() {
//
//                          });
//                        },
//
//                      ),
//                      RaisedButton(
//                        onPressed: () {
//                          Navigator.push(context,
//                              new MaterialPageRoute(builder: (context) => Cart()));
//                        },
//                        child: new Text(
//                          "Order",
//                          style: TextStyle(color: Colors.white,fontSize: 20),
//                        ),
//                        color: Colors.green,
//                      )
//                    ],
//                  ),

                ],
              ),
            ),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => Pizza(userdata: widget.userdata)));
              }
          ),
        ],
      ),

    );
  }
}
