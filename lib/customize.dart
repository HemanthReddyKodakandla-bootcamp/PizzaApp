import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_pizzadelivaryapp/cart.dart';

class Customize extends StatefulWidget {
  Customize({Key key, @required this.data})
      : super(key: key);

  var userdata;

  var data;

  @override
  _CustomizeState createState() => _CustomizeState();
}

class _CustomizeState extends State<Customize> {
  void _showAddToCart() {
    if (select == false) {
      setState(() {
        select = true;
      });
    } else {
      setState(() {
        select = false;
      });
    }
  }
  String url = "https://pizzahuttest.herokuapp.com/api/customize";
  @override
  void initState() {
    this.getApi();

    // size_selected.add("small");
    super.initState();
  }

  List<dynamic> custdata = List<dynamic>();

  Future getApi() async {
    http.Response response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    setState(() {
      custdata = json.decode(response.body);

       print(custdata);
    });
  }
String size="";
  String crust="";

  bool select = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         //automaticallyImplyLeading: false,
        backgroundColor: Colors.redAccent,
        title: new Center(
            child: new Text(
          'Customize',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )),
      ),
      body: new Container(
        child: new ListView(
          padding: EdgeInsets.all(10),
          children: <Widget>[
            new Card(
              child: Stack(
                children: <Widget>[
                  new Image.network(
                    widget.data['src'],
                    width: 600,
                    height: 240,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                  Positioned(
                    top: 0,
                    left: 120,
                    child: new Text(
                      widget.data['name'],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            new Container(
              child: new Card(
                child: new Column(children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  new Text(
                    widget.data['description'],
                    style: TextStyle(color: Colors.black, fontSize: 15),
                    overflow: TextOverflow.clip,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ]),
              ),
            ),
            new Container(
              //padding: EdgeInsets.all(10),
              child: new Center(

                child:
                  button(size, crust, widget.data),

              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget button(String pizzasize,String pizzacrust,var data) {
    if (select == true) {
      if (custdata.isEmpty) return CircularProgressIndicator();
      else {
        return
          new Container(
            //padding: EdgeInsets.all(10),
            child: new Card(
              child: new Column(children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                new Text(
                  'Select Your Size and Crust',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                new Divider(
                  height: 2,
                  color: Colors.black,
                ),
                new Container(
                  padding: EdgeInsets.all(10),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        '${custdata[0]['size'][0]} | Serves 2',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                new Divider(
                  height: 2,
                  color: Colors.black,
                ),
                new Container(
                  padding: EdgeInsets.all(10),
                  //    color: Colors.grey[100],
                  child: GestureDetector(
                    child: new Row(
                      children: <Widget>[
                        new Image.asset(''),
                        new Text('${custdata[0]['crust'][0]}',
                            style:
                            TextStyle(color: Colors.black, fontSize: 15)),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        size = custdata[0]['size'][0];
                        crust = custdata[0]['crust'][0];
                      });
                      _showAddToCart();
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                new Divider(
                  height: 3,
                  color: Colors.black,
                ),
                new Container(
                  padding: EdgeInsets.all(10),
                  //  color: Colors.grey[100],
                  child: GestureDetector(
                    child: new Row(
                      children: <Widget>[
                        new Image.asset(''),
                        new Text('${custdata[0]['crust'][1]}',
                            style:
                            TextStyle(color: Colors.black, fontSize: 15)),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        size = custdata[0]['size'][0];
                        crust = custdata[0]['crust'][1];
                        print(size);
                        print(crust);
                      });
                      _showAddToCart();
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                new Divider(
                  height: 2,
                  color: Colors.black,
                ),
                new Container(
                  padding: EdgeInsets.all(10),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        '${custdata[0]['size'][1]} | Serves 1',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                new Divider(
                  height: 3,
                  color: Colors.black,
                ),
                new Container(
                  padding: EdgeInsets.all(10),
                  //  color: Colors.grey[100],
                  child: GestureDetector(
                    child: new Row(
                      children: <Widget>[
                        new Image.asset(''),
                        new Text('${custdata[0]['crust'][0]}',
                            style:
                            TextStyle(color: Colors.black, fontSize: 15)),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        size = custdata[0]['size'][1];
                        crust = custdata[0]['crust'][0];
                      });
                      _showAddToCart();
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                new Divider(
                  height: 3,
                  color: Colors.black,
                ),
                new Container(
                  padding: EdgeInsets.all(10),
                  //  color: Colors.grey[100],
                  child: GestureDetector(
                    child: new Row(
                      children: <Widget>[
                        new Image.asset(''),
                        new Text('${custdata[0]['crust'][1]}',
                            style:
                            TextStyle(color: Colors.black, fontSize: 15)),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        size = custdata[0]['size'][1];
                        crust = custdata[0]['crust'][1];
                      });
                      _showAddToCart();
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                new Container(
                  //   padding: EdgeInsets.all(10),
                  //  child: button(size,crust,widget.data),
                ),
              ]),
            ),
          );
      }
    }
    else{
       return
         new Container(
           //padding: EdgeInsets.all(10),
           child: new Card(
           child: new Column(children: <Widget>[
           SizedBox(
           height: 10,
         ),
    new Row(
      children: <Widget>[
        new Text(
          ' Selected  $size & $crust Pizza',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 15),overflow: TextOverflow.clip,
        ),
      ],
    ),
           new FlatButton(onPressed: _showAddToCart, child: new Text('change',style: TextStyle(color: Colors.blue),)),
    SizedBox(
    height: 10,
    ),
    new Divider(
    height: 2,
    color: Colors.black,
    ),

         new RaisedButton(
        onPressed: () {
          print(size);
          print(crust);
          Navigator.of(context).push(
              new MaterialPageRoute(
                  builder: (BuildContext context) {
                    return new Cart(
                      data: widget.data,
                      size: pizzasize,
                      //crust: pizzacrust,
                    );
                  }));
        },
        child: new Text(
          'ADD TO CART',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        color: Colors.green,
      ),
    ]),
    ),
         );
    }
  }
}
