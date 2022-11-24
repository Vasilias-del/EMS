import 'package:flutter/material.dart';
// import 'package:ems/models/sensorData.dart';
import 'package:firebase_database/firebase_database.dart';

class Monitor extends StatefulWidget {
  @override
  _MonitorState createState() => _MonitorState();
}

class _MonitorState extends State<Monitor> {
  
  // SensorData _sensorData;
  //List<SensorData> sensorData;
  bool isInitialDataLoaded = false;

  @override
  void initState() {
    super.initState();
    //DatabaseReference ref = FirebaseDatabase.instance.reference().child("sensors");
    DatabaseReference sensors = FirebaseDatabase.instance.reference().child("sensorsupdate");
    // DatabaseReference monitorbpm = FirebaseDatabase.instance.reference().child("sensorsupdate/bpm");
    // DatabaseReference monitortemp = FirebaseDatabase.instance.reference().child("sensorsupdate/temperature");

    sensors.onValue.listen((event) {
      setState(() { 
        isInitialDataLoaded = true;
      });
    });

    sensors.onValue.listen((data){
      if (isInitialDataLoaded) {
        var sdata = data.snapshot.value;
        String stemp = sdata["bpm"].toString();
        String sbpm = sdata["bpm"].toString();
        double dtemp = double.parse(stemp);
        double dbpm = double.parse(sbpm);
        // temp = data.snapshot.value;

        print(dtemp);
        print(dbpm);
        // _sensorData = SensorData(sdata["bpm"], sdata["temoerature"]);
      }
    });

    // monitorbpm.onValue.listen((event) {
    //   setState(() { 
    //     isInitialDataLoaded = true;
    //   });
    // });

    // monitortemp.onValue.listen((event) {
    //   setState(() { 
    //     isInitialDataLoaded = true;
    //   });
    // });

    // monitorbpm.onValue.listen((data){
    //   if (isInitialDataLoaded) {
    //     var bpm = data.snapshot.value;
    //     //var temp = data.snapshot.value;
    //     print(bpm);
    //   }
    // });

    // monitortemp.onValue.listen((data){
    //   if (isInitialDataLoaded) {
    //     var temp = data.snapshot.value;
    //     print(temp);
    //   }
    // });
    // ref.child('bpm').onChildAdded.listen((data){
    //   if (isInitialDataLoaded) {
    //     
    //     var bpm = data.snapshot.value;
    //     print(bpm);
    //   }
    // });

    // ref.child('temperature').onChildAdded.listen((data){
    //   if (isInitialDataLoaded) {
    //     
    //     var temp = data.snapshot.value;
    //     print(temp);
    //   }
    // });
  //   ref.once().then((DataSnapshot snapshot){
  //     Map<dynamic, dynamic> values = snapshot.value;
  //       values.forEach((key,values) {
  //         print(values["name"]);
  //       });
  //   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text('Monitor'),
        backgroundColor:  Colors.blue[400],
        elevation: 0.0,
      ),
      body: Container(
        // child: _sensorData.bpm  == 0 ? Text("No data is available") : 
        // new ListView.builder(
        //   itemCount: 1,
        //   itemBuilder: ( _, index){
        //   return UI(_sensorData.bpm, _sensorData.temperature);
        // }),
      ),
    );
  }

  // Widget UI(double bpm, double temperature) {
  //   return new Card(
  //     child: Text("BPM: $bpm"),
  //   );
  // }
}