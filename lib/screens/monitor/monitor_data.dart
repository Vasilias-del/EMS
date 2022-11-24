import 'package:ems/models/CircleProgress.dart';
import 'package:ems/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class MonitorData extends StatefulWidget {
  @override
  _MonitorDataState createState() => _MonitorDataState();
}

class _MonitorDataState extends State<MonitorData> with TickerProviderStateMixin {

  DatabaseReference sensors = FirebaseDatabase.instance.reference();
  // StreamSubscription<Event> _counterSubscription;

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
    // sensors.keepSynced(true);
    // _counterSubscription = sensors.child("sensorsupdate").onValue.listen((Event event) {
    //   setState(() {
    //     _counter = event.snapshot.value ?? 0;
    //   });
    // });

    sensors.child("sensorsupdate").onValue.listen((data){
      sensor = data.snapshot.value;
      vbpm = sensor["bpm"];
      vtemp = sensor["temperature"];
      sbpm = vbpm.toString();
      stemp = vtemp.toString();
      bpm = double.parse(sbpm);
      temp = double.parse(stemp);

      // print(bpm);
      // print(temp);

      if(bpm == null || temp == null) {
        Loading();
      } else {
        monitorDataInit(temp, bpm);
      }
    });
    
    // sensors.child("sensorsupdate").once().then((DataSnapshot snapshot){
    //   vbpm = snapshot.value['bpm'];
    //   vtemp = snapshot.value["temperature"];
    //   sbpm = vbpm.toString();
    //   stemp = vtemp.toString();
    //   bpm = double.parse(sbpm);
    //   temp = double.parse(stemp);


    //   print(bpm);
    //   _MonitorDataInit(temp, bpm);
    // });
  }

  @override
  void dispose() {
    // cancel your subscription when the class is removed
    super.dispose();
    // sensors.cancel();
  }

  monitorDataInit(double temp, double bpm) {
    progressController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    
    tempAnimation = Tween<double>(begin: -50, end: temp).animate(progressController)..addListener((){
      setState(() {
        temp = this.temp;
      });
    });

    bpmAnimation = Tween<double>(begin: -50, end: bpm).animate(progressController)..addListener((){
      setState(() {
        bpm = this.bpm;
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
            const Divider(
              color: Colors.black,
              height: 20,
              thickness: 1,
              indent: 0,
              endIndent: 0,
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
}