import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/prezentation/users/user.dart';

class AddUserModel extends ChangeNotifier {
  String userTitle;

  Future addUserToFirebase() async {
    if (userTitle.isEmpty) {
      throw ('タイトルを入力してください');
    }

    FirebaseFirestore.instance.collection('users').add({
      'title': userTitle,
      'createdAt': Timestamp.now(),
    });
  }

  Future updateUser(User user) async {
    final document =
        FirebaseFirestore.instance.collection('users').doc(user.documentID);
    await document.update(
      {
        'title': userTitle,
        'updateID': Timestamp.now(),
      },
    );
  }
}
