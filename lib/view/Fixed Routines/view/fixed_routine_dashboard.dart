import 'package:flutter/material.dart';
import 'package:healthy_routine/core/app_colors.dart';
import 'package:healthy_routine/view/Fixed%20Routines/widgets/fixed_routine_body_widget.dart';
import 'package:healthy_routine/core/components/routines_header_widget.dart';

class FixedRoutinesDashboard extends StatelessWidget {
  const FixedRoutinesDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.zero,
          child: AppBar(
            backgroundColor: AppColors.kprimaryColor,
          ),
        ),
        body: const Column(
          children: [
            RoutinesHeaderWidget(title: 'Fixed Routines',),
            FixedRoutineBodyWidget(),
          ],
        ),
        // floatingActionButton: const floatingActionWidget(),
      ),
    );
  }
}
