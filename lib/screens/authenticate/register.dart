import 'package:ems/services/auth.dart';
import 'package:ems/shared/constant.dart';
import 'package:ems/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  bool loading = false;

  // text field state
  String email = "";
  String password = "";
  String confirmPassword = "";
  String error = "";
  
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Color(0xff392850),
      appBar: AppBar(
        backgroundColor: Color(0xff392850),
        elevation: 0.0,
        title: Text('Sign Up'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person, color: Colors.white70),
            label: Text('Sign In', style: TextStyle(color: Colors.white)),
            onPressed: (){
              widget.toggleView();
            }, 
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email', prefixIcon: Icon(Icons.mail_outline, color: Colors.white70,), hintStyle: TextStyle(color: Colors.white),),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                } 
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _pass,
                decoration: textInputDecoration.copyWith(hintText: 'Password', prefixIcon: Icon(Icons.lock_outline, color: Colors.white70,), hintStyle: TextStyle(color: Colors.white),),
                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                } 
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _confirmPass,
                decoration: textInputDecoration.copyWith(hintText: 'Confirm Password', prefixIcon: Icon(Icons.lock_outline, color: Colors.white70,), hintStyle: TextStyle(color: Colors.white),),
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Enter a confirm password';
                  }
                  if (val != _pass.text) {
                    return 'Password do not match';
                  } 
                  return null;
                },
                obscureText: true,
                onChanged: (val) {
                  setState(() => confirmPassword = val);
                } 
              ),

              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.deepPurpleAccent,
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() => loading = true);
                    dynamic result =  await _auth.registerWithEmailAndPassword(email, password);
                    if (result == null) {
                      setState(() { 
                        error = 'please supply a valid email';
                        loading = false;
                      });
                    }
                  } 
                  // print(email);
                  // print(password);
                },
              ),
              SizedBox(height: 10.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          )
        ),
      )
    );
  }
}