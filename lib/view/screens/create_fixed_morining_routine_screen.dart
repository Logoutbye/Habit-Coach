import 'package:flutter/material.dart';
import 'package:healthy_routine/core/app_strings.dart';
import 'package:healthy_routine/core/components/reuseable_gap_widget.dart';
import 'package:healthy_routine/core/components/reuseable_task_container.dart';

import '../../core/components/re_use_able_create_button.dart';

class CreateFixedMoriningRoutineScreen extends StatelessWidget {
  const CreateFixedMoriningRoutineScreen({super.key});

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
                Image.asset(AppStrings.morningIconPath),
                // SvgPicture.asset(AppStrings.morningSvgPath),
                const ReuseableGapWidget(),
                const Text(
                  '"Energize Your Mornings"',
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
              title: 'Make Bed',
              subTitle: '6:00 AM',
              svgPath: AppStrings.makebedSvgPath,
            ),
            const ReUseAbleTaskContainer(
              title: 'Hydration',
              subTitle: '6:15 AM',
              svgPath: AppStrings.hydrationSvgPath,
            ),
            const ReUseAbleTaskContainer(
              title: 'Physical Activity',
              subTitle: '6:30 AM',
              svgPath: AppStrings.physicalSvgPath,
            ),
            const ReUseAbleTaskContainer(
              title: 'Medition',
              subTitle: '7:10 AM',
              svgPath: AppStrings.meditationSvgPath,
            ),
            const ReUseAbleTaskContainer(
              title: 'Break Fast Reminder',
              subTitle: '8:15 AM',
              svgPath: AppStrings.remindarSvgPath,
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
