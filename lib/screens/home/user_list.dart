import 'package:ems/models/user_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ems/screens/home/user_tile.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {

    final users = Provider.of<List<UserDetail>>(context) ?? [];
    // users.forEach((users) {
    //   print(users.uname);
    //   print(users.fname);
    //   print(users.uname);
    //   print(users.email);
    // });

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return UserTile(userDetail: users[index]);
      },
    );
  }
}