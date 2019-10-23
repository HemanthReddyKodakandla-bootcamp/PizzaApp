import 'dart:convert';

import 'package:flutter/material.dart';
import 'contact.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter_pizzadelivaryapp/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile_Page extends StatefulWidget {

  Profile_Page({Key key,@required this.userdata}):super(key : key);

  var userdata;
  @override
  _Profile_PageState createState() => _Profile_PageState();
}


class _Profile_PageState extends State<Profile_Page> {
  String _name;
  String _mobileNumber;
  String _email;
  String updateurl = "https://pizzahuttest.herokuapp.com/api/userupdate";

  @override
  void initState(){
    super.initState();
    getSharedData();
  }

  String user_name;
  String user_email;
  String user_mobile;
  String _id;

  void getSharedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var username = prefs.getString('username');
    var useremail = prefs.getString('email');
    var mobiles = prefs.getString('mobilenumber');
    var id = prefs.getString('id');
    setState(() {
      user_name = username;
      user_email = useremail;
      user_mobile = mobiles;
      _id = id;
      _user.text=user_name;
      mobile.text= user_mobile;
    });
  }

  final TextEditingController _user= new TextEditingController();

  final TextEditingController mobile= new TextEditingController();

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }

    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
            var map1 = {
              "user_name": _name,
              "email": user_email,
              "mobilenumber": _mobileNumber,
              "_id" : _id
            };
            print(map1);
            apiPost(updateurl, map1);
          }
       catch (e) {
        print(e.toString());
      }
    }
  }

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
              Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(
                  builder: (BuildContext context) =>
              new Home_Page()));
            },
            child: new Text('ok'))
      ],
    );
    showDialog(context: context, barrierDismissible: false, child: dialog);
  }
var data;
  Future<String> apiPost(String url, Map jsonMap) async {
    try {
      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient.putUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(json.encode(jsonMap)));

      HttpClientResponse response = await request.close();
      String replay = await response.transform(utf8.decoder).join();

      var parsed = json.decode(replay);
      data = parsed;
      print(data);
      if( response.statusCode == 200){
        var bool_s = await saveLoginPrefTest(data['user_name'], data['email'],
          data['mobilenumber'], data['password'], data['_id'],);

        _showAlert('Updated successfully');
      }
      else{
        _showAlert('error occured');
      }

      print(replay);

      httpClient.close();

    } catch (error) {
      print(error.toString());
    }
  }


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        backgroundColor: Colors.redAccent,
        title: new Center(
          child: new Text('MY PROFILE',style: TextStyle(color:Colors.white,fontSize: 20, fontWeight: FontWeight.bold),),
        //]
        ),
      ),
      body: new ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          new Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: inputFields() + submitButtons()),
          ),
        ],
      ),
    );
  }

  List<Widget> inputFields() {
    return [
      new TextFormField(
        decoration: new InputDecoration(
          labelText: 'Name *',labelStyle: TextStyle(color: Colors.black)
        ),
        keyboardType: TextInputType.text,
        controller: _user,
        validator: (value) => value.isEmpty ? 'Name can\'t be empty' : null,
        onSaved: (value) => _name = value,
      ),
      new TextFormField(
        decoration: new InputDecoration(
          labelText: 'Mobile Number *',labelStyle: TextStyle(color: Colors.black)
        ),
        keyboardType: TextInputType.number,
          controller: mobile,
        validator: (value)
        {
          if (value.isEmpty) {
            return 'Please Enter Number';
          } else if (value.startsWith(RegExp(r'[0-5]'))) {
            return 'Please Enter Valid Number';
          } else if (value.length < 10) {
            return 'Please Enter Valid 10-digit Number';
          } else if (value.length > 10) {
            return 'Please Enter Valid 10-digit Number';
          }
        },
        onSaved: (value) => _mobileNumber = value
      ),
    ];
  }

  List<Widget> submitButtons() {
    return [
      SizedBox(
        height: 15,
      ),
      new RaisedButton(
          child: Text(
            'Save Profile',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          color: Colors.green,
          onPressed: validateAndSubmit),
    ];
  }

  Future<bool> saveLoginPrefTest(
      username, email, mobilenumber, password,id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('username', username);
    pref.setString('email', email);
    pref.setString('mobilenumber', mobilenumber);
    pref.setString('password', password);
    pref.setString('id', id);
    return true;
  }
}
