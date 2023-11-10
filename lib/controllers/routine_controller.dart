import 'package:flutter/material.dart';
import 'package:healthy_routine/controllers/get_schedule_provider.dart';
import 'package:healthy_routine/core/app_strings.dart';
import 'package:healthy_routine/core/utils.dart';
import 'package:healthy_routine/models/routine.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class RoutineController {
  // static const String _boxName = 'routines';

  Future<void> saveRoutine(Routine routine, BuildContext context) async {
    var routinesBox = await Hive.openBox<Routine>(AppStrings.routineHiveBox);
    await routinesBox.add(routine);
    Provider.of<ScheduleProvider>(context, listen: false).notifyListeners();

    Navigator.pop(context);
    // navigatorKey.currentState!.popUntil((route) => route.isFirst);
    // Navigator.pushReplacement(
    //     context, SlideTransitionPage(page: const FixedRoutinesDashboard()));
    Utils.showSuccessFlushbar(
        'Success', 'You will be notified on time.', context);
  }

  // Future<void> loadAndPrintRoutines() async {
  //   var routinesBox = await Hive.openBox<Routine>(AppStrings.routineHiveBox);
  //   for (var i = 0; i < routinesBox.length; i++) {
  //     Routine routine =
  //         routinesBox.getAt(i)!; // Use '!' to assert non-nullability
  //     print('Routine Name: ${routine.routineName}');
  //     print('Routine Description: ${routine.routineDescription}');
  //     print('Selected Option: ${routine.selectedOption}');
  //     print('Is Switch On: ${routine.isSwitchOn}');
  //     print('Selected Days: ${routine.selectedDays}');
  //     print('Todos: ${routine.todos[0].time}');
  //     print('------------------------');
  //   }
  // }

  List<Routine> loadRoutines() {
    var routinesBox = Hive.box<Routine>(AppStrings.routineHiveBox);
    return routinesBox.values.toList();
  }
}
