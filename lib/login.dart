import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:flutter_pizzadelivaryapp/home_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';

// ignore: camel_case_types
class Login_User extends StatefulWidget {
  @override
  _Login_UserState createState() => _Login_UserState();
}

enum FormType { login, register }

enum MyDialogAction { yes, no, maybe }

// ignore: camel_case_types
class _Login_UserState extends State<Login_User> {
  FirebaseMessaging _messaging = FirebaseMessaging();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();//    _firebaseMessaging.configure(
//      onMessage: (Map<String, dynamic> message) async{
//        print("onMessage : $message");
//        final notification = message ['notification'];
//        setState(() {
//          messages.add(Message(title: notification['title'], body: notification['body']));
//        });
//      },
//      onLaunch: (Map<String, dynamic> message) async{
//        print("onLaunch : $message");
//      },
//      onResume: (Map<String, dynamic> message) async{
//        print("onResume : $message");
//      },
//    );

    _messaging.getToken().then((token) {
      token = token;
      print(token);
    });

    connectivity = new Connectivity();
    connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        setState(() {
          time = 0;
          print('connected');
        });
        _showSnackBar("Connected to Internet");
      } else {
        // _showAlertDialog("Check Internet Connection" );
        setState(() {
          time = 10;
          print('disconnected');
        });
        _showSnackBar("Please Check Your Internet Connection");
      }
    });
  }

  bool status;
  String _name;
  String token;
  var data;
  String _appname = "Login";
  String _errormsg = " ";
  String _error = " ";
  int _mobileNumber;
  String _email;
  String _password;
  String registerurl = "https://pizzahuttest.herokuapp.com/api/register";
  String loginurl = "https://pizzahuttest.herokuapp.com/api/login";
  FormType _formType = FormType.login;

  String value = '';
  String result = '';
  int time = 0;

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
              moveToLogin();
              Navigator.pop(context);
            },
            child: new Text('login'))
      ],
    );

    showDialog(context: context, barrierDismissible: false, child: dialog);
  }

  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();

  void _showSnackBar(String value) {
    if (value.isEmpty) return;
    _scaffoldState.currentState.showSnackBar(
      new SnackBar(
        backgroundColor: Colors.red,
        content: new Text(value),
        duration: new Duration(seconds: time),
      ),
    );
  }

  void _showAlertDialog(String text) {
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
              //moveToLogin();
              Navigator.pop(context);
            },
            child: new Text('okay'))
      ],
    );

    showDialog(context: context, barrierDismissible: false, child: dialog);
  }

  //Input Fields Saving and posting to db
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      // _showAlert();
      form.save();
      return true;
    }

    return false;
  }

  Future<String> apiPost(String url, Map jsonMap) async {
    try {
      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(json.encode(jsonMap)));

      HttpClientResponse response = await request.close();

      String replay = await response.transform(utf8.decoder).join();

      httpClient.close();

      var parsed = json.decode(replay);

      data = parsed;
      //print(data);

      if (_formType == FormType.login) {
        if (response.statusCode == 200) {
          var bool_s = await saveLoginPrefTest(data['user_name'], data['email'],
              data['mobilenumber'], data['password'], data['_id'],);
          Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (BuildContext context) {
            return new Home_Page();
          }));
        } else if(response.statusCode == 401) {
          setState(() {
            if (_formType == FormType.login) {
              _errormsg = replay;
              print('hi');
            }
          });
        }
      } else {
        if (response.statusCode == 200) {
          _showAlert("Regestered successfully");
          // moveToLogin();
        } else {
          setState(() {
            _error = replay;
          });

        }
      }

      return parsed;
    } catch (error) {
     print(error.toString());
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          var map1 = {
            //"user_name": _name,
            "email": _email,
            "password": _password,
          };
          print(map1);
          apiPost(loginurl, map1);
        } else {
          var map1 = {
            "user_name": _name,
            "email": _email,
            "password": _password,
            "mobilenumber": _mobileNumber,
          };
          print(map1);
          apiPost(registerurl, map1);

          // print('Registered as:$userId');
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  void moveToRegister() {
    _formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
      _appname = "Register";
    });
  }

  void moveToLogin() {
    _formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
      _appname = "Login";
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldState,
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          automaticallyImplyLeading: false,
          title: new Center(
            child: new Text(
              _appname,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: <Widget>[
              new Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: inputFields() + submitButtons()),
              ),
            ],
          ),
        ));
  }

  List<Widget> inputFields() {
    if (_formType == FormType.login) {
      return [
        new TextFormField(
          decoration: new InputDecoration(
            labelText: 'Email *',
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value.isEmpty) {
              return "email not empty";
            } else {
              Pattern pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regex = new RegExp(pattern);
              if (!regex.hasMatch(value))
                return 'Enter Valid Email';
              else
                return null;
            }
          },
//          },
          onSaved: (value) => _email = value,
        ),
        new TextFormField(
          decoration: new InputDecoration(
            labelText: 'Password *',
          ),
          keyboardType: TextInputType.text,
          obscureText: true,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please Enter Number';
            } else if (value.length < 6) {
              return 'please enter 5 letters';
            }
          },
          onSaved: (value) => _password = value,
        ),
      ];
    } else {
      return [
        new TextFormField(
          decoration: new InputDecoration(
            labelText: 'Name *',
          ),
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value.isEmpty) {
              return 'Name can\'t be empty';
            } else if (value.length < 5) {
              return "Name must contain 5 letters";
            } else if (value.length > 16) {
              return "Name lessthan 15 letters";
            } else
              return null;
          },
          onSaved: (value) => _name = value,
        ),
        new TextFormField(
          decoration: new InputDecoration(
            labelText: 'Mobile Number *',
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
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
          onSaved: (value) => _mobileNumber = int.parse(value),
        ),
        new TextFormField(
          decoration: new InputDecoration(
            labelText: 'Email *',
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value.isEmpty) {
              return "email not empty";
            } else {
              Pattern pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regex = new RegExp(pattern);
              if (!regex.hasMatch(value))
                return 'Enter Valid Email';
              else
                return null;
            }
          },
          onSaved: (value) => _email = value,
        ),
        new TextFormField(
          decoration: new InputDecoration(
            labelText: 'Password *',
          ),
          keyboardType: TextInputType.text,
          obscureText: true,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please Enter Number';
            } else if (value.length < 5) {
              return 'please enter 6 letters';
            }
          },
          onSaved: (value) => _password = value,
        ),
      ];
    }
  }

  List<Widget> submitButtons() {
    if (_formType == FormType.login) {
      return [
        SizedBox(
          height: 10,
        ),
        new Text(
          _errormsg,
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        new RaisedButton(
            child: Text(
              'login',
              style: TextStyle(fontSize: 20),
            ),
            splashColor: Colors.redAccent,
            highlightColor: Colors.redAccent,
            onPressed: validateAndSubmit),

        new FlatButton(
            onPressed: moveToRegister,
            child: new Text(
              'new user Create Account',
              style: TextStyle(fontSize: 20, color: Colors.blue),
            ))
      ];
    } else {
      return [
        SizedBox(
          height: 10,
        ),
        new Text(
          _error,
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        new RaisedButton(
            child: Text(
              'Register',
              style: TextStyle(fontSize: 20),
            ),
            splashColor: Colors.redAccent,
            highlightColor: Colors.redAccent,
            onPressed: validateAndSubmit),
        new FlatButton(
            onPressed: moveToLogin,
            child: new Text(
              'Have an Account Login',
              style: TextStyle(fontSize: 20, color: Colors.blue),
            ))
      ];
    }
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
