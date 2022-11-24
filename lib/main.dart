import 'package:ems/models/user.dart';
import 'package:ems/screens/wrapper.dart';
import 'package:ems/services/auth.dart';
// import 'package:ems/services/firebase_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp() {
    // NotifiicationFirebase();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
} 
