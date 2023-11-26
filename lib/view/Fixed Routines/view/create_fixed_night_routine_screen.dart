import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_routine/controllers/routine_controller.dart';
import 'package:healthy_routine/core/app_colors.dart';
import 'package:healthy_routine/core/app_strings.dart';
import 'package:healthy_routine/core/app_styles.dart';
import 'package:healthy_routine/core/components/reuseable_gap_widget.dart';
import 'package:healthy_routine/core/components/reuseable_task_container.dart';
import 'package:healthy_routine/models/routine.dart';
import 'package:healthy_routine/view/Fixed%20Routines/view/create_fixed_midday_routine_screen.dart';
import '../../../core/components/re_use_able_create_button.dart';

class CreateFixedNightRoutineScreen extends StatelessWidget {
  const CreateFixedNightRoutineScreen({super.key, this.isAppBarNeeded = false});
  final bool isAppBarNeeded;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isAppBarNeeded
          ? AppBar(
              // automaticallyImplyLeading: false,
              title: Text('Night'),
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
                title:
                    'Digital Detox (Keep yourself away from Digital devices)',
                subTitle: '09:15 PM',
                svgPath: 'digital',
              ),
              const ReUseAbleTaskContainer(
                title: 'Pre-bedtime routine (Take Bath | Relax | Meditate)',
                subTitle: '09:45 PM',
                svgPath: AppStrings.prebedSvgPath,
              ),
              const ReUseAbleTaskContainer(
                title: 'Sleep (Healthy Dream with Deep Sleep)',
                subTitle: '10:00 PM',
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
                            todoName:
                                'Digital Detox (Keep yourself away from Digital devices)',
                            time: getFutureDateTime(21, 15),
                          ),
                          Todo(
                            todoName:
                                'Pre-bedtime routine (Take Bath | Relax | Meditate)',
                            time: getFutureDateTime(21, 45),
                          ),
                          Todo(
                            todoName: 'Sleep (Healthy Dream with Deep Sleep )',
                            time: getFutureDateTime(22, 0),
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
