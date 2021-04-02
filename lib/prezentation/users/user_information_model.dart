import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/prezentation/users/user.dart';

class UserInformationModel extends ChangeNotifier {
  List<User> users = [];

  Future fetchUsers() async {
    final snapshot = await FirebaseFirestore.instance.collection('users').get();
    final users = snapshot.docs.map((doc) => User(doc)).toList();
    this.users = users;
    notifyListeners();
  }
}
