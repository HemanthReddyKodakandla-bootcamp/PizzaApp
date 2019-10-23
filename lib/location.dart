import 'package:flutter/material.dart';
import 'package:flutter_pizzadelivaryapp/delivary.dart';
import 'package:flutter_pizzadelivaryapp/home_page.dart';
//import 'package:geolocator/geolocator.dart';

class Location extends StatefulWidget {
  Location(
      {Key key,
      @required this.userdata,
      @required this.location,
      @required this.type})
      : super(key: key);

  var userdata;
  var location;

  var type;

  @override
  _LocationState createState() => _LocationState();
}

enum DeliveryType {
  Delivery,
  PickUp,
}

class _LocationState extends State<Location> {
  DeliveryType _delivery = DeliveryType.Delivery;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //print(getLocation());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Card(
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //Image.asset('assets/logo.png',fit: BoxFit.cover,width: 40,height: 40,),
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
}
