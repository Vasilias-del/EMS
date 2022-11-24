import 'dart:async';
import 'dart:wasm';
import 'package:ems/models/liveReport.dart';
import 'package:ems/shared/loading.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../font_awesome5_icons.dart';

class LiveReport2 extends StatefulWidget {
  @override
  _LiveReport2State createState() => _LiveReport2State();
}

class _LiveReport2State extends State<LiveReport2> {
  
  
  // final StreamController _streamController = StreamController();
  LiveReportObj  _data;
  List<LiveReportObj> _lReport;
  StreamSubscription<Event> _onEntryLiveReportSubscription;
  final report = FirebaseDatabase.instance.reference().child("sensors");
  final Color color1 = Colors.deepPurple;
  final Color color2 = Color(0xff453658);
  final Color color3 = Color(0xffFB8964);

  DatabaseReference _dataRef = FirebaseDatabase.instance.reference().child("sensors/data");

  void initState() {
    super.initState();
    _lReport = new List();
    // testGetData();
    _onEntryLiveReportSubscription = report.onChildAdded.listen(_onEntryLiveReport);
    // requireData();
  }

  @override
  void dispose() {
    super.dispose();
    _onEntryLiveReportSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff392850),
      body: StreamBuilder(
        stream: _dataRef.onValue,
        builder: (context, snapshot) {
          if(snapshot.hasData && !snapshot.hasError && snapshot.data.snapshot.value != null) {
            // print(snapshot.data.snapshot.value);
            // print("ok");
            _data = LiveReportObj.fromSnapshot(snapshot.data.snapshot);
            // print(_data.bpm);

            return Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                child: Column(
                  children: <Widget>[
                    _buildHeader(),
                    SizedBox(height: 20.0),
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              height: 120,
                              width: 175,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 5.0),
                                  Text("HEART RATE", style: TextStyle(color: Colors.white)),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        height: 50,
                                        width: 50,
                                        // color: Colors.greenAccent,
                                        margin: const EdgeInsets.only(
                                          top: 15,
                                          left: 20
                                        ),
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              child: Icon(
                                                FontAwesome5.heartbeat,
                                                size: 50,
                                              )
                                            ),
                                            // Text("98", style: TextStyle(color: Colors.white)),
                                          ],
                                        )
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Container(
                                            height: 25,
                                            width: 40,
                                            // color: Colors.greenAccent,
                                            margin: const EdgeInsets.only(
                                              top: 30,
                                              left:5,
                                            ),
                                            alignment: Alignment.center,
                                            child: Column(
                                              children: <Widget>[
                                                Text("${_data.bpm}", style: TextStyle(color: Colors.white, fontSize: 19)),
                                              ],
                                            )
                                          ),
                                          Container(
                                            height: 20,
                                            width: 100,
                                            // color: Colors.greenAccent,
                                            margin: const EdgeInsets.only(
                                              top: 10,
                                              left:5,
                                            ),
                                            alignment: Alignment.center,
                                            child: Column(
                                              children: <Widget>[
                                                Text("beat per minute", style: TextStyle(color: Colors.white, fontSize: 12)),
                                              ],
                                            )
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                                gradient: LinearGradient(
                                  colors: [color2, color2],
                                )
                              )
                            ),
                          ],
                        ),
                        SizedBox(width: 20.0),
                          Column(
                            children: <Widget>[
                              Container(
                                height: 120,
                                width: 175,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 5.0),
                                    Text("TEMPERATURE", style: TextStyle(color: Colors.white)),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          height: 50,
                                          width: 50,
                                          // color: Colors.greenAccent,
                                          margin: const EdgeInsets.only(
                                            top: 15,
                                            left: 20
                                          ),
                                          alignment: Alignment.center,
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                child: Icon(
                                                  FontAwesome5.thermometer_half,
                                                  size: 50,
                                                )
                                              )
                                              // Text("98", style: TextStyle(color: Colors.white)),
                                            ],
                                          )
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Container(
                                              height: 25,
                                              width: 40,
                                              // color: Colors.greenAccent,
                                              margin: const EdgeInsets.only(
                                                top: 30,
                                                left:5,
                                              ),
                                              alignment: Alignment.center,
                                              child: Column(
                                                children: <Widget>[
                                                  Text("${_data.temperature}", style: TextStyle(color: Colors.white, fontSize: 19)),
                                                ],
                                              )
                                            ),
                                            Container(
                                              height: 20,
                                              width: 100,
                                              // color: Colors.greenAccent,
                                              margin: const EdgeInsets.only(
                                                top: 10,
                                                left:5,
                                              ),
                                              alignment: Alignment.center,
                                              child: Column(
                                                children: <Widget>[
                                                  Text("celcius °C", style: TextStyle(color: Colors.white, fontSize: 12)),
                                                ],
                                              )
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  ),
                                  gradient: LinearGradient(
                                    colors: [color2, color2],
                                  )
                                )
                              ),
                            ],
                          ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Column(
                      children: <Widget>[
                        Container(
                          height: 120,
                          width: 175,
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 5.0),
                              Text("HEALTH", style: TextStyle(color: Colors.white)),
                              Row(
                                children: <Widget>[
                                  Container(
                                    height: 50,
                                    width: 50,
                                    // color: Colors.greenAccent,
                                    margin: const EdgeInsets.only(
                                      top: 15,
                                      left:20,
                                    ),
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: Icon(
                                            FontAwesome5.user,
                                            size: 50,
                                          )
                                        )
                                      ],
                                    )
                                  ),
                                  Container(
                                    height: 50,
                                    width: 70,
                                    margin: const EdgeInsets.only(
                                      top: 40,
                                      left:20,
                                    ),
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: <Widget>[
                                        Text("${_data.condition}", style: TextStyle(color: Colors.white, fontSize: 19)),
                                      ],
                                    )
                                  ),
                                ],
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                            gradient: LinearGradient(
                              colors: [color2, color2],
                            ),
                          )
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Column(
                      children: <Widget>[
                        Container(
                          height: 160,
                          width: 400,
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 5.0),
                              Text("MOVEMENT", style: TextStyle(color: Colors.white)),
                              Column(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(
                                      top: 15,
                                      left:20,
                                    ),
                                    child: Text("g below 2.0 is normal!",style: TextStyle(color: Colors.orangeAccent, fontSize: 15))
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    height: 50,
                                    width: 50,
                                    // color: Colors.greenAccent,
                                    margin: const EdgeInsets.only(
                                      bottom: 15,
                                      left:20,
                                    ),
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: Icon(
                                            FontAwesome5.walking,
                                            size: 50,
                                          )
                                        )
                                      ],
                                    )
                                  ),
                                  Container(
                                    height: 20,
                                    width: 70,
                                    margin: const EdgeInsets.only(
                                      bottom: 20,
                                      left:10,
                                    ),
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: <Widget>[
                                        Text("x-axis: ${_data.x}", style: TextStyle(color: Colors.white, fontSize: 15)),
                                        // Text("${_data.condition}", style: TextStyle(color: Colors.white, fontSize: 19)),
                                      ],
                                    )
                                  ),
                                  Container(
                                    height: 20,
                                    width: 70,
                                    margin: const EdgeInsets.only(
                                      bottom: 20,
                                      left:0,
                                    ),
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: <Widget>[
                                        Text("y-axis: ${_data.y}", style: TextStyle(color: Colors.white, fontSize: 15)),
                                        // Text("${_data.condition}", style: TextStyle(color: Colors.white, fontSize: 19)),
                                      ],
                                    )
                                  ),
                                  Container(
                                    height: 20,
                                    width: 70,
                                    margin: const EdgeInsets.only(
                                      bottom: 20,
                                      left:0,
                                    ),
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: <Widget>[
                                        Text("z-axis: ${_data.z}", style: TextStyle(color: Colors.white, fontSize: 15)),
                                        // Text("${_data.condition}", style: TextStyle(color: Colors.white, fontSize: 19)),
                                      ],
                                    )
                                  ),
                                  Container(
                                    height: 20,
                                    width: 50,
                                    margin: const EdgeInsets.only(
                                      bottom: 20,
                                      left:5,
                                    ),
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: <Widget>[
                                        Text("g: ${_data.g}", style: TextStyle(color: Colors.white, fontSize: 15)),
                                        // Text("${_data.condition}", style: TextStyle(color: Colors.white, fontSize: 19)),
                                      ],
                                    )
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Container(

                                    margin: const EdgeInsets.only(
                                      top: 0,
                                      left:30,
                                    ),
                                    child: Text("${_data.fall}",style: TextStyle(color: Colors.white, fontSize: 15))
                                  )
                                ],
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                            gradient: LinearGradient(
                              colors: [color2, color2],
                            ),
                          )
                        ),
                      ],
                    )
                  ],
                ),
              )
            );
          } else { 
            return Loading();
          }
        }
      )
    
    );
  }

  Container _buildHeader() {
    return Container(
      height: 50,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            top: 0,
            child: Container(
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
                gradient: LinearGradient(
                  colors: [color1, color1],
                )
              )
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 15,
            ),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Text('Elderly Condition Information', style: TextStyle( 
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0
                  ), 
                ),
              ],
            )
          ),
        ],
      ),
    );
  }

  void _onEntryLiveReport(Event event) async {
    setState(() {
        // print(event.snapshot.value);
      _lReport.add(new LiveReportObj.fromSnapshot(event.snapshot));
    });
  }
}

