import 'package:ems/models/user.dart';
import 'package:ems/screens/authenticate/authenticate.dart';
// import 'package:ems/screens/home/home.dart';
import 'package:ems/screens/home/home_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    //print(user); // print User Instances in console

    if (user == null) {
      // print(new DateTime.now().millisecondsSinceEpoch);
      // print(new DateTime.now());
      // String testDate = DateTime.now().toString();
      // print(DateTime.parse(testDate));

      // DateTime today = new DateTime.now();
      // DateTime yesterday = today.subtract(new Duration(days: 1));
      // print(yesterday); 

      // DateTime now = new DateTime.now();
      // String convertedDate = new DateFormat("yyyy-MM-dd").format(now);
      // print(convertedDate);
      // var now = DateTime.now();
      // var date = new DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second);
      // print(date);

      // String dateUtc = new DateTime.now().toString();
      // var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateUtc, true);
      // var dateLocal = dateTime.toLocal();

      // DateTime date = DateTime.now();
      // print(date);
      // print(date.toLocal());
      // print(DateTime.now().toUtc());
      // print(DateTime.now().toLocal());

      return Authenticate();
    } else {
      return Home2();
    }
    // return either home or authenticate widget
    //return Home();
    //return Authenticate();
  }
}