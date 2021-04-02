import 'package:flutter/material.dart';

class ScreenModel extends ChangeNotifier {
  String name = 'りょうさん';

  void changName() {
    name = 'たいせいさん';
    notifyListeners();
  }
}
