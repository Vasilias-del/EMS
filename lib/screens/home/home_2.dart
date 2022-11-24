import 'package:ems/models/option.dart';
import 'package:ems/screens/elderly/elderly.dart';
import 'package:ems/screens/monitor/monitor_data.dart';
import 'package:ems/screens/notification/notification_2.dart';
import 'package:ems/screens/profile/profile.dart';
import 'package:ems/screens/report/report_tabs_2.dart';
import 'package:ems/services/auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Home2 extends StatefulWidget {
  @override
  _Home2State createState() => _Home2State();
}

class _Home2State extends State<Home2> {

  final AuthService _auth = AuthService();
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final test = FirebaseDatabase.instance.reference();
  final color1 = 0xff392850;

  _getToken() {
    _fcm.getToken().then((deviceToken) {
        // print("Device Token: $deviceToken");
        // _update(deviceToken);
    });
  }

  _configureFirebaseListeners() {
  _fcm.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget> [
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    _getToken();
    super.initState();

    _configureFirebaseListeners();
  }

  final Option option1 = new Option(
    title: "Profile",
    img: "images/person.png"
  );
  final Option option2 = new Option(
    title: "Monitor",
    img: "images/heartpulse.png"
  );
  final Option option3 = new Option(
    title: "Elder's Info",
    img: "images/elderly.png"
  );
  final Option option4 = new Option(
    title: "Notification",
    img: "images/email.png"
  );
  final Option option5 = new Option(
    title: "Report",
    img: "images/report.png"
  );
  final Option option6 = new Option(
    title: "About",
    img: "images/info.png"
  );

  @override
  Widget build(BuildContext context) {
    List<Option> optionList = [option1, option2, option3, option4, option5, option6];

    // Get grid tiles
    List<Widget> _getTiles(List<Option> optionList) {
      final List<Widget> tiles = <Widget>[];
      for (int i = 0; i < optionList.length; i++) {
        tiles.add(new GridTile(
          child: Card(
            color: Color(0xff453658),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                side: BorderSide(
                    color: Colors.transparent,
                ),
            ),
            child: new InkResponse(
              enableFeedback: true,
              child: ListTile(
                title:Image.asset(optionList[i].img, fit: BoxFit.cover,),
                subtitle: Text(optionList[i].title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white) ,textAlign: TextAlign.center,),
                onTap: () {
                  if (i == 0) 
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile()));
                  if (i == 1)
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MonitorData()));
                  if (i == 2)
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ElderlyInfo()));
                  if (i == 3)
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NotificationFirebase()));
                  if (i == 4)
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ReportTab2()));
                  if (i == 5)
                    print('About');
                },
              )
            )
          )
        ));
      }
      return tiles;
    }

    // Without List User Detail
    return Scaffold(
      backgroundColor: Color(0xff392850),
      appBar: AppBar(
        title: Text('EMS'),
        backgroundColor:  Color(0xff392850),
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person, color: Colors.white70),
            label: Text('Logout', style: TextStyle(color: Colors.white)),
            onPressed: () async {
              //print('Logout have been pressed');
              await _auth.signOut();
            }, 
          ),
        ],
      ),
      //body: Image.asset('images/info.png'),
      body: new GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        padding: const EdgeInsets.all(8.0),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: _getTiles(optionList),
      )
    );

  }
}
