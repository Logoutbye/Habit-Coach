import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthy_routine/controllers/get_schedule_provider.dart';
import 'package:healthy_routine/core/app_strings.dart';
import 'package:healthy_routine/core/utils.dart';
import 'package:healthy_routine/models/routine.dart';
import 'package:healthy_routine/services/local_notification.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class RoutineController with ChangeNotifier {
  Future<void> deleteRoutine(int index, BuildContext context) async {
    try {
      var routinesBox = await Hive.openBox<Routine>(AppStrings.routineHiveBox);
      Routine deletedRoutine = routinesBox.getAt(index)!;

      // Cancel notifications for the deleted routine
      await cancelNotificationsForRoutine(deletedRoutine);

      // Delete the routine from the Hive box
      await routinesBox.deleteAt(index);

      // Notify listeners and show success message
      Provider.of<ScheduleProvider>(context, listen: false).notifyListeners();
      Utils.showSuccessFlushbar(
        'Success',
        'Routine deleted successfully.',
        context,
      );
    } catch (e) {
      print('Error deleting routine: $e');
      Utils.showErrorFlushbar(
        'Error',
        'Failed to delete routine. Please try again.',
        context,
      );
    }
  }

// Function to cancel notifications for a routine
  Future<void> cancelNotificationsForRoutine(Routine routine) async {
    if (routine.notificationIds != null) {
      for (int notificationId in routine.notificationIds!) {
        await LocalNotifications.cancel(notificationId);
        if (kDebugMode) {
          print(
              '::::: canceled notification for this notificationId : ${notificationId}');
        }
      }
    }
  }

  // this helps to get and print the saved routines
  static Future<void> loadAndPrintRoutines() async {
    var routinesBox = await Hive.openBox<Routine>(AppStrings.routineHiveBox);
    for (var i = 0; i < routinesBox.length; i++) {
      Routine routine = routinesBox.getAt(i)!;
      if (kDebugMode) {
        print('Routine Name: ${routine.routineName}');
        print('Routine Description: ${routine.routineDescription}');
        print('Selected Option: ${routine.selectedOption}');
        print('Is Switch On: ${routine.isSwitchOn}');
        print('Selected Days: ${routine.selectedDays}');
        print('Notification IDs: ${routine.notificationIds}');
        print('Todos:');
        for (var todo in routine.todos) {
          print('  - ${todo.todoName} at ${todo.time}');
        }
        print('------------------------');
      }
    }
  }

  // this helps in loading all the routines and show them on screen
  List<Routine> loadRoutines() {
    var routinesBox = Hive.box<Routine>(AppStrings.routineHiveBox);
    return routinesBox.values.toList();
  }

  // this save routine and schedule notification for all the todos for two weeks
  // and can handle more weeks but android system limits scheduling alarms to 500
  Future<void> saveRoutine(Routine routine, BuildContext context) async {
    try {
      var routinesBox = await Hive.openBox<Routine>(AppStrings.routineHiveBox);

      // Check if a routine with the same data already exists
      bool routineExists = routinesBox.values.any((existingRoutine) {
        return existingRoutine.routineName == routine.routineName ;
        // &&
            // existingRoutine.selectedOption == routine.selectedOption &&
            // existingRoutine.isSwitchOn == routine.isSwitchOn &&
            // existingRoutine.selectedDays == routine.selectedDays &&
            // existingRoutine.todos == routine.todos;
      });
        if (kDebugMode) print('Routine with the same data already exists. value $routineExists');

      if (routineExists) {
        if (kDebugMode) print('Routine with the same data already exists.');
        Utils.showErrorFlushbar(
          'Info',
          'Routine with the same data already exists.',
          context,
        );
        return; // Exit the method without saving if routine already exists
      }
      await routinesBox.add(routine);

      Provider.of<ScheduleProvider>(context, listen: false).notifyListeners();
      Navigator.pop(context);
      Utils.showSuccessFlushbar(
        'Success',
        'You will be notified on time.',
        context,
      );
      if (routine.isSwitchOn) {
        await _scheduleNotifications(
            routine, 2); //schedule each todo for $2 weeks
      }
    } catch (e) {
      if (kDebugMode) print('Error::: $e');

      // Check if the exception is related to maximum alarms limit
      if (e is PlatformException &&
          e.message?.contains('Maximum limit of concurrent alarms') == true) {
        Utils.showErrorFlushbar(
          'Error',
          'Failed to schedule routine. Maximum alarms limit reached. First delete unnecessary routines.',
          context,
        );
      } else {
        // Handle other exceptions here
        Utils.showErrorFlushbar(
          'Error',
          'Failed to schedule routine. Please try again.',
          context,
        );
      }
    }
  }

  Future<void> _scheduleNotifications(
      Routine routine, int numberOfWeeks) async {
    tz.initializeTimeZones();

    for (var todo in routine.todos) {
      for (var selectedDay in routine.selectedDays) {
        await _scheduleNotificationsForDay(
            routine, todo, selectedDay, numberOfWeeks);
      }
    }
  }

  Future<void> _scheduleNotificationsForDay(
    Routine routine,
    Todo todo,
    String selectedDay,
    int numberOfWeeks,
  ) async {
    tz.initializeTimeZones();

    int selectedDayIndex = _mapDayToIndex(selectedDay);
    late int notificationId;
    if (selectedDayIndex != -1) {
      for (int week = 0; week < numberOfWeeks; week++) {
        int daysDifference =
            (selectedDayIndex - DateTime.now().weekday + 7) % 7 +
                (week * 7); // Adjust for multiple weeks

        notificationId =
            todo.hashCode + selectedDayIndex + (week * 7); // Unique identifier

        DateTime nextNotificationTime =
            todo.time.add(Duration(days: daysDifference));

        await LocalNotifications.scheduleLocalNotification(
          id: notificationId,
          title: 'Habit Reminder',
          body:
              'It\'s time for your ${todo.todoName} in ${routine.routineName}!',
          scheduledDate: tz.TZDateTime.from(nextNotificationTime, tz.local),
          payload: 'custom_payload',
        );
        // Save the notificationId to the routine
        routine.notificationIds!.add(notificationId);
        if (kDebugMode) {
          print(
            '::::: Scheduled for ${nextNotificationTime.toLocal()} - ${todo.todoName}  for $selectedDay with notification id ${notificationId}',
          );
        }
        // Save the routine back to Hive with the updated notificationIds
        await _saveRoutineWithNotifications(routine);
      }
    } else {
      print("Unknown day: $selectedDay");
    }
  }

  Future<void> _saveRoutineWithNotifications(Routine routine) async {
    // Save the routine to Hive with updated notification IDs
    var routinesBox = await Hive.openBox<Routine>(AppStrings.routineHiveBox);

    // Find the index of the existing routine
    int index = routinesBox.values
        .toList()
        .indexWhere((r) => r.routineName == routine.routineName);

    if (index != -1) {
      // Update the existing routine
      await routinesBox.putAt(index, routine);
    } else {
      // Add the routine if it doesn't exist
      await routinesBox.add(routine);
    }
  }

  // this function helps to compare the day of the week from db to day of the
  // acutal week and scheddule the notification accordingly
  int _mapDayToIndex(String day) {
    switch (day.toLowerCase()) {
      case "monday":
        return 1;
      case "tuesday":
        return 2;
      case "wednesday":
        return 3;
      case "thursday":
        return 4;
      case "friday":
        return 5;
      case "saturday":
        return 6;
      case "sunday":
        return 7;
      default:
        return -1; // Unknown day
    }
  }
}












// import 'package:flutter/material.dart';
// import 'package:healthy_routine/controllers/get_schedule_provider.dart';
// import 'package:healthy_routine/core/app_strings.dart';
// import 'package:healthy_routine/core/utils.dart';
// import 'package:healthy_routine/models/routine.dart';
// import 'package:healthy_routine/services/local_notification.dart';
// import 'package:hive/hive.dart';
// import 'package:provider/provider.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
//
// class RoutineController {
//   static Future<void> loadAndPrintRoutines() async {
//     var routinesBox = await Hive.openBox<Routine>(AppStrings.routineHiveBox);
//     for (var i = 0; i < routinesBox.length; i++) {
//       Routine routine =
//           routinesBox.getAt(i)!; // Use '!' to assert non-nullability
//       print('Routine Name: ${routine.routineName}');
//       print('Routine Description: ${routine.routineDescription}');
//       print('Selected Option: ${routine.selectedOption}');
//       print('Is Switch On: ${routine.isSwitchOn}');
//       print('Selected Days: ${routine.selectedDays}');
//       print('Todos:');
//       for (var todo in routine.todos) {
//         print('  - ${todo.todoName} at ${todo.time}');
//       }
//
//       print('------------------------');
//     }
//   }
//
//   List<Routine> loadRoutines() {
//     var routinesBox = Hive.box<Routine>(AppStrings.routineHiveBox);
//     return routinesBox.values.toList();
//   }
//
//   Future<void> saveRoutine(Routine routine, BuildContext context) async {
//     var routinesBox = await Hive.openBox<Routine>(AppStrings.routineHiveBox);
//     await routinesBox.add(routine);
//
//     if (routine.isSwitchOn) {
//       await _scheduleNotifications(routine);
//     }
//
//     Provider.of<ScheduleProvider>(context, listen: false).notifyListeners();
//     Navigator.pop(context);
//     Utils.showSuccessFlushbar(
//         'Success', 'You will be notified on time.', context);
//   }
//
//   Future<void> _scheduleNotifications(Routine routine) async {
//     tz.initializeTimeZones();
//
//     for (var todo in routine.todos) {
//       // Schedule notification for each todo
//       await LocalNotifications.scheduleLocalNotification(
//         id: todo.hashCode, // Use the 'hashCode' of Todo as the ID
//         title: 'Habit Reminder',
//         body: 'It\'s time for your ${todo.todoName} in ${routine.routineName}!',
//         scheduledDate: tz.TZDateTime.from(todo.time, tz.local),
//         payload: 'custom_payload', // Replace with your custom payload
//       );
//     }
//   }
// }
///code above works with the notifcation for each todo
///////////////////////////////////////////////////////////////////////

// import 'package:flutter/material.dart';
// import 'package:healthy_routine/controllers/get_schedule_provider.dart';
// import 'package:healthy_routine/core/app_strings.dart';
// import 'package:healthy_routine/core/utils.dart';
// import 'package:healthy_routine/models/routine.dart';
// import 'package:healthy_routine/services/local_notification.dart';
// import 'package:hive/hive.dart';
// import 'package:provider/provider.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
//
// class RoutineController {
//   static Future<void> loadAndPrintRoutines() async {
//     var routinesBox = await Hive.openBox<Routine>(AppStrings.routineHiveBox);
//     for (var i = 0; i < routinesBox.length; i++) {
//       Routine routine =
//           routinesBox.getAt(i)!; // Use '!' to assert non-nullability
//       print('Routine Name: ${routine.routineName}');
//       print('Routine Description: ${routine.routineDescription}');
//       print('Selected Option: ${routine.selectedOption}');
//       print('Is Switch On: ${routine.isSwitchOn}');
//       print('Selected Days: ${routine.selectedDays}');
//       print('Todos:');
//       for (var todo in routine.todos) {
//         print('  - ${todo.todoName} at ${todo.time}');
//       }
//
//       print('------------------------');
//     }
//   }
//
//   List<Routine> loadRoutines() {
//     var routinesBox = Hive.box<Routine>(AppStrings.routineHiveBox);
//     return routinesBox.values.toList();
//   }
//
//   Future<void> saveRoutine(Routine routine, BuildContext context) async {
//     var routinesBox = await Hive.openBox<Routine>(AppStrings.routineHiveBox);
//     await routinesBox.add(routine);
//
//     if (routine.isSwitchOn) {
//       await _scheduleNotifications(routine);
//     }
//
//     Provider.of<ScheduleProvider>(context, listen: false).notifyListeners();
//     Navigator.pop(context);
//     Utils.showSuccessFlushbar(
//         'Success', 'You will be notified on time.', context);
//   }
//
//   Future<void> _scheduleNotifications(Routine routine) async {
//     tz.initializeTimeZones();
//
//     for (var todo in routine.todos) {
//       for (var selectedDay in routine.selectedDays) {
//         await _scheduleNotificationForDay(routine, todo, selectedDay);
//       }
//     }
//   }
//
//   Future<void> _scheduleNotificationForDay(
//     Routine routine,
//     Todo todo,
//     String selectedDay,
//   ) async {
//     tz.initializeTimeZones();
//
//     // Map the selectedDay string to its numeric representation
//     int selectedDayIndex = _mapDayToIndex(selectedDay);
//
//     if (selectedDayIndex != -1) {
//       // Calculate the difference in days from today to the selected day
//       int daysDifference = (selectedDayIndex - DateTime.now().weekday + 7) % 7;
//       print('Scheduling todo "${todo.todoName}" for $selectedDay');
//
//       // Calculate the next occurrence of the notification
//       DateTime nextNotificationTime =
//           todo.time.add(Duration(days: daysDifference));
//
//       // Schedule notification using LocalNotifications class
//       await LocalNotifications.scheduleLocalNotification(
//         id: todo.hashCode +
//             selectedDayIndex, // Use the 'hashCode' of Todo with an offset for each day
//         title: 'Habit Reminder',
//         body: 'It\'s time for your ${todo.todoName} in ${routine.routineName}!',
//         scheduledDate: tz.TZDateTime.from(nextNotificationTime, tz.local),
//         payload: 'custom_payload', // Replace with your custom payload
//       );
//       print('Scheduled for ${nextNotificationTime.toLocal()}');
//     } else {
//       print("Unknown day: $selectedDay");
//     }
//   }
//
//   int _mapDayToIndex(String day) {
//     switch (day.toLowerCase()) {
//       case "monday":
//         return 1;
//       case "tuesday":
//         return 2;
//       case "wednesday":
//         return 3;
//       case "thursday":
//         return 4;
//       case "friday":
//         return 5;
//       case "saturday":
//         return 6;
//       case "sunday":
//         return 7;
//       default:
//         return -1; // Unknown day
//     }
//   }
// }
//
//  this code works fine with notifcation and sechdule each todo for one week all the day
// here is its response
// I/flutter (  552): Scheduling todo "todo" for monday
// I/flutter (  552): Scheduled for 2023-11-20 23:33:00.000
// I/flutter (  552): Scheduling todo "todo" for tuesday
// I/flutter (  552): Scheduled for 2023-11-14 23:33:00.000
// I/flutter (  552): Scheduling todo "todo" for wednesday
// I/flutter (  552): Scheduled for 2023-11-15 23:33:00.000
// I/flutter (  552): Scheduling todo "todo" for thursday
// I/flutter (  552): Scheduled for 2023-11-16 23:33:00.000
// I/flutter (  552): Scheduling todo "todo" for friday
// I/flutter (  552): Scheduled for 2023-11-17 23:33:00.000
// I/flutter (  552): Scheduling todo "todo" for sunday
// I/flutter (  552): Scheduled for 2023-11-19 23:33:00.000
// I/flutter (  552): Scheduling todo "todo 2 " for monday
// I/flutter (  552): Scheduled for 2023-11-20 23:35:00.000
// I/flutter (  552): Scheduling todo "todo 2 " for tuesday
// I/flutter (  552): Scheduled for 2023-11-14 23:35:00.000
// I/flutter (  552): Scheduling todo "todo 2 " for wednesday
// I/flutter (  552): Scheduled for 2023-11-15 23:35:00.000
// I/flutter (  552): Scheduling todo "todo 2 " for thursday
// I/flutter (  552): Scheduled for 2023-11-16 23:35:00.000
// I/flutter (  552): Scheduling todo "todo 2 " for friday
// I/flutter (  552): Scheduled for 2023-11-17 23:35:00.000
// I/flutter (  552): Scheduling todo "todo 2 " for sunday
// I/flutter (  552): Scheduled for 2023-11-19 23:35:00.000
//////////////////////////////////////////////////////////////////////////////////////////////////
