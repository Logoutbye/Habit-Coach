import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  // static Future<void> loadAndPrintRoutines() async {
  //   var routinesBox = await Hive.openBox<Routine>(AppStrings.routineHiveBox);
  //   for (var i = 0; i < routinesBox.length; i++) {
  //     Routine routine = routinesBox.getAt(i)!;
  //     print('Routine Name: ${routine.routineName}');
  //     print('Routine Description: ${routine.routineDescription}');
  //     print('Selected Option: ${routine.selectedOption}');
  //     print('Is Switch On: ${routine.isSwitchOn}');
  //     print('Selected Days: ${routine.selectedDays}');
  //     print('Todos:');
  //     for (var todo in routine.todos) {
  //       print('  - ${todo.todoName} at ${todo.time}');
  //     }
  //     print('------------------------');
  //   }
  // }

  List<Routine> loadRoutines() {
    var routinesBox = Hive.box<Routine>(AppStrings.routineHiveBox);
    return routinesBox.values.toList();
  }

  Future<void> saveRoutine(Routine routine, BuildContext context) async {
    var routinesBox = await Hive.openBox<Routine>(AppStrings.routineHiveBox);
    await routinesBox.add(routine);

    Provider.of<ScheduleProvider>(context, listen: false).notifyListeners();
    Navigator.pop(context);
    Utils.showSuccessFlushbar(
      'Success',
      'You will be notified on time.',
      context,
    );
    if (routine.isSwitchOn) {
      await _scheduleNotifications(routine, 15);
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

    if (selectedDayIndex != -1) {
      for (int week = 0; week < numberOfWeeks; week++) {
        int daysDifference =
            (selectedDayIndex - DateTime.now().weekday + 7) % 7 +
                (week * 7); // Adjust for multiple weeks
        if (kDebugMode) {
          print('Scheduling todo "${todo.todoName}" for $selectedDay');
        }
        DateTime nextNotificationTime =
            todo.time.add(Duration(days: daysDifference));

        await LocalNotifications.scheduleLocalNotification(
          id: todo.hashCode +
              selectedDayIndex +
              (week * 7), // Adjust for multiple weeks
          title: 'Habit Reminder',
          body:
              'It\'s time for your ${todo.todoName} in ${routine.routineName}!',
          scheduledDate: tz.TZDateTime.from(nextNotificationTime, tz.local),
          payload: 'custom_payload',
        );
        if (kDebugMode) {
          print(
            'Scheduled for ${nextNotificationTime.toLocal()} - ${todo.todoName}',
          );
        }
      }
    } else {
      print("Unknown day: $selectedDay");
    }
  }

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