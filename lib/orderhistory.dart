import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Order_History extends StatefulWidget {
  Order_History({Key key}) : super(key: key);

  var userdata;

  @override
  _Order_HistoryState createState() => _Order_HistoryState();
}

class _Order_HistoryState extends State<Order_History> {
  // String size=" ";
  String url = "https://pizzahuttest.herokuapp.com/api/userorders";

  String user_name;
  String email;

  Future<String> getSharedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var username = prefs.getString('username');
    var useremail = prefs.getString('email');
    setState(() {
      user_name = username;
      email = useremail;
    });
    return email;
    // pref.getString('mobilenumber', mobilenumber);
  }

  void getOrders() async {
    var user = await getSharedData();
    var map1 = {
      "email": user,
    };
    this.apiPost(url, map1);
  }

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  var data = [];

  Future<String> apiPost(String url, Map jsonMap) async {
    try {
      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(json.encode(jsonMap)));

      HttpClientResponse response = await request.close();

      String replay = await response.transform(utf8.decoder).join();

      httpClient.close();

      setState(() {
        var parsed = json.decode(replay);
        data = parsed;
        print(data);
      });
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.redAccent,
        title: new Center(
            child: new Text(
          'Your Orders',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )),
      ),
      body: new Container(
        child: orders(),
      ),
    );
  }

  Widget orders() {
    if (data.length == 0) {
      return new Center(
        child: Text(
          "Here are Your Orders",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
    } else {
      return new ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: new Card(
                child: new Row(
                  children: <Widget>[
                    new Stack(
                      children: <Widget>[
                        new Image.network(
                          data[index]['src'],

                          height: 120,
                          width: 120,
                          // color: Colors.transparent,
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: new Image.network(
                            data[index]['type'],

                            height: 20,
                            width: 20,
                            // color: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
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
                              SizedBox(
                                width: 15,
                              ),
                              new Text('₹${data[index]['price']}'),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          new Text(
                            data[index]['description'],
                            overflow: TextOverflow.clip,
                            style: TextStyle(color: Colors.black, height: 1.5),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          new Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new Chip(label: new Text(data[index]['size'])),
                              //new Chip(label: new Text(data[index]['crust']),)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    }
  }
}
