import 'dart:async';
import 'package:ems/models/CircleProgress.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class MonitorData2 extends StatefulWidget {
  @override
  _MonitorData2State createState() => _MonitorData2State();
}

class _MonitorData2State extends State<MonitorData2> with TickerProviderStateMixin {

  final sensors = FirebaseDatabase.instance.reference();
  StreamSubscription<Event> _onEntryChangedMonitorSubscription;

  AnimationController progressController;
  Animation<double> tempAnimation;
  Animation<double> bpmAnimation;

  double temp, bpm;
  var vtemp, vbpm;
  String stemp, sbpm;
  var sensor;

  @override
  void initState() {

    super.initState();
    _onEntryChangedMonitorSubscription = sensors.child("sensorsupdate").onValue.listen(_onEntryChangedMonitor);
  }

  @override
  void dispose() {
    _onEntryChangedMonitorSubscription.cancel();
    super.dispose();
    // sensors.cancel();
  }

  void monitorDataInit(double temp, double bpm) {
    progressController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    tempAnimation = Tween<double>(begin: -50, end: temp).animate(progressController)..addListener((){
      setState(() {
        
      });
    });

    bpmAnimation = Tween<double>(begin: -50, end: bpm).animate(progressController)..addListener((){
      setState(() {
        
      });
    });

    progressController.forward();
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget> [
            CustomPaint(
              foregroundPainter: CircleProgress(tempAnimation.value, true),
              child: Container(
                width: 200,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Temperature"),
                    Text(
                      '${tempAnimation.value.toInt()}',
                      style: TextStyle(
                        fontSize: 50, fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('°C', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                  ],
                )
              ),
            ),
            CustomPaint(
              foregroundPainter: CircleProgress(bpmAnimation.value, false),
              child: Container(
                width: 200,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("BPM"),
                    Text(
                      '${bpmAnimation.value.toInt()}',
                      style: TextStyle(
                        fontSize: 50, fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('bpm', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                  ],
                )
              ),
            ),
          ]
        )
      )
    );
  }

  void _onEntryChangedMonitor(Event event) {
    setState(() {
      // _messages.add(new Message.fromSnapshot(event.snapshot));
      sensor = event.snapshot.value;
      vbpm = sensor["bpm"];
      vtemp = sensor["temperature"];
      sbpm = vbpm.toString();
      stemp = vtemp.toString();

      bpm = double.parse(sbpm);
      temp = double.parse(stemp);

      monitorDataInit(temp, bpm);
    });
  }
}