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

class CreateFixedMidDayRoutineScreen extends StatelessWidget {
  const CreateFixedMidDayRoutineScreen({super.key, this.isAppBarNeeded = false});
  final bool isAppBarNeeded;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isAppBarNeeded
          ? AppBar(
              automaticallyImplyLeading: false,
              title: Text('Midday'),
              centerTitle: true,
              backgroundColor: AppColors.kprimaryColor,
              foregroundColor: AppColors.kwhite,
            )
          : PreferredSize(preferredSize: Size.zero, child: AppBar()),
      body: Column(
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
                    AppStrings.midday_logoPath,
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
                title: 'Hydration (Drink more water)',
                subTitle: '11:00 AM',
                svgPath: AppStrings.hydrationSvgPath,
              ),
              const ReUseAbleTaskContainer(
                title: 'Healthy Snacks (Eat healthy snacks)',
                subTitle: '11:15 AM',
                svgPath: AppStrings.lunchSvgPath,
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
                            todoName: 'Hydration (Drink more water)',
                            time: getFutureDateTime(11, 0), // 10:00 AM
                          ),
                          Todo(
                            todoName: 'Healthy Snacks (Eat healthy snacks)',
                            time: getFutureDateTime(11, 15), // 10:30 AM
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
      ),
    );
  }
}

DateTime getFutureDateTime(int hour, int minute) {
  final now = DateTime.now();
  DateTime scheduledDateTime =
      DateTime(now.year, now.month, now.day, hour, minute);

  // If the scheduled time has already passed for today, schedule it for the same time tomorrow
  if (scheduledDateTime.isBefore(now)) {
    scheduledDateTime = scheduledDateTime.add(const Duration(days: 1));
  }

  return scheduledDateTime;
}
