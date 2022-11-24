import 'package:firebase_database/firebase_database.dart';

class StatReport {
  String _key;
  String _date;
  String _condition;
  double _bpm;
  double _temperature;
  int _timestamp;
 
  StatReport(this._key, this._date, this._condition, this._bpm, this._temperature, this._timestamp);

  StatReport.map(dynamic obj){
    this._key = obj['id'];
    this._date = obj['date'];
    this._condition = obj['condition'];
    this._bpm = obj['bpm'];
    this._temperature = obj['temperature'];
    this._timestamp = obj['timestamp'];
  }

  String get key => _key;
  String get date => _date;
  String get condition => _condition;
  double get bpm => _bpm;
  double get temperature => _temperature;
  int get timestamp => _timestamp;


  StatReport.fromSnapshot(DataSnapshot snapshot){
        _key = snapshot.key;
        _date = snapshot.value["date"];
        _condition = snapshot.value['condition'];
        _bpm = snapshot.value['bpm'];
        _temperature = snapshot.value['temperature'];
        _timestamp = snapshot.value['timestamp'];
  }
}