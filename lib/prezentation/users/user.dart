import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  User(DocumentSnapshot doc) {
    documentID = doc.id;
    title = doc['title'];
  }
  String documentID;
  String title;
}
