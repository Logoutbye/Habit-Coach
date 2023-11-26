import 'package:flutter/material.dart';

class SetScreenIndexForFixedRoutineProvider with ChangeNotifier {
  int _index = 0;
  int get index => _index;

  void SetScreenIndex(value) {
    _index = value;
    notifyListeners();
    print('::: Provider Index at Provider Class ${value}');
  }
}
