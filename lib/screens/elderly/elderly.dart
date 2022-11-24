import 'package:ems/models/elder.dart';
import 'package:ems/models/user.dart';
import 'package:ems/services/database.dart';
import 'package:ems/shared/constant.dart';
import 'package:ems/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ElderlyInfo extends StatefulWidget {
  @override
  _ElderlyInfoState createState() => _ElderlyInfoState();
}

class _ElderlyInfoState extends State<ElderlyInfo> {

  List gender=["Male","Female"];
  String select;
  final _formKey = GlobalKey<FormState>();

  String _firstname;
  String _lastname;
  int _age;
  double _height, _weight;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    
    return StreamBuilder<ElderData>(
      stream: DatabaseService(uid: user.uid).elderData,
      builder: (context, snapshot) {
        // print(snapshot.data);
        if (snapshot.hasData) {

          ElderData elderData = snapshot.data;

          return Scaffold(
            resizeToAvoidBottomPadding: false, 
            backgroundColor: Color(0xff392850),
            appBar: AppBar(
              title: Text("Elder's Info"),
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
                      initialValue: elderData.fname,
                      decoration: textInputDecoration.copyWith(hintText: 'Firstname'),
                      validator: (val) => val.isEmpty || val == 'firstname' ? 'Enter firstname' : null,
                      onChanged: (val) {
                        setState(() => _firstname = val);
                      } 
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      initialValue: elderData.lname,
                      decoration: textInputDecoration.copyWith(hintText: 'Lastname'),
                      validator: (val) => val.isEmpty || val == 'lastname' ? 'Enter lastname' : null,
                      onChanged: (val) {
                        setState(() => _lastname = val);
                      } 
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      initialValue: elderData.age.toString(),
                      decoration: textInputDecoration.copyWith(hintText: 'Age'),
                      validator: (val) => val.isEmpty || val == '0' ? 'Enter age' : null,
                      onChanged: (val) {
                        setState(() => _age = int.tryParse(val));
                      } 
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      initialValue: elderData.height.toString(),
                      decoration: textInputDecoration.copyWith(hintText: 'Height (m)'),
                      validator: (val) => val.isEmpty || val == '0' ? 'Enter height' : null,
                      onChanged: (val) {
                        setState(() => _height = double.tryParse(val));
                      } 
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      initialValue: elderData.weight.toString(),
                      decoration: textInputDecoration.copyWith(hintText: 'Weight (kg)'),
                      validator: (val) => val.isEmpty || val == '0' ? 'Enter weight' : null,
                      onChanged: (val) {
                        setState(() => _weight = double.tryParse(val));
                      } 
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
                          // setState(() => loading = true);
                          await DatabaseService(uid: user.uid).updateElderData(
                            _firstname ?? elderData.fname, 
                            _lastname ?? elderData.lname, 
                            _age ?? elderData.age, 
                            _height ?? elderData.height, 
                            _weight ?? elderData.weight
                          );
                          Navigator.pop(context);
                        } 
                        // print(email);
                        // print(password);
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