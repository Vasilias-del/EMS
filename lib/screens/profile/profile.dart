import 'package:ems/models/user.dart';
import 'package:ems/services/database.dart';
import 'package:ems/shared/constant.dart';
import 'package:ems/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  
  final _formKey = GlobalKey<FormState>();
  String _username;
  String _firstname;
  String _lastname;
  String _email;
  String _password;
  bool loading = false;
  
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        // print(snapshot.data);
        if (snapshot.hasData) {

          UserData userData = snapshot.data;

          return Scaffold(
            resizeToAvoidBottomPadding: false, 
            backgroundColor: Color(0xff392850),
            appBar: AppBar(
              title: Text('Profile'),
              backgroundColor:  Color(0xff392850),
              elevation: 0.0,
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
                      initialValue: userData.uname,
                      decoration: textInputDecoration.copyWith(hintText: 'Username'),
                      validator: (val) => val.isEmpty || val == 'username' ? 'Enter your username' : null,
                      onChanged: (val) {
                        setState(() => _username = val);
                      } 
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      initialValue: userData.fname,
                      decoration: textInputDecoration.copyWith(hintText: 'Firstname'),
                      validator: (val) => val.isEmpty || val == 'firstname' ? 'Enter your firstname' : null,
                      onChanged: (val) {
                        setState(() => _firstname = val);
                      } 
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      initialValue: userData.lname,
                      decoration: textInputDecoration.copyWith(hintText: 'Lastname'),
                      validator: (val) => val.isEmpty || val == 'lastname' ? 'Enter your lastname' : null,
                      onChanged: (val) {
                        setState(() => _lastname = val);
                      } 
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      enabled: false,
                      style: TextStyle(color: Colors.white),
                      initialValue: userData.email,
                      decoration: textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => _email = val);
                      } 
                    ),
                    SizedBox(height: 20.0),
                    Visibility(
                      visible: false,
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        initialValue: userData.password,
                        decoration: textInputDecoration.copyWith(hintText: 'Password'),
                        validator: (val) => val.isEmpty ? 'Enter a password' : null,
                        onChanged: (val) {
                          setState(() => _password = val);
                        } 
                      ),
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      color: Colors.deepPurple,
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          //setState(() => loading = true);
                          await DatabaseService(uid: user.uid).updateUserData(
                            _firstname ?? userData.fname, 
                            _lastname ?? userData.lname, 
                            _username ?? userData.uname, 
                            _email ?? userData.email, 
                            _password ?? userData.password
                          );
                          Navigator.pop(context);
                        } 
                        // print(_username);
                        // print(_firstname);
                        // print(_lastname);
                        // print(_email);
                        // print(_password);
                      },
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      '',
                      // error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                )
              ),
            )
          );
        } else {
          return Loading();
        }
      
      }
    );
  }
}