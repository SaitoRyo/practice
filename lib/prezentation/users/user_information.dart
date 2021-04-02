import 'package:flutter/material.dart';
import 'package:practice_app/add_user/add_user_page.dart';
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
}
