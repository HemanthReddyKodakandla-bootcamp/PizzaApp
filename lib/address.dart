import 'package:flutter/material.dart';
import 'package:flutter_pizzadelivaryapp/home_page.dart';

class Address extends StatefulWidget {
  Address({Key key}) : super(key: key);

  var userdata;

  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.redAccent,
        title: new Center(
          //children: <Widget>[
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
//                width: 100,
//              ),
//            child: IconButton(
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
//                    new MaterialPageRoute(builder: (context) => Home_Page(userdata: widget.userdata,)),
//                  );
//                },
//              )
          child: new Text(
            'MY ADDRESS',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          //]
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
//              SizedBox(width: 80,),
//              new Text(
//                'MY SAVED ADDRESS',
//                style: TextStyle(
//                  fontSize: 20,
//                  fontWeight: FontWeight.bold,
//                ),
//                textAlign: TextAlign.center,
//              ),
//            ],
//          ),
          new Center(
            child: new Row(
              children: <Widget>[
                Center(
                  child: Text(
                    "You do not have any saved addresses",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
