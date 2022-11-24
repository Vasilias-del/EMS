import 'package:ems/services/auth.dart';
import 'package:ems/shared/constant.dart';
import 'package:ems/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Color(0xff392850),
      appBar: AppBar(
        backgroundColor: Color(0xff392850),
        elevation: 0.0,
        title: Text('Sign In', style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person, color: Colors.white70),
            label: Text('Register', style: TextStyle(color: Colors.white)),
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
                style: TextStyle(color: Colors.white),
                decoration: textInputDecoration.copyWith(hintText: 'Email', prefixIcon: Icon(Icons.mail_outline, color: Colors.white70,), hintStyle: TextStyle(color: Colors.white),),
                validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                } 
              ),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                style: TextStyle(color: Colors.white),
                decoration: textInputDecoration.copyWith(hintText: 'Password', prefixIcon: Icon(Icons.lock_outline, color: Colors.white70,), hintStyle: TextStyle(color: Colors.white),),
                validator: (val) => val.length < 6 ? 'Enter an password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                } 
              ),

              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.deepPurpleAccent,
                child: Text(
                  'Sign In', 
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() => loading = true);
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if (result == null) {
                      setState(() {
                        error = 'could not sign in with those credentials';
                        loading = false;
                      });
                    }
                    // print(email);
                    // print(password);
                  }
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