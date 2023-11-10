import 'package:flutter/foundation.dart';

class SwitchProvider with ChangeNotifier {
  bool _isSwitchOn = false;

  bool get isSwitchOn => _isSwitchOn;

  void toggleSwitch() {
    _isSwitchOn = !_isSwitchOn;
    notifyListeners();
  }
}
