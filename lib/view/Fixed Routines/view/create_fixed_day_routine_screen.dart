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
import 'package:timezone/timezone.dart' as tz;

class CreateFixedDayRoutineScreen extends StatelessWidget {
  const CreateFixedDayRoutineScreen({super.key});

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
                          todoName: 'Strech Break',
                          time: getFutureDateTime(10, 0), // 10:00 AM
                        ),
                        Todo(
                          todoName: 'Hydration',
                          time: getFutureDateTime(10, 30), // 10:30 AM
                        ),
                        Todo(
                          todoName: 'Lunch',
                          time: getFutureDateTime(12, 0), // 12:00 PM
                        ),
                        Todo(
                          todoName: 'Short Walk',
                          time: getFutureDateTime(14, 0), // 2:00 PM
                        ),
                        Todo(
                          todoName: 'Healthy Snack',
                          time: getFutureDateTime(15, 30), // 3:30 PM
                        ),
                        Todo(
                          todoName: 'Exercise Session',
                          time: getFutureDateTime(16, 30), // 4:30 PM
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
DateTime getFutureDateTime(int hour, int minute) {
  final now = DateTime.now();
  DateTime scheduledDateTime = DateTime(now.year, now.month, now.day, hour, minute);

  // If the scheduled time has already passed for today, schedule it for the same time tomorrow
  if (scheduledDateTime.isBefore(now)) {
    scheduledDateTime = scheduledDateTime.add(const Duration(days: 1));
  }

  return scheduledDateTime;
}


// tz.TZDateTime getFutureDateTime(int hour, int minute) {
//   final now = tz.TZDateTime.now(tz.local);
//   tz.TZDateTime scheduledDateTime = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

//   // If the scheduled time has already passed for today, schedule it for the same time tomorrow
//   if (scheduledDateTime.isBefore(now)) {
//     scheduledDateTime = scheduledDateTime.add(const Duration(days: 1));
//   }

//   return scheduledDateTime;
// }