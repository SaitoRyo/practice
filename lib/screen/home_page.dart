import 'package:flutter/material.dart';
import 'package:practice_app/prezentation/users/user_information.dart';
import 'package:practice_app/screen/home_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ScreenModel>(
      create: (context) => ScreenModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'ホーム画面',
          ),
        ),
        body: Consumer<ScreenModel>(builder: (context, model, child) {
          return Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Text(
                    model.name + 'こんにちは',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                ElevatedButton(
                  child: Text(
                    'ボタン',
                    style: TextStyle(fontSize: 15.0),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserInformation()),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
