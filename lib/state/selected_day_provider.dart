import 'package:flutter/material.dart';

class SelectedDaysProvider with ChangeNotifier {
  List<String> _selectedDays = [];

  List<String> get selectedDays => _selectedDays;

  void setDays(List<String> days) {
    _selectedDays = days;
    notifyListeners();
  }
}
