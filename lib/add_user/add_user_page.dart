import 'package:flutter/material.dart';
import 'package:practice_app/add_user/add_user_model.dart';
import 'package:practice_app/prezentation/users/user.dart';
import 'package:provider/provider.dart';

class AddUserPage extends StatelessWidget {
  AddUserPage({this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final bool isUpdate = user != null;
    final textEditingController = TextEditingController();
    if (isUpdate) {
      textEditingController.text = user.title;
    }
    return ChangeNotifierProvider<AddUserModel>(
      create: (_) => AddUserModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(isUpdate ? '名前を編集' : '本を追加'),
        ),
        body: Consumer<AddUserModel>(
          builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: textEditingController,
                    onChanged: (text) {
                      model.userTitle = text;
                    },
                  ),
                  ElevatedButton(
                    child: Text(isUpdate ? '更新する' : '追加する'),
                    onPressed: () async {
                      if (isUpdate) {
                        await updateUser(model, context);
                      } else {
                        await addUser(model, context);
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future addUser(AddUserModel model, BuildContext context) async {
    try {
      await model.addUserToFirebase();

      await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('保存しました'),
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
      Navigator.of(context).pop();
    } catch (e) {
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

  Future updateUser(AddUserModel model, BuildContext context) async {
    try {
      await model.updateUser(user);

      await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('更新しました'),
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
      Navigator.of(context).pop();
    } catch (e) {
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
}
