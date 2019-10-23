import 'package:flutter/material.dart';
import 'package:flutter_pizzadelivaryapp/user_page.dart';
import 'package:flutter_pizzadelivaryapp/cart.dart';
import 'package:flutter_pizzadelivaryapp/home_page.dart';

class Favorites extends StatelessWidget {
  Favorites({Key key, @required this.userdata, @required this.data})
      : super(key: key);

  var userdata;
  var data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.redAccent,
        title: new Center(
          //mainAxisAlignment: MainAxisAlignment.center,
          child: new Text(
            'MY FAVORITES',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
//              IconButton(
//                  icon:
//                  Icon(
//                    Icons.account_circle,
//                    size: 40,
//                    color: Colors.white,
//                  ),
//                  alignment: Alignment.topLeft,
//                  onPressed: () {
//                    Navigator.push(
//                      context,
//                      new MaterialPageRoute(builder: (context) => User(userdata: userdata,)),
//                    );
//                  }),
          // new Text(widget.userdata["user_name"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),),
//              SizedBox(
//                width: 10,
//              ),
//              IconButton(
//                icon: Image.asset(
//                  'assets/logo.png',
//                  fit: BoxFit.cover,
//                  width: 100,
//                  height: 100,
//                ),
//                alignment: Alignment.center,
//                iconSize: 200,
//                onPressed: () {
//                  Navigator.push(
//                    context,
//                    new MaterialPageRoute(builder: (context) => Home_Page(userdata: userdata,)),
//                  );
//                },
//              ),
//              IconButton(
//                  icon: Icon(
//                    Icons.shopping_cart,
//                    size: 30,
//                    color: Colors.white,
//                  ),
//                  onPressed: () {
//                    Navigator.push(
//                      context,
//                      new MaterialPageRoute(builder: (context) => new  Cart(userdata: userdata,data: data,)),
//                    );
//                  })
          //  ]
        ),
      ),
      body: new ListView(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
//          Row(
//            //   mainAxisAlignment: MainAxisAlignment.start,
//            children: <Widget>[
//              IconButton(
//                  icon: Icon(
//                    Icons.arrow_back_ios,
//                  ),
//                  onPressed: () {
//                    Navigator.pop(context);
//                  }),
//              SizedBox(width: 100,),
//              new Text(
//                'MY FAVORITES',
//                style: TextStyle(
//                  fontSize: 20,
//                  fontWeight: FontWeight.bold,
//                ),
//                textAlign: TextAlign.center,
//              ),
//            ],
//          ),
          new Center(
            child: favoriteItems(),
          )
        ],
      ),
    );
  }

  Widget favoriteItems() {
    if (data == null) {
      return new Center(
        child: new Row(
          children: <Widget>[
            Text(
              "You havenot favourited any product Yet",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      );
    } else {
      return new ListView.builder(
          padding: EdgeInsets.all(10),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: data == null ? 0 : 1,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: new Card(
                child: new Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Stack(
                      children: <Widget>[
                        new Image.network(
                          data['src'],

                          height: 120,
                          width: 120,
                          // color: Colors.transparent,
                        ),
                        Positioned(
                          left: 0,
                          bottom: 0,
                          child: new Image.network(
                            data['type'],
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
                                data['name'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              new Text('₹${data['price']}'),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          new Text(
                            data['description'],
                            overflow: TextOverflow.clip,
                            style: TextStyle(color: Colors.black, height: 1.5),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new RaisedButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) {
                                    return new Cart(data: data);
                                  }));
                                },
                                child: new Text(
                                  'Place Order',
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.green,
                              )
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
