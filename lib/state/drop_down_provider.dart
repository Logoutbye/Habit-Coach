import 'package:flutter/material.dart';

class DropdownProvider extends ChangeNotifier {
  String _selectedOption = 'Morning'; // Initialize with a default value

  String get selectedOption => _selectedOption;

  void setOption(String option) {
    _selectedOption = option;
    notifyListeners();
  }
}
