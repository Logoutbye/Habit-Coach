import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_routine/core/app_strings.dart';
import 'package:healthy_routine/core/components/reuseable_gap_widget.dart';
import 'package:healthy_routine/core/components/reuseable_task_container.dart';

import '../../core/components/re_use_able_create_button.dart';

class CreateFixedDayRoutineScreen extends StatelessWidget {
  const CreateFixedDayRoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width / 1.1,
            height: MediaQuery.of(context).size.height / 5.2,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              children: [
                // Image.asset(AppStrings.morningIconPath),
                SvgPicture.asset(AppStrings.daySvgPath),
                const ReuseableGapWidget(),
                const Text(
                  '"Stay Active Throughout the Day"',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF4F4F4F),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                )
              ],
            )),
        const Divider(
          color: Colors.transparent,
        ),
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
                onTap: () {},
                buttonTextTitle: 'Add All',
              ),
            ),
          ],
        ))
      ],
    );
  }
}
