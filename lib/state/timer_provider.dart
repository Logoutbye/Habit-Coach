import 'package:flutter/material.dart';

class TimeProvider with ChangeNotifier {
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _formattedTime = '';

  TimeOfDay get selectedTime => _selectedTime;
  String get formattedTime => _formattedTime;

  void pickTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      _selectedTime = pickedTime;
      _formattedTime = _formatTime(_selectedTime);
      notifyListeners();
    }
  }

 static String _formatTime(TimeOfDay time) {
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;

    return '$hour:${time.minute.toString().padLeft(2, '0')} $period';
  }
}
