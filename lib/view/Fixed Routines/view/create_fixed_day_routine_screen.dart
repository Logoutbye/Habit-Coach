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


class CreateFixedDayRoutineScreen extends StatelessWidget {
  const CreateFixedDayRoutineScreen({super.key});

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
                SvgPicture.asset(
                  AppStrings.daySvgPath,
                ),
                const ReuseableGapWidget(),
                Text('"Stay Active Throughout the Day"',
                    textAlign: TextAlign.center,
                    style: AppStyles.headingTextStyleBlack),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Personalize your midday routine to refresh and recharge. Add activities that suit your energy needs.',
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
              title: 'Strech Break',
              subTitle: '10:00 AM',
              svgPath: AppStrings.strechSvgPath,
            ),
            const ReUseAbleTaskContainer(
              title: 'Hydration',
              subTitle: '10:30 AM',
              svgPath: AppStrings.hydrationSvgPath,
            ),
            const ReUseAbleTaskContainer(
              title: 'Lunch',
              subTitle: '12:00 AM',
              svgPath: AppStrings.lunchSvgPath,
            ),
            const ReUseAbleTaskContainer(
              title: 'Short Walk',
              subTitle: '2:00 PM',
              svgPath: AppStrings.shortwalkSvgPath,
            ),
            const ReUseAbleTaskContainer(
              title: 'Healthy Snack',
              subTitle: '3:30 PM',
              svgPath: AppStrings.remindarSvgPath,
            ),
            const ReUseAbleTaskContainer(
              title: 'Exercise Session',
              subTitle: '4:30 PM',
              svgPath: AppStrings.exerciseSvgPath,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ReUseAbleCreateButton(
                onTap: () async {
                  RoutineController routineController = RoutineController();
                  Routine newRoutine = Routine(
                      routineName: 'Stay Active Throughout the Day',
                      routineDescription:
                          'Take a break from your busy day and refresh with our midday routine.',
                      selectedOption: 'Midday',
                      isSwitchOn: true,
                      selectedDays: [
                        'sunday',
                        'monday',
                        'tuesday',
                        'wednesday',
                        'thursday',
                        'friday',
                        'saturday'
                      ],
                      todos: <Todo>[
                        Todo(
                            todoName: 'Strech Break',
                            time: DateTime.parse('2023-11-04 10:00:00')),
                        Todo(
                            todoName: 'Hydration',
                            time: DateTime.parse('2023-11-04 10:30:00')),
                        Todo(
                            todoName: 'Lunch',
                            time: DateTime.parse('2023-11-04 12:00:00')),
                        Todo(
                            todoName: 'Short Walk',
                            time: DateTime.parse('2023-11-04 14:00:00')),
                        Todo(
                            todoName: 'Healthy Snack',
                            time: DateTime.parse('2023-11-04 15:30:00')),
                        Todo(
                            todoName: 'Exercise Session',
                            time: DateTime.parse('2023-11-04 16:30:00')),
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
