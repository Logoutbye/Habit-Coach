import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_routine/controllers/routine_controller.dart';
import 'package:healthy_routine/core/app_colors.dart';
import 'package:healthy_routine/core/app_strings.dart';
import 'package:healthy_routine/core/app_styles.dart';
import 'package:healthy_routine/core/components/reuseable_gap_widget.dart';
import 'package:healthy_routine/core/components/reuseable_task_container.dart';
import 'package:healthy_routine/models/routine.dart';
import 'package:healthy_routine/view/Fixed%20Routines/view/create_fixed_day_routine_screen.dart';
import '../../../core/components/re_use_able_create_button.dart';

class CreateFixedNightRoutineScreen extends StatelessWidget {
  const CreateFixedNightRoutineScreen({super.key});

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
                SvgPicture.asset(AppStrings.nightSvgPath),
                const ReuseableGapWidget(),
                const ReuseableGapWidget(),
                Text('"Personalize Your Nighttime Tranquility"',
                    textAlign: TextAlign.center,
                    style: AppStyles.headingTextStyleBlack),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Curate a nighttime routine tailored to your tranquility needs. Include activities that foster restful sleep.',
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
              title: 'Digital Detox',
              subTitle: '09:45 PM',
              svgPath: AppStrings.digitalSvgPath,
            ),
            const ReUseAbleTaskContainer(
              title: 'Pre-Bed Time Routine',
              subTitle: '10:00 PM',
              svgPath: AppStrings.prebedSvgPath,
            ),
            const ReUseAbleTaskContainer(
              title: 'Sleep',
              subTitle: '10:15 PM',
              svgPath: AppStrings.sleepSvgPath,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ReUseAbleCreateButton(
                onTap: () async {
                  RoutineController routineController = RoutineController();
                  Routine newRoutine = Routine(
                      routineName: 'Your Personalized Nighttime Tranquility',
                      routineDescription:
                          'Wind down for a restful night with your customized nighttime routine, promoting peaceful and rejuvenating sleep.',
                      selectedOption: 'Night',
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
                          todoName: 'Digital Detox',
                          time: getFutureDateTime(21, 45),
                        ),
                        Todo(
                          todoName: 'Pre-Bed Time Routine',
                          time: getFutureDateTime(22, 0),
                        ),
                        Todo(
                          todoName: 'Sleep',
                          time: getFutureDateTime(22, 15),
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
