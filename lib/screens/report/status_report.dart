import 'dart:async';
import 'package:ems/font_awesome5_icons.dart';
import 'package:ems/models/statusReport.dart';
import 'package:ems/shared/loading.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class StatusReport extends StatefulWidget {
  @override
  _StatusReportState createState() => _StatusReportState();
}

class _StatusReportState extends State<StatusReport> {

  List<StatReport> _status;
  StreamSubscription<Event> _onEntryAddedStatusSubscription;
  final statReport = FirebaseDatabase.instance.reference().child("report"); 

  @override
  void initState() {
    super.initState();
    _status = new List();
    // status.orderByChild('timestamp').limitToLast(20).onChildAdded.listen((data){
    //   print(data.snapshot.value);
    // });
    _onEntryAddedStatusSubscription = statReport.orderByChild('timestamp').limitToLast(20).onChildAdded.listen(_onEntryAddedStatus);
  }

  @override
  void dispose() {
    _onEntryAddedStatusSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(_status.length >= 0) {
      return Scaffold(
        backgroundColor: Color(0xff392850),
        body: ListView.builder(
          itemCount: null == _status ? 0 : _status.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white70,
              child: new ListTile(
                leading: const Icon(FontAwesome5.newspaper),
                title: Text('${_status[index].condition}'),
                subtitle: Text('Beat per minute: ${_status[index].bpm} \nTemperature: ${_status[index].temperature} \nDate: ${_status[index].date}'),
              ),
            );
          }
        )
      );
    } else {
      return Loading();
    }
  }

  void _onEntryAddedStatus(Event event) {
    setState((){
      // print(event.snapshot);
      _status.add(new StatReport.fromSnapshot(event.snapshot));
    });
  }
}