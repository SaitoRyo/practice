import 'package:flutter/material.dart';
import 'package:practice_app/user_information_model.dart';
import 'package:provider/provider.dart';

class UserInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserInformationModel>(
      create: (_) => UserInformationModel()..fetchUsers(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('名前'),
        ),
        body: Consumer<UserInformationModel>(
          builder: (context, model, child) {
            final users = model.users;
            final listTiles = users
                .map(
                  (user) => ListTile(
                    title: Text(user.title),
                  ),
                )
                .toList();
            return ListView(
              children: listTiles,
            );
          },
        ),
      ),
    );
  }
}
