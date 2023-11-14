import 'package:flutter/material.dart';
import 'package:healthy_routine/controllers/routine_controller.dart';
import 'package:healthy_routine/core/app_colors.dart';
import 'package:healthy_routine/core/app_strings.dart';
import 'package:healthy_routine/core/app_styles.dart';
import 'package:healthy_routine/core/components/reuseable_gap_widget.dart';
import 'package:healthy_routine/core/components/reuseable_task_container.dart';
import 'package:healthy_routine/models/routine.dart';

import '../../../core/components/re_use_able_create_button.dart';


class CreateFixedMoriningRoutineScreen extends StatelessWidget {
  const CreateFixedMoriningRoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width / 1.1,
            // height: MediaQuery.of(context).size.height / 5.2,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              shadows: const [
                BoxShadow(
                  color: AppColors.kgrey,
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              children: [
                Image.asset(AppStrings.morningIconPath),
                const ReuseableGapWidget(),
                Text('"Morning Vitality Boost"',
                    textAlign: TextAlign.center,
                    style: AppStyles.headingTextStyleBlack),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Build a morning routine that jumpstarts your day. Tailor activities to your liking for a vibrant start.',
                    style: AppStyles.taskSubtitleTextStyleblackcolor,
                  ),
                )
              ],
            )),
        ReuseableGapWidget(),
        Expanded(
            child: ListView(
          children: [
            const ReUseAbleTaskContainer(
              title: 'Make Bed',
              subTitle: '6:00 AM',
              svgPath: AppStrings.makebedSvgPath,
            ),
            const ReUseAbleTaskContainer(
              title: 'Hydration',
              subTitle: '6:15 AM',
              svgPath: AppStrings.hydrationSvgPath,
            ),
            const ReUseAbleTaskContainer(
              title: 'Physical Activity',
              subTitle: '6:30 AM',
              svgPath: AppStrings.physicalSvgPath,
            ),
            const ReUseAbleTaskContainer(
              title: 'Meditation',
              subTitle: '7:10 AM',
              svgPath: AppStrings.meditationSvgPath,
            ),
            const ReUseAbleTaskContainer(
              title: 'Break Fast Reminder',
              subTitle: '8:15 AM',
              svgPath: AppStrings.remindarSvgPath,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ReUseAbleCreateButton(
                onTap: () async {
                  RoutineController routineController = RoutineController();
                  Routine newRoutine = Routine(
                      routineName: 'Morning Vitality Boost',
                      routineDescription:
                          'Start your day with a personalized routine for a vibrant beginning.',
                      selectedOption: 'Morning',
                      isSwitchOn: true,
                      selectedDays: [
                         "monday",
                        "tuesday",
                        "wednesday",
                        "thursday",
                        "friday",
                        "saturday",
                        "sunday",
                      ],
                      todos: <Todo>[
                        Todo(
                            todoName: 'Make Bed',
                            time: DateTime.parse('2023-11-04 06:00:00')),
                        Todo(
                            todoName: 'Hydration',
                            time: DateTime.parse('2023-11-04 06:15:00')),
                        Todo(
                            todoName: 'Physical Activitiy',
                            time: DateTime.parse('2023-11-04 06:30:00')),
                        Todo(
                            todoName: 'Meditation',
                            time: DateTime.parse('2023-11-04 07:10:00')),
                        Todo(
                            todoName: 'Break Fast',
                            time: DateTime.parse('2023-11-04 08:15:00')),
                      ], routineType: 'fixed');

                  await routineController.saveRoutine(newRoutine, context);
                },
                buttonTextTitle: 'Add All',
              ),
            ),
          ],
        ))
      ],
    );
  }
}



// now i have two more steps to do i have to schedule this notification for time and day i mean there is screen where i am creating flexible routines where i have list of the todo in routine it has time and in routine i am selecting weekdays so here weekdays and list can be dynamic so how many todos are and how many days are selected then there is create button where i am saving them in hive and want you to schedule the notifications and repeate them on the time and day when it comes same is the case with fixed routines but here list of todo and their times are not dynamic and the have to repeat every day i have a code for both of them let me share it 
// class RoutineController {
//   // static const String _boxName = 'routines';

//   Future<void> saveRoutine(Routine routine, BuildContext context) async {
//     var routinesBox = await Hive.openBox<Routine>(AppStrings.routineHiveBox);
//     await routinesBox.add(routine);
//     Provider.of<ScheduleProvider>(context, listen: false).notifyListeners();

//     Navigator.pop(context);
//     // navigatorKey.currentState!.popUntil((route) => route.isFirst);
//     // Navigator.pushReplacement(
//     //     context, SlideTransitionPage(page: const FixedRoutinesDashboard()));
//     Utils.showSuccessFlushbar(
//         'Success', 'You will be notified on time.', context);
//   }}                    RoutineController routineController = RoutineController();
//                   Routine newRoutine = Routine(
//                       routineName: routineNameTextController.text,
//                       routineDescription: routineDescriptionTextController.text,
//                       selectedOption: dropDownProvider.selectedOption,
//                       isSwitchOn: reminderProvider.isSwitchOn,
//                       selectedDays: selectedDaysProvider.selectedDays,
//                       todos: todoProvider.tasks,
//                       routineType: 'flexible');

//                   await routineController.saveRoutine(newRoutine, context);

//                   routineNameTextController.clear();
//                   routineDescriptionTextController.clear();
//                   dropDownProvider.setOption(
//                       'Morning'); // Set it to the initial state or another default value
//                   reminderProvider
//                       .toggleSwitch(); // Set it to the initial state or another default value
//                   selectedDaysProvider.setDays(
//                       []); // Set it to the initial state or another default value
//                   // todoProvider.clearTasks(); // Clear the tasks list
//                 }
//               },
//               buttonTextTitle: 'Create Routine',
//             ),       child: ReUseAbleCreateButton(
//                 onTap: () async {
//                   RoutineController routineController = RoutineController();
//                   Routine newRoutine = Routine(
//                       routineName: 'Morning Vitality Boost',
//                       routineDescription:
//                           'Start your day with a personalized routine for a vibrant beginning.',
//                       selectedOption: 'Morning',
//                       isSwitchOn: true,
//                       selectedDays: [
//                         'sunday',
//                         'monday',
//                         'tuesday',
//                         'wednesday',
//                         'thursday',
//                         'friday',
//                         'saturday'
//                       ],
//                       todos: <Todo>[
//                         Todo(
//                             todoName: 'Make Bed',
//                             time: DateTime.parse('2023-11-04 06:00:00')),
//                         Todo(
//                             todoName: 'Hydration',
//                             time: DateTime.parse('2023-11-04 06:15:00')),
//                         Todo(
//                             todoName: 'Physical Activitiy',
//                             time: DateTime.parse('2023-11-04 06:30:00')),
//                         Todo(
//                             todoName: 'Meditation',
//                             time: DateTime.parse('2023-11-04 07:10:00')),
//                         Todo(
//                             todoName: 'Break Fast',
//                             time: DateTime.parse('2023-11-04 08:15:00')),
//                       ], routineType: 'fixed');

//                   await routineController.saveRoutine(newRoutine, context);
//                 },
//                 buttonTextTitle: 'Add All',
//               ),
      //  now you can also decide if we have to schedule notification after they are saved and in the rouitne controller save routine or may be at the same button where they are being saved in hive although the are dynamic and fixed but they are in the list and and have same patern