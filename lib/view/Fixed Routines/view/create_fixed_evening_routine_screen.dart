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
import 'package:healthy_routine/view/Fixed%20Routines/view/create_fixed_midday_routine_screen.dart';

class CreateFixedEveningRoutineScreen extends StatelessWidget {
  const CreateFixedEveningRoutineScreen(
      {super.key, this.isAppBarNeeded = false});
  final bool isAppBarNeeded;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isAppBarNeeded
          ? AppBar(
              automaticallyImplyLeading: false,
              title: Text('Evening'),
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
                  SvgPicture.asset(AppStrings.evening_logoPath),
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
                title: 'Dinner (Eat healthy food in the Evening)',
                subTitle: '8:00 PM',
                svgPath: AppStrings.lunchSvgPath,
              ),
              const ReUseAbleTaskContainer(
                title: 'Hydration (Drink more water)',
                subTitle: '8:30 PM',
                svgPath: AppStrings.hydrationSvgPath,
              ),
              const ReUseAbleTaskContainer(
                title: 'Relaxation (Mind Refreshing)',
                subTitle: '8:45 PM',
                svgPath: AppStrings.meditationSvgPath,
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
                            todoName:
                                'Dinner (Eat healthy food in the Evening)',
                            time: getFutureDateTime(20, 0),
                          ),
                          Todo(
                            todoName: 'Hydration (Drink more water)',
                            time: getFutureDateTime(20, 30),
                          ),
                          Todo(
                            todoName: 'Relaxation (Mind Refreshing)',
                            time: getFutureDateTime(20, 45),
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
