import 'package:flutter/material.dart';
import 'package:flutter_pizzadelivaryapp/home_page.dart';
import 'package:flutter_pizzadelivaryapp/location.dart';
import 'package:flutter_pizzadelivaryapp/newhome.dart';

class Delivary extends StatefulWidget {
  Delivary({Key key, @required this.type, @required userdata})
      : super(key: key);

  var userdata;
  var type;

  @override
  _DelivaryState createState() => _DelivaryState();
}

class _DelivaryState extends State<Delivary> {
  String location = '';
  final _formKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      // _showAlert();
      form.save();
      return true;
    }

    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        print(location);
        print(widget.type);
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: new Center(
          child: new Text(
            'YOUR LOCATION',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: new Container(
        padding: EdgeInsets.all(10),
        child: new Form(
          key: _formKey,
          child: new Column(
            children: <Widget>[
              SizedBox(
                width: 20,
              ),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: 'Location',
                ),
                keyboardType: TextInputType.text,
                validator: (value) =>
                    value.isEmpty ? 'Location can\'t be empty' : null,
                onSaved: (value) => location = value,
              ),
              new RaisedButton(
                onPressed: () async {
                  validateAndSubmit();
//              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
//                new home_Page(userdata: widget.userdata, location: location, type: widget.type);
//              }));
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    home_Page(
                        userdata: widget.userdata,
                        location: location,
                        type: widget.type);
                  }));
                },
                child: new Text('select'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
