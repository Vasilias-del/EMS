import 'package:ems/screens/report/live_report.dart';
import 'package:ems/screens/report/live_report_2.dart';
import 'package:ems/screens/report/status_report.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

class ReportTab2 extends StatefulWidget {
  @override
  _ReportTab2State createState() => _ReportTab2State();
}

class _ReportTab2State extends State<ReportTab2> {

  // LiveReport _liveReport;
  // List<LiveReport> _liveReportRef;
  // StreamSubscription<Event> _onEntryLiveReportSubscription;
  // final StreamController _streamController = StreamController();
  // final report = FirebaseDatabase.instance.reference().child("sensorsupdate");

  // requireData() async {
  //   report.onChildChanged.listen((data){
  //     _streamController.sink.add(data);
  //   });
  // }

  // void getData() {
  //   report.onChildAdded.listen((event){
  //     print(event);
  //   });
  // }

  void initState() {
    super.initState();
    // getData();
    // print("data");
    // requireData();
    // _liveReportRef = new List();
    // _onEntryLiveReportSubscription = report.onChildChanged.listen(_onEntryLiveReport);
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
      return DefaultTabController(
        length: 2, 
        child: Scaffold(
          appBar: AppBar(
            title: Text("Report"),
            backgroundColor: Color(0xff392850),
            bottom: TabBar(
              tabs: <Widget>[
                Text("Live Report"),
                Text("Status Report")
              ]
            ),
          ),
          body: TabBarView(
            children: <Widget>[
                // Text("Daily Graph Selected"),
                LiveReport2(),
                StatusReport()
            ]
          ),
        ),
      );
  }

  // void _onEntryLiveReport(Event event) {
  //   setState(() {
  //     // _messages.add(new Message.fromSnapshot(event.snapshot));
  //     _liveReport = new LiveReport.fromSnapshot(event.snapshot);
  //   });
  // }
}

// class DailyReport extends StatefulWidget {
//   @override
//   _DailyReportState createState() => _DailyReportState();
// }

// class _DailyReportState extends State<DailyReport> {
  
// //  final StreamController _streamController = StreamController();
// // final report = FirebaseDatabase.instance.reference().child("sensorsupdate");

// //   requireData() {
// //     report.onChildAdded.listen((data){
// //       print(data);
// //         _streamController.sink.add(data);
// //     });
// //   }

// //   void initState() {
// //     super.initState();
// //     requireData();
// //   }

// //   @override
// //   void dispose() {
// //     super.dispose();
// //   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // child: Center(
//       //   child: StreamBuilder(
//       //     stream: _streamController.stream,
//       //     builder: (context, snapshot) {
//       //       if (snapshot.hasError){
//       //         return Text("Error in Snapshot!");
//       //       } else if (snapshot.connectionState == ConnectionState.waiting) {
//       //         return CircularProgressIndicator();
//       //       } else {
//       //         return Text("${snapshot.data}");
//       //       }
//       //     }  
//       //   )
//       // )
//     );
//   }
// }

// class LiveReport {
//   String _key;
//   String _date;
//   String _condition;
//   String _fall;
//   double _bpm;
//   double _temperature;
//   double _g;
//   double _x;
//   double _y;
//   double _z;
 

//   LiveReport(this._key, this._date, this._condition, this._fall, this._bpm, this._temperature, this._g, this._x, this._y, this._z);

//   LiveReport.map(dynamic obj){
//     this._key = obj['id'];
//     this._date = obj['date'];
//     this._condition = obj['condition'];
//     this._fall = obj['fall'];
//     this._bpm = obj['bpm'];
//     this._temperature = obj['temperature'];
//     this._g = obj['g'];
//     this._x = obj['x'];
//     this._y = obj['y'];
//     this._z = obj['z'];
//   }

//   String get key => _key;
//   String get date => _date;
//   String get condition => _condition;
//   String get fall => _fall;
//   double get bpm => _bpm;
//   double get temperature => _temperature;
//   double get g => _g;
//   double get x => _x;
//   double get y => _y;
//   double get z => _z;

//   LiveReport.fromSnapshot(DataSnapshot snapshot){
//         _key = snapshot.key;
//         _date = snapshot.value["date"];
//         _condition = snapshot.value['condition'];
//         _fall = snapshot.value['fall'];
//         _bpm = snapshot.value['bpm'];
//         _temperature = snapshot.value['temperature'];
//         _g = snapshot.value['g'];
//         _x = snapshot.value['x'];
//         _y = snapshot.value['y'];
//         _z = snapshot.value['z'];
//   }
// }






