import 'package:firebase_database/firebase_database.dart';

class LiveReportObj {
  String _key;
  String _date;
  String _condition;
  String _fall;
  double _bpm;
  double _temperature;
  double _g;
  int _x;
  int _y;
  int _z;
 
  LiveReportObj(this._key, this._date, this._condition, this._fall, this._bpm, this._temperature, this._g, this._x, this._y, this._z);

  LiveReportObj.map(dynamic obj){
    this._key = obj['id'];
    this._date = obj['date'];
    this._condition = obj['condition'];
    this._fall = obj['fall'];
    this._bpm = obj['bpm'];
    this._temperature = obj['temperature'];
    this._g = obj['g'];
    this._x = obj['x'];
    this._y = obj['y'];
    this._z = obj['z'];
  }

  String get key => _key;
  String get date => _date;
  String get condition => _condition;
  String get fall => _fall;
  double get bpm => _bpm;
  double get temperature => _temperature;
  double get g => _g;
  int get x => _x;
  int get y => _y;
  int get z => _z;

  LiveReportObj.fromSnapshot(DataSnapshot snapshot){
        _key = snapshot.key;
        _date = snapshot.value["date"];
        _condition = snapshot.value['condition'];
        _fall = snapshot.value['fall'];
        _bpm = snapshot.value['bpm'];
        _temperature = snapshot.value['temperature'];
        _g = snapshot.value['g'];
        _x = snapshot.value['x'];
        _y = snapshot.value['y'];
        _z = snapshot.value['z'];
  }
}