import 'dart:io';

import 'package:flutter/material.dart';
import 'contact.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart';
class MyCustomForm extends StatefulWidget {


  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

enum FormType{
  login,
  register
}
// Create a corresponding State class. This class will hold the data related to
// the form.
class MyCustomFormState extends State<MyCustomForm> {
   String _password;
   String _email;
   String _user;

        String url="https://pizzaservertest.herokuapp.com/api/register";
        TextEditingController _userdata= new TextEditingController();
        TextEditingController _pass= new TextEditingController();
        TextEditingController _emaildata= new TextEditingController();
 // String _username;
  FormType _formType=FormType.login;
  bool validateAndSave(){
    final form=_formKey.currentState;
    if(form.validate()){
      form.save();
     return true;
    }

    return false;
  }

   // var map1 =Map();


 Future<String> apiPost(String url,Map jsonMap) async {
   try {
     HttpClient httpClient = new HttpClient();
     HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
     request.headers.set('content-type', 'application/json');
     request.add(utf8.encode(json.encode(jsonMap)));

     HttpClientResponse response = await request.close();

     String replay = await response.transform(utf8.decoder).join();
     httpClient.close();
     print(replay);
     return replay;
   }

   catch (error) {
     print(error.toString());
   }
 }


  void validateAndSubmit() async{
    if(validateAndSave()){
      try {
        if(_formType==FormType.login) {

          var map1={
            "user_name": _user,
            "email": _email,
            "password": _password,
          };

          print(_email);
          print(map1);
          apiPost(url, map1);
         // print('Signed  in as:$user.uid');
        }else{

        }
      }
      catch(e){
        print(e.toString());
      }
    }
  }

  void moveToRegister(){
    _formKey.currentState.reset();
      setState(() {
        _formType=FormType.register;
      });

  }

  void moveToLogin(){
    _formKey.currentState.reset();
    setState(() {
      _formType=FormType.login;
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.redAccent,
        title: new  Row(
            children:<Widget>[
              SizedBox(width: 100,),
              IconButton(icon: Image.asset('assets/logo.png',fit: BoxFit.cover,width: 100,height: 100,),color: Colors.white70,alignment: Alignment.center,iconSize: 200,onPressed: null,)
            ]),

      ),

     body:  Container(
padding: EdgeInsets.all(20),

child: new Form(
key: _formKey,
child: Column(
crossAxisAlignment: CrossAxisAlignment.stretch,
children:
inputFields()+submitButtons()


),

),
)
);

}

List<Widget> inputFields(){

  return[

    new TextFormField(
      decoration: new InputDecoration(labelText: 'Name *',),
      keyboardType: TextInputType.text,
      validator: (value) => value.isEmpty ? 'Name can\'t be empty' : null,
      onSaved: (value) => _user=value,
      controller: _userdata,
    ),
    new TextFormField(
      decoration: new InputDecoration(labelText: 'password *',),
      keyboardType: TextInputType.text,
      validator: (value) => value.isEmpty ? 'Number can\'t be empty' : null,
      onSaved: (value) =>_password=value,
      controller: _pass,
    ),
    new TextFormField(
      decoration: new InputDecoration(labelText: 'Email *',),
      keyboardType: TextInputType.emailAddress,
      validator: (value) => value.isEmpty ? 'email can\'t be empty' : null,
      onSaved: (value) => _email=value,
      controller: _emaildata,
    ),
  ];

}

List<Widget> submitButtons(){
  if(_formType==FormType.login){
    return [
      new RaisedButton(child: Text('login',style: TextStyle(fontSize: 20),),
          onPressed: validateAndSubmit),

      new FlatButton(onPressed: moveToRegister, child: new Text('new user Create Account',
        style: TextStyle(fontSize: 20,color: Colors.blue),))
    ];}

  else{
    return [
      new RaisedButton(child: Text('Register',style: TextStyle(fontSize: 20),),
          onPressed: validateAndSubmit),

      new FlatButton(onPressed: moveToLogin, child: new Text('Have an Account Login',
        style: TextStyle(fontSize: 20,color: Colors.blue),))
    ];}
}
}


//
//Form(
//key: _formKey,
//child: Column(
//crossAxisAlignment: CrossAxisAlignment.start,
//children: <Widget>[
//
//new FormField<String>(
//builder: (FormFieldState<String> state) {
//return InputDecorator(
//decoration: InputDecoration(
//icon: const Icon(Icons.color_lens),
//labelText: 'Color',
//),
//isEmpty: _color == '',
//child: new DropdownButtonHideUnderline(
//child: new DropdownButton<String>(
//value: _color,
//isDense: true,
//onChanged: (String newValue) {
//setState(() {
//newContact.favoriteColor = newValue;
//_color = newValue;
//state.didChange(newValue);
//});
//},
//items: _colors.map((String value) {
//return new DropdownMenuItem<String>(
//value: value,
//child: new Text(value),
//);
//}).toList(),
//),
//),
//);
//},
//),
//TextFormField(
//
//decoration: InputDecoration(labelText: 'Mobile Number *',labelStyle: TextStyle(color: Colors.black87),
//),keyboardType: TextInputType.number,
//validator: (value) {
//if (value.isEmpty) {
//return 'Please enter some text';
//}
//},
//
//),
//Padding(
//padding: const EdgeInsets.symmetric(vertical: 16.0),
//child: RaisedButton(
//onPressed: () {
//// Validate will return true if the form is valid, or false if
//// the form is invalid.
//if (_formKey.currentState.validate()) {
//// If the form is valid, we want to show a Snackbar
//Scaffold.of(context)
//    .showSnackBar(SnackBar(content: Text('Processing Data')));
//}
//},
//child: Text('Submit'),
//),
//),
//],
//),),













//String url="https://pizzaservertest.herokuapp.com/api/pizzas";
//
//bool _isFavorited = false;
//bool _isFavorite = true;
//
//void _toggleFavorite() {
//  setState(() {
//    if (_isFavorited) {
//      _isFavorited = false;
//    } else
//      _isFavorited = true;
//  });
//}
//
//void _toggleFavorit() {
//  setState(() {
//    if (_isFavorite) {
//      _isFavorite = false;
//    } else
//      _isFavorite = true;
//  });
//}
//
//void initState()
//{
//  super.initState();
//  this.getApi();
//}
//var data;
//
//
//Future getApi() async
//{
//  http.Response response= await http.get(Uri.encodeFull(url),
//      headers: {
//        "Accept":"application/json"
//      }
//  );
//  setState(()
//  {
//    var x= json.decode(response.body);
//    data=x;
//
//  });
