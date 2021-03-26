import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class UserInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Scaffold(
      appBar: AppBar(
        title: Text('名前'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: users.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return new ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return new ListTile(
                title: new Text(document.data()['full_name']),
                subtitle: new Text(document.data()['company']),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
