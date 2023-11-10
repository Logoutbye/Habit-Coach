import 'package:flutter/material.dart';
import 'package:healthy_routine/models/routine.dart';

import 'routine_controller.dart';

class ScheduleProvider with ChangeNotifier {
  List<Map<String, dynamic>> schedules = [];

  Future<void> fetchSchedulesFromHive(
      String filterTimeOfDay, String routineType) async {
    // Fetch routines from Hive using RoutineController
    RoutineController routineController = RoutineController();
    List<Routine> routines = routineController.loadRoutines();

    // Convert Routine objects to the format expected by your UI
    schedules = routines
        .where((routine) =>
                routine.selectedOption ==
                    filterTimeOfDay // Filter by time of the day
                &&
                routine.routineType == routineType // Filter by routine type
            )
        .map((routine) {
      return {
        'taskName': routine.routineName,
        'description': routine.routineDescription,
        'alerts': routine.isSwitchOn,
        'weekDays': routine.selectedDays
            .join(), // Assuming selectedDays is a list of strings
        'todos': routine.todos.map((todo) {
          return {'todoName': todo.todoName, 'time': _formatTime(todo.time)};
        }).toList(),
      };
    }).toList();
  }

  String _formatTime(DateTime dateTime) {
    String period = dateTime.hour < 12 ? 'AM' : 'PM';
    int hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    String minute = '${dateTime.minute}'.padLeft(2, '0');
    return '$hour:$minute $period';
  }

  /////////////////////////////////////////
  // fetch for today rouitnes
  Future<void> fetchSchedulesForToday() async {
    // Fetch routines from Hive using RoutineController
    RoutineController routineController = RoutineController();
    List<Routine> routines = routineController.loadRoutines();

// Inside your fetchSchedulesFromHive method
    String currentDay = getCurrentDay();
    // Convert Routine objects to the format expected by your UI
    schedules = routines
        .where((routine) => routine.selectedDays.contains(currentDay))
        .map((routine) {
      return {
        'taskName': routine.routineName,
        'description': routine.routineDescription,
        'alerts': routine.isSwitchOn,
        'weekDays': routine.selectedDays.join(),
        'routineType': routine.routineType,
        'todos': routine.todos.map((todo) {
          return {'todoName': todo.todoName, 'time': _formatTime(todo.time)};
        }).toList(),
      };
    }).toList();

    // notifyListeners();
  }

  // Function to get the current day
  String getCurrentDay() {
    int currentDayIndex = DateTime.now().weekday;
    List<String> daysOfWeek = [
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'friday',
      'saturday',
      'sunday'
    ];
    return daysOfWeek[currentDayIndex - 1];
  }
}
