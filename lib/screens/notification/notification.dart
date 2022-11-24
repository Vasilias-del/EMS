// import 'package:flutter/material.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// class NotificationFirebase extends StatefulWidget {
//   @override
//   _NotificationFirebaseState createState() => _NotificationFirebaseState();
// }

// class _NotificationFirebaseState extends State<NotificationFirebase> {

//   List<Message> _messages;
//   final FirebaseMessaging _fcm2 = FirebaseMessaging();

//   _setMessage(Map<String, dynamic> message){
//     final notification = message['notification'];
//     final data = message['data'];
//     final String title = notification['title'];
//     final String body = notification['body'];
//     final String mMsg = data['Msg'];

//     Message m = Message(title, body, mMsg);
//     _messages.add(m);
//   }

//   _configureNotification() {
//     _fcm2.configure(
//       // ignore: missing_return
//       onMessage: (Map<String, dynamic> message) {
//         print("onMessage: $message");
//         _setMessage(message);
//       },
//       // ignore: missing_return
//       onLaunch: (Map<String, dynamic> message) {
//         print("onLaunch: $message");
//         _setMessage(message);
//       },
//       // ignore: missing_return
//       onResume: (Map<String, dynamic> message) {
//         print("onResume: $message");
//         _setMessage(message);
//       },
//     );
//   }

//   @override
//   void initState() {
//     _messages = List<Message>();
//     _configureNotification();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Notification")),
//     );
//     body: ListView.builder(
//       itemCount: null == _messages ? 0 : _messages.length,
//       itemBuilder: (context, index) {
//           return Card(
//             child: Padding(
//               padding: EdgeInsets.all(15.0),
//               child: Text(
//                 _messages[index].msg,
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   color: Colors.black,
//                 ),
//               )
//             ),
//           );
//       },
//     );
//   }
// }

// class Message {
//   String title;
//   String body;
//   String msg;
//   Message(title, body, msg) {
//     this.title = title;
//     this.body = body;
//     this.msg = msg;
//   }
// }