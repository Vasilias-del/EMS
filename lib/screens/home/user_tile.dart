import 'package:ems/models/user_detail.dart';
import 'package:flutter/material.dart';


class UserTile extends StatelessWidget {

  final UserDetail userDetail;
  UserTile({ this.userDetail });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.blue[100],
          ),
          title: Text(userDetail.uname),
          subtitle: Text('${userDetail.fname} ${userDetail.lname}'),
        ),
      )
    );
  }
}