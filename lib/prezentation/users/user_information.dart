import 'dart:math';

import 'package:flutter/material.dart';
import 'package:practice_app/add_user/add_user_page.dart';
import 'package:practice_app/prezentation/users/user.dart';
import 'package:practice_app/prezentation/users/user_information_model.dart';
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
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddUserPage(
                              user: user,
                            ),
                            fullscreenDialog: true,
                          ),
                        );
                        model.fetchUsers();
                      },
                    ),
                    onLongPress: () async {
                      await showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('${user.title}を削除しました'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  await deleteUser(context, model, user);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                )
                .toList();
            return ListView(
              children: listTiles,
            );
          },
        ),
        floatingActionButton: Consumer<UserInformationModel>(
          builder: (context, model, child) {
            return FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddUserPage(),
                    fullscreenDialog: true,
                  ),
                );
                model.fetchUsers();
              },
            );
          },
        ),
      ),
    );
  }

  Future deleteUser(
      BuildContext context, UserInformationModel model, User user) async {
    try {
      await model.deleteUser(user);
      await model.fetchUsers();
    } catch (e) {
      await _showDialog(context, e.toString());
    }
  }

  Future _showDialog(BuildContext context, String title) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(e.toString()),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
