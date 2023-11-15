import 'package:flutter/material.dart';
import 'package:healthy_routine/controllers/routine_controller.dart';
import 'package:healthy_routine/core/app_colors.dart';
import 'package:healthy_routine/core/app_strings.dart';
import 'package:healthy_routine/core/app_styles.dart';
import 'package:healthy_routine/core/components/reuseable_gap_widget.dart';
import 'package:healthy_routine/core/components/reuseable_task_container.dart';
import 'package:healthy_routine/models/routine.dart';
import 'package:healthy_routine/view/Fixed%20Routines/view/create_fixed_day_routine_screen.dart';

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
                          time: getFutureDateTime(6, 0),
                        ),
                        Todo(
                          todoName: 'Hydration',
                          time: getFutureDateTime(6, 15),
                        ),
                        Todo(
                          todoName: 'Physical Activitiy',
                          time: getFutureDateTime(6, 30),
                        ),
                        Todo(
                          todoName: 'Meditation',
                          time: getFutureDateTime(7, 10),
                        ),
                        Todo(
                          todoName: 'Break Fast',
                          time: getFutureDateTime(8, 15),
                        ),
                      ],
                      routineType: 'fixed');

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

