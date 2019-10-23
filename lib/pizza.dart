import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_pizzadelivaryapp/cart.dart';
import 'package:flutter_pizzadelivaryapp/favorites.dart';
import 'package:flutter_pizzadelivaryapp/customize.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Pizza extends StatefulWidget {
  Pizza({Key key, @required this.userdata}) : super(key: key);

  var userdata;

  @override
  _PizzaState createState() => _PizzaState();
}

class _PizzaState extends State<Pizza> {
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
        new FlatButton(
            onPressed: () {
              //moveToLogin();
              Navigator.pop(context);
            },
            child: new Text('Cancel'))
      ],
    );

    showDialog(context: context, barrierDismissible: false, child: dialog);
  }

  String url = "https://pizzahuttest.herokuapp.com/api/pizzas";
  String size_selected = null;
  String items = "";
  String selected = null;
  String selected_size = null;
  String size = "";
  String _errmsg = "";

  String giveSize(String s) {
    size = s;
    return size;
  }

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

//  String price = "199";
  bool _isFavorited = false;
  bool _isFavorite = false;
  bool _isFavourite = false;
  String _mySelection;

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _isFavorited = false;
      } else
        _isFavorited = true;
    });
  }
//
//  void _toggleFavorit() {
//    setState(() {
//      if (_isFavorite) {
//        _isFavorite = false;
//      } else
//        _isFavorite = true;
//    });
//  }
//
//  void _toggleFavourit() {
//    setState(() {
//      if (_isFavourite) {
//        _isFavourite = false;
//      } else
//        _isFavourite = true;
//    });
//   }
  @override
  void initState() {
    this.getApi();
    loadDrop();
    // size_selected.add("small");
    super.initState();
  }

  List<dynamic> data = List<dynamic>();

  Future getApi() async {
    http.Response response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    setState(() {
      var x = json.decode(response.body);
      data = x;
      // print(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(15),
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Card(
              elevation: 10,
              child: new Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Stack(
                        children: <Widget>[
                        new Image(image: new CachedNetworkImageProvider(data[index]['src']),height: 120,width: 120,),
//                          new Image.network(
//                            data[index]['src'],
//
//                            height: 120,
//                            width: 120,
//                            // color: Colors.transparent,
//                          ),

//                      Positioned(
//                        top: 0.0,
//                        left: 0.0,
//                        child: IconButton(
//                          icon: (_isFavorited
//                              ? Icon(Icons.favorite)
//                              : Icon(Icons.favorite_border)),
//                          color: Colors.red[500],
//                          onPressed: () {
//                            if (_isFavorited == false) {
//                              Navigator.of(context).push(new MaterialPageRoute(
//                                  builder: (BuildContext context) {
//                                return new Favorites(
//                                  data: data[index],
//                                  userdata: widget.userdata,
//                                );
//                              }));
//                            }
//                            _toggleFavorite();
//                          },
//                        ),
//                      ),
                          Positioned(
                            bottom: 5,
                            left: 5,
                            child: new Image.network(
                              data[index]['type'],

                              height: 20,
                              width: 20,
                              // color: Colors.transparent,
                            ),
                          )
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
                                  data[index]['name'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
//                            SizedBox(
//                              width: 20,
//                            ),
                                new Text('₹${data[index]['price']}'),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            new Row(
                              children: <Widget>[],
                            ),
                            new Text(
                              data[index]['description'],
                              overflow: TextOverflow.clip,
                              style:
                                  TextStyle(color: Colors.black, height: 1.5),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new RaisedButton(
                        onPressed: () {
                          // if (size_selected != null) {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) {
                            return new Customize(
                              data: data[index],
                              //  size: size_selected,
                            );
                          }));
//                      } else {
//                        setState(() {
//                          _errmsg = "please select size of pizza";
//                          _showAlert(_errmsg);
//                        });
//                      }
                        },
                        child: new Text(
                          'Add',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.green,
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
