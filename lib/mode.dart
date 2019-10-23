import 'package:flutter/material.dart';

class Mode extends StatefulWidget {
  Mode({Key key,@required this.location,@required this.type}) : super(key: key);

  var userdata;
  var location;
  var type;
  @override
  _ModeState createState() => _ModeState();
}

class _ModeState extends State<Mode> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: mode(),
    );
  }

  Widget mode(){

    if(widget.type == "Delivery") {
      return
      new Card(
      child:  new ListView(
            children: <Widget>[
              new Column(
                children: <Widget>[
                  new Text('${widget.type} to'),
                  new Text(widget.location, style: TextStyle(color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),),
                  new RaisedButton(onPressed: (){},child: new Text('change'),),

                ],
              ),
            ]),
      );
    }
    else {
      return
      new Card(
       child: new ListView(
            children: <Widget>[
              new Column(
                children: <Widget>[
                  new Text('${widget.type} from'),
                  new Text(widget.location, style: TextStyle(color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),),
                  new RaisedButton(onPressed: (){},child: new Text('change'),),

                ],
              ),
            ]),
      );
    }

  }
  }

