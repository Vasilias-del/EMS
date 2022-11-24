import 'dart:async';

import 'package:ems/models/liveReport.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../font_awesome5_icons.dart';

class LiveReport extends StatefulWidget {
  @override
  _LiveReportState createState() => _LiveReportState();
}

class _LiveReportState extends State<LiveReport> {
  
  
  // final StreamController _streamController = StreamController();
  List<LiveReportObj> _lReport;
  StreamSubscription<Event> _onEntryLiveReportSubscription;
  final report = FirebaseDatabase.instance.reference().child("sensors");
  // final Color color1 = Color(0xffFA696C);
  // final Color color2 = Color(0xffFA8165);
  // final Color color1 = Color(0xFF757575);
  // final Color color2 = Color(0xFF9E9E9E);
  final Color color1 = Colors.deepPurple;
  final Color color2 = Color(0xff453658);
  final Color color3 = Color(0xffFB8964);
  // testGetData() {
  //   report.onChildAdded.listen((event){
  //     print(event.snapshot.key+": "+event.snapshot.value.toString());
  //   });
  // }

  // requireData() {
  //   report.onChildAdded.listen((data){
  //     print(data.snapshot);
  //     _streamController.sink.add(data.snapshot);
  //   });
  // }

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
    // return Scaffold(
    //   body: Center(
    //     // child: StreamBuilder(
    //     //   stream: _streamController.stream,
    //     //   builder: (context, snapshot) {
    //     //     if (snapshot.hasError){
    //     //       return Text("Error in Snapshot!");
    //     //     } else if (snapshot.connectionState == ConnectionState.waiting) {
    //     //       return CircularProgressIndicator();
    //     //     } else {
    //     //       return Text('${snapshot.data["bpm"]}');
    //     //     }
    //     //   }  
    //     // )
    //     child: ListView.builder(
    //       itemCount: null == _lReport ? 0 : _lReport.length,
    //       itemBuilder: (context, index) {
    //         return Container(
    //           color: Colors.grey[400],
    //           child:Card(
    //             color: Colors.red[200],
    //             child: new ListTile(
    //               leading: const Icon(Icons.album),
    //               title: Text("Health Report"),
    //               subtitle: Text('${_lReport[index].condition}'),
    //             ),
    //           ),
    //         );
    //       },
    //     )
    //   )
    // );

    // return Scaffold(
    //   backgroundColor: Colors.grey[400],
    //   body: ListView.builder(
    //     itemCount: null == _lReport ? 0 : _lReport.length,
    //     itemBuilder: (context, index) {
    //       return Padding(
    //         padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
    //         child: Column(
    //           children: <Widget>[
    //             // CircleAvatar(
    //             //   backgroundImage: AssetImage('images/elderly.jpg'),
    //             //   radius: 40.0,
    //             // ),
    //             const Divider(
    //               color: Colors.blue,
    //               height: 20,
    //               thickness: 1,
    //               indent: 0,
    //               endIndent: 0,
    //             ),
    //             Container(
    //               child: Text('Elderly Condition'),
    //               margin: EdgeInsets.all(10.0),
                  
    //             ),
    //             // Card(
    //             //   color: Colors.red[200],
    //             //   child: new ListTile(
    //             //     leading: const Icon(Icons.album),
    //             //     title: Text("Health Report"),
    //             //     subtitle: Text('${_lReport[index].condition}'),
    //             //   ),
    //             // ),
    //             const Divider(
    //               color: Colors.blue,
    //               height: 20,
    //               thickness: 1,
    //               indent: 0,
    //               endIndent: 0,
    //             ),
    //             Container(
    //               child: Row(
    //                 children: <Widget>[
    //                   Container(
    //                     padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
    //                     child: Text(" BPM:  "),
    //                   ),
    //                   Container(
    //                     padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
    //                     child: Text(" BPM:  "),
    //                   ),
    //                 ],
    //               ),
    //               margin: EdgeInsets.all(10.0),
    //             ),
    //             Row(
    //               children: <Widget>[
    //                 Container(
    //                   padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
    //                   child: Text(" BPM:  "),
    //                 ),
    //                 Container(
    //                   padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
    //                   child: Text(" BPM:  "),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       );
    //     }
    //   )
    // );
    return Scaffold(
      backgroundColor: Color(0xff392850),
      body: ListView.builder(
        itemCount: null == _lReport ? 0 : _lReport.length,
        itemBuilder: (context, index) {
          return Padding(
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
                                            Text("${_lReport[index].bpm}", style: TextStyle(color: Colors.white, fontSize: 19)),
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
                                            Text("${_lReport[index].temperature}", style: TextStyle(color: Colors.white, fontSize: 19)),
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
                    // Container(
                    //   height: 120,
                    //   width: 175,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.only(
                    //       topLeft: Radius.circular(5),
                    //       topRight: Radius.circular(5),
                    //       bottomLeft: Radius.circular(5),
                    //       bottomRight: Radius.circular(5),
                    //     ),
                    //     gradient: LinearGradient(
                    //       colors: [color2, color2],
                    //     )
                    //   )
                    // ),
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
                                    Text("${_lReport[index].condition}", style: TextStyle(color: Colors.white, fontSize: 19)),
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
                )
              ],
            ),
          );
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
        print(event.snapshot.value);
      _lReport.add(new LiveReportObj.fromSnapshot(event.snapshot));
    });
  }
}

