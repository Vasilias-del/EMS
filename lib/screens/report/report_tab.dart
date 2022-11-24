// import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void calculateDate(){
  DateTime now = new DateTime.now();
  String convertedDate = new DateFormat("yyyy-MM-dd").format(now);
  print(convertedDate);
}

class ReportTab extends StatefulWidget {
  @override
  _ReportTabState createState() => _ReportTabState();
}

class _ReportTabState extends State<ReportTab> {

  DatabaseReference data = FirebaseDatabase.instance.reference();
  // StreamSubscription<Event> _counterSubscription;

  // Testing query Data
  int i = 0;
  double total = 0, avg = 0;
  final sensors = FirebaseDatabase.instance.reference();
  final sensorsByDate = FirebaseDatabase.instance.reference().child("test/sensors/bpm").orderByChild("date").startAt("2020-07-22 01:30:00").endAt("2020-07-22 01:30:02");
  final count = FirebaseDatabase.instance.reference().child("test/sensors/bpm").orderByChild("date");
  final countByDate = FirebaseDatabase.instance.reference().child("test/sensors/bpm").orderByChild("date").startAt("2020-07-22 01:30:00").endAt("2020-07-22 01:30:02");


  // Future<int> test = getDailyCount();

  void initState() {
    // Call the function in here
    // pTODO save data
    // _saveData(Todo("1", "Test"));

    // Test
    // bpmCountByDateCount();
    // bpmCountByDate();

    // avg = bpm.getTotalBPM()/bpm.getCount();
    // print(avg);
    
    // calculateAVG();
    super.initState();
  }

  void allBpmData() {
      // Query bpm parent
      sensors.child('test/sensors/bpm').onChildAdded.forEach((event) {
      print(event.snapshot.key+": "+event.snapshot.value.toString());
      // print(event.snapshot.key.length);
      this.setState(() {
    
      });
    });
  }

  void bpmSpecificChild() {
    // Query BPM the print Specific child -> succeed
    sensors.child('test/sensors/bpm').onChildAdded.forEach((event) {
      print(event.snapshot.key+": "+event.snapshot.value.toString());
      var properties = event.snapshot.value;
      var value = properties['date'];
      print(value);
      this.setState(() {
    
      });
    });
  }

  void bpmByDate() {
    // Query Specific data -> succeed
    sensorsByDate.once().then((DataSnapshot snapshot){
      print(snapshot.key+": "+snapshot.value.toString());
    });
  }

  void bpmCount(){
    // Query data by date and count the child -> succeed
    count.once().then((onValue) {
      Map data = onValue.value;
      i = data.length;
      print(i);
      print(onValue.key+": "+onValue.value.toString());
    });
  }

  void bpmCountByDateCount(){
    // Query data by date and count the child -> succeed
    countByDate.once().then((onValue) {
      Map data = onValue.value;
      i = data.length;
      // print(i);
      // print(onValue.key+": "+onValue.value.toString());
    });
  }

  void bpmCountByDate(){
    // Query data by date the child -> succeed
    countByDate.onChildAdded.forEach((event) {
      var properties = event.snapshot.value;
      var value = properties['value'];
      // print(onValue.key+": "+onValue.value.toString());
      // print(value);
      total +=value; 
    });
  }

  void calculateAVG(){

    countByDate.onChildAdded.forEach((event) {
      var properties = event.snapshot.value;
      var value = properties['value'];
      // print(onValue.key+": "+onValue.value.toString());
      // print(value);
      total +=value;
    });

    countByDate.once().then((onValue) {
      Map data = onValue.value;
      i = data.length;
      // print(i);
      // print(onValue.key+": "+onValue.value.toString());
    });

    avg = total/i;
    print(avg);
  }


  @override
  Widget build(BuildContext context) {
      return DefaultTabController(
        length: 3, 
        child: Scaffold(
          appBar: AppBar(
            title: Text("Report"),
            bottom: TabBar(
              tabs: <Widget>[
                Text("Daily Graph"),
                Text("Weekly Graph"),
                Text("Monthly Graph")
              ]
            ),
          ),
          body: TabBarView(
            children: <Widget>[
                // Text("Daily Graph Selected"),
                DailyReport(),
                Text("Weekly Graph Selected"),
                Text("Monthly Graph Selected")
            ]
          ),
        ),
      );
  }
  void readData() {
     data.once().then((DataSnapshot dataSnapshot){
        print(dataSnapshot.value);
    });
  }

}

class DailyReport extends StatefulWidget {
  @override
  _DailyReportState createState() => _DailyReportState();
}

class _DailyReportState extends State<DailyReport> {
  
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}


// Testing json encode

// const jsonCode = const JsonCodec();

// void _saveData(Todo todo) {
//   var json = jsonCode.encode(todo);
//   print("json = $json");

//   // var url = "https://elderlymonitoringsystem-2f6b7.firebaseio.com/gau.json";
//   // var httpClient = createHttpClient();
// }

// class Todo {
//   String code;
//   String name;

//   Todo(this.code, this.name);

//   Map toJson() {
//     return {"code": code, "name": name};
//   }
// }





