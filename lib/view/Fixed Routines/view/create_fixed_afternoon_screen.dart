import 'package:flutter/material.dart';
import 'package:healthy_routine/controllers/routine_controller.dart';
import 'package:healthy_routine/core/app_colors.dart';
import 'package:healthy_routine/core/app_strings.dart';
import 'package:healthy_routine/core/app_styles.dart';
import 'package:healthy_routine/core/components/reuseable_gap_widget.dart';
import 'package:healthy_routine/core/components/reuseable_task_container.dart';
import 'package:healthy_routine/models/routine.dart';
import 'package:healthy_routine/view/Fixed%20Routines/view/create_fixed_midday_routine_screen.dart';

import '../../../core/components/re_use_able_create_button.dart';

class CreateFixedAfternoonRoutineScreen extends StatelessWidget {
  final bool isAppBarNeeded;

  const CreateFixedAfternoonRoutineScreen(
      {super.key, this.isAppBarNeeded = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isAppBarNeeded
          ? AppBar(
              automaticallyImplyLeading: false,
              title: Text('Afternoon'),
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
                  Image.asset(
                    AppStrings.afternoon_logoPath,
                    color: AppColors.kprimaryColor,
                    width: MediaQuery.of(context).size.width / 4,
                  ),
                  const ReuseableGapWidget(),
                  Text('"Afternoon Energy Recharge"',
                      textAlign: TextAlign.center,
                      style: AppStyles.headingTextStyleBlack),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Elevate your energy levels with a curated afternoon routine designed to revitalize your mind and body.',
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
                title: 'Lunch (Eat healthy food in the afternoon)',
                subTitle: '1:00 PM',
                svgPath: AppStrings.lunchSvgPath,
              ),
              const ReUseAbleTaskContainer(
                title: 'Short Walk (Maintain a Healthy Body)',
                subTitle: '1:30 PM',
                svgPath: AppStrings.shortwalkSvgPath,
              ),
              const ReUseAbleTaskContainer(
                title: 'Hydration (Drink more water)',
                subTitle: '2:00 PM',
                svgPath: AppStrings.hydrationSvgPath,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ReUseAbleCreateButton(
                  onTap: () async {
                    RoutineController routineController = RoutineController();
                    Routine newRoutine = Routine(
                        routineName: 'Afternoon Energy Recharge',
                        routineDescription:
                            'Elevate your energy levels with a curated afternoon routine designed to revitalize your mind and body.',
                        selectedOption: 'Afternoon',
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
                            todoName:
                                'Lunch (Eat healthy food in the afternoon)',
                            time: getFutureDateTime(13, 0),
                          ),
                          Todo(
                            todoName: 'Short Walk (Maintain a Healthy Body)',
                            time: getFutureDateTime(13, 30),
                          ),
                          Todo(
                            todoName: 'Hydration (Drink more water)',
                            time: getFutureDateTime(14, 0),
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
