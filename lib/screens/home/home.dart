import 'package:ems/models/option.dart';
import 'package:ems/screens/elderly/elderly.dart';
import 'package:ems/screens/monitor/monitor_data.dart';
// import 'package:ems/screens/monitor/monitor.dart';
// import 'package:ems/screens/monitor/monitor_data.dart';
// import 'package:ems/screens/monitor/monitor_data_2.dart';
import 'package:ems/screens/notification/notification_2.dart';
import 'package:ems/screens/profile/profile.dart';
// import 'package:ems/screens/report/report_tab.dart';
import 'package:ems/screens/report/report_tabs_2.dart';
import 'package:ems/services/auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

// List User Detail 
// import 'package:ems/services/database.dart';
// import 'package:provider/provider.dart';
// import 'package:ems/screens/home/user_list.dart';
// import 'package:ems/models/user_detail.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final test = FirebaseDatabase.instance.reference();

  _getToken() {
    _fcm.getToken().then((deviceToken) {
        // print("Device Token: $deviceToken");
        // _update(deviceToken);
    });
  }

  // _update(String token){
  //   final fcmToken = FirebaseDatabase.instance.reference();
  //   fcmToken.child('fcm-token/${token}').set({"token": token});
  //   // textValue = token;
  //   setState(() {
      
  //   });
  // }

  _configureFirebaseListeners() {
  _fcm.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");

        // final snackbar = SnackBar(
        //   content: Text(message['notification']['title']),
        //   action: SnackBarAction(
        //     label: 'Go',
        //     onPressed: () =>null,
        //   ),
        // );

        // Scaffold.of(context).showSnackBar(snackbar);

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
            color: Colors.blue[200],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                side: BorderSide(
                    color: Colors.blue[200]
                ),
            ),
            child: new InkResponse(
              enableFeedback: true,
              child: ListTile(
                title:Image.asset(optionList[i].img, fit: BoxFit.cover,),
                subtitle: Text(optionList[i].title, style: TextStyle(fontWeight: FontWeight.bold) ,textAlign: TextAlign.center,),
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
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text('EMS'),
        backgroundColor:  Colors.blue[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Logout'),
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

    // List User Detail 
    // return StreamProvider<List<UserDetail>>.value(
    //   value: DatabaseService().users,
    //   child: Scaffold(
    //     backgroundColor: Colors.blue[100],
    //     appBar: AppBar(
    //       title: Text('EMS'),
    //       backgroundColor:  Colors.blue[400],
    //       elevation: 0.0,
    //       actions: <Widget>[
    //         FlatButton.icon(
    //           icon: Icon(Icons.person),
    //           label: Text('Logout'),
    //           onPressed: () async {
    //             //print('Logout have been pressed');
    //             await _auth.signOut();
    //           }, 
    //         ),
    //       ],
    //     ),
    //     body: UserList(),
    //   ),
    // );
  }
}

// void _onTileClicked(int index){
//   debugPrint("You tapped on item $index");
// }