import 'package:flutter/material.dart';
import 'package:healthy_routine/core/app_colors.dart';
import 'package:healthy_routine/view/Fixed%20Routines/widgets/fixed_routine_body_widget.dart';
import 'package:healthy_routine/core/components/routines_header_widget.dart';

class FixedRoutinesDashboard extends StatefulWidget {
  const FixedRoutinesDashboard({Key? key}) : super(key: key);

  @override
  State<FixedRoutinesDashboard> createState() => _FixedRoutinesDashboardState();
}

class _FixedRoutinesDashboardState extends State<FixedRoutinesDashboard>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

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
        body: Column(
          children: [
            RoutinesHeaderWidget(
              title: 'Fixed Routines',
              index: tabController.index,
            ),
            FixedRoutineBodyWidget(
              tabController: tabController,
            ),
          ],
        ),
      ),
    );
  }
}
