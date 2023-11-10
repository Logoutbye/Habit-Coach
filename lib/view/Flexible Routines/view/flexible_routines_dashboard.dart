import 'package:flutter/material.dart';
import 'package:healthy_routine/core/app_colors.dart';
import 'package:healthy_routine/core/components/routines_header_widget.dart';
import 'package:healthy_routine/view/Flexible%20Routines/widgets/flexible_routine_body_widget.dart';
class FlexibleRoutinesDashboard extends StatelessWidget {
  const FlexibleRoutinesDashboard({Key? key}) : super(key: key);

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
            RoutinesHeaderWidget(
              title: 'Flexible Routines',
            ),
            FlexibleRoutineBodyWidget(),
          ],
        ),
        // floatingActionButton: const floatingActionWidget(),
      ),
    );
  }
}
