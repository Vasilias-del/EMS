import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ems/models/elder.dart';
import 'package:ems/models/user.dart';
import 'package:ems/models/user_detail.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });


  // colection reference
  final CollectionReference userCollection = Firestore.instance.collection('users'); 
  final CollectionReference elderCollection = Firestore.instance.collection('eslder');
  final CollectionReference sensorsCollection = Firestore.instance.collection('sensors');
  
  // update user data when register
  Future updateUserData(String fname, String lname, String uname, String email, String password) async {
    return await userCollection.document(uid).setData({
      'username': uname,
      'firstname': fname,
      'lastname': lname,
      'email': email,
      'password': password,
    });
  }

  // update elder data when register
  Future updateElderData(String fname, String lname, int age, double height, double weight) async {
    return await elderCollection.document(uid).setData({
      'firstname': fname,
      'lastname': lname,
      'age': age,
      'height': height,
      'weight': weight
    });
  }

  // multi user list from snapshot
  List<UserDetail> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return UserDetail(
        uname: doc.data['username'] ?? '',
        fname: doc.data['firstname'] ?? '',
        lname: doc.data['lastname'] ?? '',
        email: doc.data['email'] ?? '',
        password: doc.data['password'] ?? ''
      );
    }).toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid:uid,
      uname: snapshot.data['username'],
      fname: snapshot.data['firstname'],
      lname: snapshot.data['lastname'],
      email: snapshot.data['email'],
      password: snapshot.data['password']
    );
  }

  ElderData _elderDataFromSnapshot(DocumentSnapshot snapshot) {
    return ElderData(
      uid:uid,
      fname: snapshot.data['firstname'],
      lname: snapshot.data['lastname'],
      age: snapshot.data['age'],
      height: snapshot.data['height'],
      weight: snapshot.data['weight']
    );
  }

  Stream<List<UserDetail>> get users {
    return userCollection.snapshots()
    .map(_userListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }

  // get user doc stream
  Stream<ElderData> get elderData {
    return elderCollection.document(uid).snapshots()
    .map(_elderDataFromSnapshot);
  }

  // single user list fromsnapshot
  // List<Users> _userListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.documents.map((doc) {
  //     return Users(
  //       uname: doc.data['username'] ?? '',
  //       fname: doc.data['firstname'] ?? '',
  //       lname: doc.data['lastname'] ?? '',
  //       email: doc.data['email'] ?? '',
  //       password: doc.data['password'] ?? ''
  //     );
  //   });
  // }

  // get users stream
  // Stream<QuerySnapshot> get users {
  //   return userCollection.snapshots()
  // }

}