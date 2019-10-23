import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pizzadelivaryapp/user_page.dart';
import 'package:flutter_pizzadelivaryapp/pizza.dart';
import 'package:flutter_pizzadelivaryapp/profile_page.dart';
import 'package:flutter_pizzadelivaryapp/login.dart';
import 'package:flutter_pizzadelivaryapp/orderhistory.dart';
import 'package:flutter_pizzadelivaryapp/address.dart';
import 'package:flutter_pizzadelivaryapp/favorites.dart';
import 'package:flutter_pizzadelivaryapp/tabbarnav.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_pizzadelivaryapp/delivary.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Home_Page extends StatefulWidget {
  Home_Page(
      {Key key,
      @required this.location,
      @required this.type})
      : super(key: key);

  var userdata;
  var location;
  var type;

  @override
  _HomeState createState() => _HomeState();
}

enum DeliveryType {
  Delivery,
  PickUp,
}

class _HomeState extends State<Home_Page> {
  DeliveryType _delivery = DeliveryType.Delivery;
  String location;

  void _onpressed() {
    setState(() {
      _delivery = DeliveryType.Delivery;
    });
  }

  void _onpress() {
    setState(() {
      _delivery = DeliveryType.PickUp;
    });
  }
  PermissionStatus _status;

  @override
  void initState() {

    super.initState();
     // locationPermission();
      getLocation();
      getSharedData();

  }

  String user_name='k';
  String email;

  void getSharedData() async{
    SharedPreferences prefs= await SharedPreferences.getInstance();

   var username=prefs.getString('username');
   var user_email= prefs.getString('email');
   setState(() {
     user_name = username;
     email = user_email;
   });
   // pref.getString('mobilenumber', mobilenumber);
  }
  var latitude = '1';
  var longitude = '2';

  bool locationPermission(){
    PermissionHandler().requestPermissions([PermissionGroup.location]).then(_askPermission);

  }

  Future<List> getLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      var lat = position.latitude;

      var long = position.longitude;
      setState(() {
        latitude = lat.toString();
        longitude = long.toString();
      });

      GeolocationStatus geolocationStatus =
          await Geolocator().checkGeolocationPermissionStatus();
      List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(lat , long);

      print(placemark[0].subThoroughfare);
      var first = placemark.first;
      print("${first.locality} : ${first.subThoroughfare} : ${first.name} : ${first.thoroughfare} : ${first.country} : ${first.postalCode}");
      print(geolocationStatus);
      if(geolocationStatus != GeolocationStatus.granted){

      }
    } catch (e) {
      print(e.toString());
    }
    print('latitude is'+latitude);
    print('longitude is'+longitude);
    return [latitude, longitude];
  }

  @override
  Widget build(BuildContext context) {
     return new Scaffold(
      appBar: AppBar(
        //  automaticallyImplyLeading: false,
        backgroundColor: Colors.redAccent,
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Image.asset(
                'assets/logo.png',
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
              //  alignment: Alignment.center,
              iconSize: 200,
              onPressed: () {},
            )
            // ]
          ],
        ),
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              currentAccountPicture: new CircleAvatar(
                backgroundColor:
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? Colors.white
                        : Colors.white,
                child: new Text(
                  user_name.substring(0,1),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.redAccent),
                ),
              ),
              accountName: Text(
                user_name,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
              accountEmail: Text(
                email,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
              decoration: BoxDecoration(color: Colors.redAccent),
            ),
            new ListTile(
              title: Text(
                'My Profile',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => Profile_Page(
                            userdata: widget.userdata,
                          )),
                );
              },
            ),
            new ListTile(
                title: Text(
                  'My Order History',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Order_History( )),
                  );
                }),
            new ListTile(
                title: Text(
                  'My Saved Address',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Address()),
                  );
                }),
            new ListTile(
                title: Text(
                  'My Favorites',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new Favorites()),
                  );
                }),
            new ListTile(
                title: Text(
                  'Logout',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove('email');
                  Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Login_User()),
                  );
                })
          ],
        ),
      ),
      body: new ListView(
        padding: EdgeInsets.all(5),
        children: <Widget>[
          new Card(
            elevation: 10,
            child: new Stack(
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: CachedNetworkImage(
                        imageUrl: 'https://www.pizzahut.com.pk/p_h_logo.png',
                        height: 200,
                        width: 350,
                        errorWidget: (context, url, error) => new Icon(Icons.error),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: 30,
                  right: 30,
                  top: 2,
                  bottom: 0,
                  child: typeSelect(),
                ),
              ],
            ),
          ),
          GestureDetector(
              child: new Card(
                elevation: 10,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: new CachedNetworkImage(
                          imageUrl: 'https://i.imgur.com/2OnopRT.png',
                      height: 200,
                      width: 350,
                      alignment: Alignment.center,),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => Tab_Nav()));
              }),
          GestureDetector(
            child: new Card(
              elevation: 10,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child:
                    new CachedNetworkImage(
                      imageUrl: 'http://www.jsdirectory.com/wp-content/uploads/2018/09/pizza-hut-2-medium-pizzas.jpg',
                      height: 200,
                      width: 350,
                      alignment: Alignment.center,),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => Tab_Nav( )));
            },
          ),
        ],
      ),
    );
  }

  Widget typeSelect() {
    if (widget.location == null) {
      return Container(
        child: new Card(
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new RaisedButton(
                            onPressed: _onpressed,
                            highlightColor: Colors.white70,
                            disabledColor: Colors.grey,
                            child: new Row(children: <Widget>[
                              new Icon(
                                Icons.directions_bike,
                                color: Colors.redAccent,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              new Text('Delivery')
                            ]),
                            splashColor: Colors.red),
                      ]),
                  //SizedBox(width: 30,),
                  Column(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        new RaisedButton(
                          onPressed: _onpress,
                          highlightColor: Colors.white70,
                          disabledColor: Colors.grey,
                          child: new Row(children: <Widget>[
                            Image.asset(
                              'assets/takeaway.png',
                              fit: BoxFit.cover,
                              width: 30,
                              height: 30,
                            ),
                            new Text('TakeAway')
                          ]),
                          splashColor: Colors.red,
                        ),
                      ]),
                ],
              ),
              new Column(
                children: delivery(),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      );
    } else {
      setState(() {
        location = widget.location;
      });
      if (widget.type == "Delivery") {
        return new Card(
          child: new ListView(children: <Widget>[
            new Column(
              children: <Widget>[
                new Text('${widget.type} to'),
                new Text(
                  widget.location,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                new RaisedButton(
                  onPressed: () {},
                  child: new Text('change'),
                ),
              ],
            ),
          ]),
        );
      } else {
        return new Card(
          child: new ListView(children: <Widget>[
            new Column(
              children: <Widget>[
                new Text('${widget.type} from'),
                new Text(
                  widget.location,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                new RaisedButton(
                  onPressed: () {},
                  child: new Text('change'),
                ),
              ],
            ),
          ]),
        );
      }
    }
  }
  List<Widget> delivery() {
    if (_delivery == DeliveryType.Delivery) {
      return [
        // Icon(Icons.location_searching,size: 20,),
        SizedBox(
          height: 20,
        ),
        new TextField(
            decoration: InputDecoration(
                labelText: 'Enter Delivary Location',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10), gapPadding: 5),
                icon: Icon(
                  Icons.search,
                  color: Colors.green,
                ),
                hasFloatingPlaceholder: true),
            onTap: () {}
            //textCapitalization: TextCapitalization.characters,
            ),
      ];
    } else {
      return [
        // Icon(Icons.location_searching,size: 20,),
        SizedBox(
          height: 30,
        ),
        new TextField(
            decoration: InputDecoration(
                labelText: 'Enter TakeAWay Location',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10), gapPadding: 5),
                icon: Icon(
                  Icons.search,
                  color: Colors.greenAccent,
                ),
                hasFloatingPlaceholder: true),
            onTap: () {
//              Navigator.of(context).push(
//                new MaterialPageRoute(builder: (BuildContext context) {
//                  return new Delivary(
//                    userdata: widget.userdata, type: "PickUp",);
//                },
//                  //textCapitalization: TextCapitalization.characters,
//                ),);
            }),
      ];
    }
  }

  void _askPermission(Map<PermissionGroup, PermissionStatus> value) {
    
    PermissionHandler().requestPermissions([PermissionGroup.location]).then(_requestPermission);
  }

  void _requestPermission(Map<PermissionGroup, PermissionStatus> value) {

    final status = value[PermissionGroup.location];

    print(status);
  }
}

