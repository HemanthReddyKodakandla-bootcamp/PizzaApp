import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_pizzadelivaryapp/orderhistory.dart';
import 'package:flutter_pizzadelivaryapp/odersplasahscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart extends StatefulWidget {
  var data;
  var size;
  var userdata;
 // var crust;
  Cart(
      {Key key,
      @required this.data,
      @required this.size,
      //  @required this.crust
      })
      : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  String user_name;
  String email;

  void getSharedData() async{
    SharedPreferences prefs= await SharedPreferences.getInstance();

    var username=prefs.getString('username');
    var useremail= prefs.getString('email');
    setState(() {
      user_name = username;
      email = useremail;
    });
    // pref.getString('mobilenumber', mobilenumber);
  }
  void _showAlert(String text) {
    if (text.isEmpty) return;

    AlertDialog dialog = new AlertDialog(
      content: new Text(
        text,
        style: TextStyle(
          fontSize: 15.0,
        ),
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        new Text('close'),
      ],
    );

    showDialog(context: context, child: dialog);
  }

  String url = "https://pizzahuttest.herokuapp.com/api/orders";
  var data;

  Future<String> placeOrder(String url, Map jsonMap) async {
    try {
      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(json.encode(jsonMap)));

      HttpClientResponse response = await request.close();

      String replay = await response.transform(utf8.decoder).join();

      httpClient.close();

      var parsed = json.decode(replay);

      data = parsed;
      print(data);

//      if( response.statusCode == 200){
//
//        _showAlert("Order Placed Successfully");
//      }
//      else {
//        _showAlert("Order was not Placed Successfully");
//             }

      return parsed;
    } catch (error) {
      print(error.toString());
    }
  }

  saveOrder() {
    var map1 = {
      "email": email,
      //"user_name": user_name,
      "src": widget.data['src'],
      "type": widget.data['type'],
      "name": widget.data['name'],
      "price": widget.data['price'],
      "description": widget.data['description'],
      "size": widget.size,
     // "crust":widget.crust,
    };

    placeOrder(url, map1);

    Navigator.of(context)
        .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) {
      return new OrderSplashScreen();
    }));
  }

  @override
  void initState() {
    // TODO: implement initState
    print(widget.data);
    getSharedData();
    // print(widget.data.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.redAccent,
        title: new Container(
            alignment: Alignment.center,
            child: new Text(
              'Cart',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
      ),
      body: new Container(
        child: Center(
          child: itemsCart(),
        ),
      ),
    );
  }

  Widget itemsCart() {
    if (widget.data == null) {
      return new Center(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "You do not have any products in cart Yet",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      );
    } else {
      return new Container(
        child: ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: widget.data == null ? 0 : 1,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: new Card(
                  child: new Row(
                    children: <Widget>[
                      new Stack(
                        children: <Widget>[
                          new Image.network(
                            widget.data['src'],
                            height: 120,
                            width: 120,
                          ),
                          Positioned(
                            left: 5,
                            bottom: 0,
                            child: new Image.network(
                              widget.data['type'],
                              height: 20,
                              width: 20,
                              // color: Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                      new SizedBox(
                        width: 10,
                      ),
                      new Flexible(
                        child: new Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                new Text(
                                  widget.data['name'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                new Text('₹${widget.data['price']}'),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            new Text(
                              widget.data['description'],
                              overflow: TextOverflow.clip,
                              style:
                                  TextStyle(color: Colors.black, height: 1.5),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            new Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
//                                Size(),
                                new Chip(label: new Text(widget.size)),
                               // new Chip(label: new Text(widget.crust,),),
                              ],
                            ),
                            new RaisedButton(
                              onPressed: () {
                                saveOrder();
                              },
                              child: new Text(
                                'Check Out',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.green,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      );
    }
  }

  Widget Size() {
    if (widget.size != null) {
      return new Text("Size : ${widget.size}");
    } else
      return new Text('');
  }
}
