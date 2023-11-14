import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_routine/controllers/routine_controller.dart';
import 'package:healthy_routine/core/app_colors.dart';
import 'package:healthy_routine/core/app_strings.dart';
import 'package:healthy_routine/core/app_styles.dart';
import 'package:healthy_routine/core/components/re_use_able_create_button.dart';
import 'package:healthy_routine/core/components/reuseable_gap_widget.dart';
import 'package:healthy_routine/core/components/reuseable_task_container.dart';
import 'package:healthy_routine/models/routine.dart';

class CreateFixedEveningRoutineScreen extends StatelessWidget {
  const CreateFixedEveningRoutineScreen({super.key});

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
                // Image.asset(AppStrings.morningIconPath),
                SvgPicture.asset(AppStrings.eveningSvgPath),
                const ReuseableGapWidget(),
                Text('"Evening Relaxation and Unwind"',
                    textAlign: TextAlign.center,
                    style: AppStyles.headingTextStyleBlack),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Build a personalized evening routine to unwind and relax. Add activities that bring calmness and tranquility.',
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
              title: 'Dinner',
              subTitle: '7:00 PM',
              svgPath: AppStrings.lunchSvgPath,
            ),
            const ReUseAbleTaskContainer(
              title: 'Hydration',
              subTitle: '7:45 PM',
              svgPath: AppStrings.hydrationSvgPath,
            ),
            const ReUseAbleTaskContainer(
              title: 'Mindfulness Activity',
              subTitle: '8:00 PM',
              svgPath: AppStrings.mindfulSvgPath,
            ),
            const ReUseAbleTaskContainer(
              title: 'Reading Time',
              subTitle: '8:30 PM',
              svgPath: AppStrings.readingSvgPath,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ReUseAbleCreateButton(
                onTap: () async {
                  RoutineController routineController = RoutineController();
                  Routine newRoutine = Routine(
                      routineName: 'Evening Relaxtion and Unwind',
                      routineDescription:
                          'Enjoy a personalized afternoon routine that contributes to your rejuvenation and focus.',
                      selectedOption: 'Evening',
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
                            todoName: 'Dinner',
                            time: DateTime.parse('2023-11-04 19:00:00')),
                        Todo(
                            todoName: 'Hydration',
                            time: DateTime.parse('2023-11-04 19:45:00')),
                        Todo(
                            todoName: 'Mindfulness Activity',
                            time: DateTime.parse('2023-11-04 20:00:00')),
                        Todo(
                            todoName: 'Reading Time',
                            time: DateTime.parse('2023-11-04 20:30:00')),
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
