import 'package:firebase_database/firebase_database.dart';

class Message {
  String _key;
  String _datetime;
  String _msg;
  int _timestamp;


  Message(this._key, this._datetime, this._msg, this._timestamp);

  Message.map(dynamic obj){
    this._key = obj['id'];
    this._datetime = obj['datetime'];
    this._msg = obj['msg'];
    this._timestamp = obj['timestamp'];
  }

  String get key => _key;
  String get datetime => _datetime;
  String get msg => _msg;
  int get timestamp => _timestamp;

  Message.fromSnapshot(DataSnapshot snapshot){
        _key = snapshot.key;
        _datetime = snapshot.value["datetime"];
        _msg= snapshot.value["msg"];
        _timestamp= snapshot.value["timestamp"];
  }
}