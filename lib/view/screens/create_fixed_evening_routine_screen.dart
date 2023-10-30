import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_routine/core/app_strings.dart';
import 'package:healthy_routine/core/components/reuseable_gap_widget.dart';
import 'package:healthy_routine/core/components/reuseable_task_container.dart';

import '../../core/components/re_use_able_create_button.dart';

class CreateFixedEveningRoutineScreen extends StatelessWidget {
  const CreateFixedEveningRoutineScreen({super.key});

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
                SvgPicture.asset(AppStrings.eveningSvgPath),
                const ReuseableGapWidget(),
                const Text(
                  '"Evening Relaxation and Unwind"',
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
