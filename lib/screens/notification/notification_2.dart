import 'dart:async';
import 'package:ems/models/mesage.dart';
import 'package:ems/shared/loading.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class NotificationFirebase extends StatefulWidget {
  @override
  _NotificationFirebaseState createState() => _NotificationFirebaseState();
}

class _NotificationFirebaseState extends State<NotificationFirebase> {

  List<Message> _messages;
  StreamSubscription<Event> _onEntryAddedNotificationSubscription;
  final notification = FirebaseDatabase.instance.reference().child("notification");

  @override
  void initState() {
    super.initState();
    _messages = new List();
    _onEntryAddedNotificationSubscription = notification.orderByChild('timestamp').limitToLast(20).onChildAdded.listen(_onEntryAddedNotification);
  }

  @override
  void dispose() {
    _onEntryAddedNotificationSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_messages.length>0) {
      return Scaffold(
        backgroundColor: Color(0xff392850),
        appBar: AppBar(title: Text("Notification"), backgroundColor: Color(0xff392850)),
        body: ListView.builder(
          itemCount: null == _messages ? 0 : _messages.length,
          itemBuilder: (context, index) {
              return Card(
                color: Colors.white70,
                child: new ListTile(
                  leading: const Icon(Icons.message),
                  title: Text('${_messages[index].msg}'),
                  subtitle: Text('${_messages[index].datetime}'),
                ),
              );
          },
        )
      );
    } else {
      return Loading();
    }
  }

  void _onEntryAddedNotification(Event event) {
    setState(() {
      _messages.add(new Message.fromSnapshot(event.snapshot));
    });
  }
}


