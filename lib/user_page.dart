import 'package:flutter/material.dart';
import 'package:flutter_pizzadelivaryapp/profile_page.dart';
import 'package:flutter_pizzadelivaryapp/formtest.dart';
import 'package:flutter_pizzadelivaryapp/login.dart';
import 'package:flutter_pizzadelivaryapp/address.dart';
import 'package:flutter_pizzadelivaryapp/favorites.dart';
import 'package:flutter_pizzadelivaryapp/orderhistory.dart';
import 'package:flutter_pizzadelivaryapp/home_page.dart';

class User extends StatefulWidget {
  User({Key key, @required this.userdata}) : super(key: key);

  var userdata;

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.redAccent,
        title: new Row(children: <Widget>[
          IconButton(
              icon: Icon(
                Icons.account_circle,
                size: 40,
                color: Colors.white70,
              ),
              alignment: Alignment.topLeft,
              onPressed: null),
          SizedBox(
            width: 50,
          ),
          IconButton(
            icon: Image.asset(
              'assets/logo.png',
              fit: BoxFit.cover,
              width: 100,
              height: 100,
            ),
            color: Colors.white70,
            alignment: Alignment.center,
            iconSize: 200,
            onPressed: (){
              Navigator
                  .of(context)
                  .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) {
                return new Home_Page();
              }));
            },
          )
        ]),
      ),
      body: new ListView(
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new Text(
                'MY ACCOUNT',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Divider(
            color: Colors.black,
            height: 2,
          ),
          GestureDetector(
         child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                'My Profile',
                style: TextStyle(fontSize: 25),
              ),
              new IconButton(
                  icon: Icon(Icons.navigate_next, color: Colors.black),
                  iconSize: 40,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Profile_Page(
                                userdata: widget.userdata,
                              )),
                    );
                  })
            ],
          ),
            onTap:() {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Profile_Page(
                      userdata: widget.userdata,
                    )),
              );
            } ,
          ),
          Divider(
            color: Colors.black,
            height: 2,
          ),
          GestureDetector(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                'My Order History',
                style: TextStyle(fontSize: 25),
              ),
              new IconButton(
                  icon: Icon(Icons.navigate_next, color: Colors.black),
                  iconSize: 40,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Order_History()),
                    );
                  })
            ],
          ),
            onTap:() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Order_History()),
              );
            } ,
          ),
          Divider(
            color: Colors.black,
            height: 2,
          ),
          GestureDetector(
        child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                'My Saved Address',
                style: TextStyle(fontSize: 25),
              ),
              new IconButton(
                  icon: Icon(Icons.navigate_next, color: Colors.black),
                  iconSize: 40,
                  onPressed: (){
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (BuildContext context) => new Address()),
                    );
                  })
            ],
          ),
            onTap:(){
              Navigator.push(context, new MaterialPageRoute(
                  builder: (BuildContext context) => new Address()),
              );
            } ,
          ),
          Divider(
            color: Colors.black,
            height: 2,
          ),
          GestureDetector(
         child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                'My Favorites',
                style: TextStyle(fontSize: 25),
              ),
              new IconButton(
                  icon: Icon(Icons.navigate_next, color: Colors.black),
                  iconSize: 40,
                  onPressed: (){
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (BuildContext context) => new Favorites(userdata: widget.userdata,)),
                    );
                  })
            ],
          ),
            onTap:(){
              Navigator.push(context, new MaterialPageRoute(
                  builder: (BuildContext context) => new Favorites(userdata: widget.userdata,)),
              );
            } ,
          ),
          Divider(
            color: Colors.black,
            height: 2,
          ),
          GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                'Logout',
                style: TextStyle(fontSize: 25),
              ),
              new IconButton(
                  icon: Icon(Icons.navigate_next, color: Colors.black),
                  iconSize: 40,
                  onPressed: (){
                    Navigator
                        .of(context)
                        .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) {
                      return new Login_User();
                    }));
                  }),

            ],
          ),
            onTap: (){
              Navigator
                  .of(context)
                  .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) {
                return new Login_User();
              }));
            },
          ),
          Divider(
            color: Colors.black,
            height: 2,
          ),
        ],
      ),

    );
  }
}
