


import 'package:flutter/material.dart';
import 'package:healthy_routine/controllers/get_schedule_provider.dart';
import 'package:healthy_routine/core/components/build_routine_widget.dart';
import 'package:healthy_routine/view/Fixed%20Routines/widgets/fixed_routine_tab_bar_buttons.dart';
import 'package:provider/provider.dart';

class FlexibleRoutineBodyWidget extends StatefulWidget {
  const FlexibleRoutineBodyWidget({
    super.key,
  });

  @override
  State<FlexibleRoutineBodyWidget> createState() =>
      _FlexibleRoutineBodyWidgetState();
}

class _FlexibleRoutineBodyWidgetState extends State<FlexibleRoutineBodyWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          FixedRoutineTabbarButtons(tabController: _tabController),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Consumer<ScheduleProvider>(
                  builder: (context, value, child) {
                    Provider.of<ScheduleProvider>(context, listen: false)
                        .fetchSchedulesFromHive(
                      'Morning',
                      'flexible',
                    );
                    return BuildRoutineWidget(
                      timeOfDay: 'Morning',
                      routineType: 'flexible',
                      scheduleProvider: value,
                    );
                  },
                ),
                Consumer<ScheduleProvider>(builder: (context, value, child) {
                  Provider.of<ScheduleProvider>(context, listen: false)
                      .fetchSchedulesFromHive(
                    'Midday',
                    'flexible',
                  );
                  return BuildRoutineWidget(
                    timeOfDay: 'Midday',
                    routineType: 'flexible',
                    scheduleProvider: value,
                  );
                }),
                Consumer<ScheduleProvider>(builder: (context, value, child) {
                  Provider.of<ScheduleProvider>(context, listen: false)
                      .fetchSchedulesFromHive(
                    'Afternoon',
                    'flexible',
                  );
                  return BuildRoutineWidget(
                    timeOfDay: 'Afternoon',
                    routineType: 'flexible',
                    scheduleProvider: value,
                  );
                }),
                Consumer<ScheduleProvider>(builder: (context, value, child) {
                  Provider.of<ScheduleProvider>(context, listen: false)
                      .fetchSchedulesFromHive(
                    'Evening',
                    'flexible',
                  );
                  return BuildRoutineWidget(
                    timeOfDay: 'Evening',
                    routineType: 'flexible',
                    scheduleProvider: value,
                  );
                }),
                Consumer<ScheduleProvider>(builder: (context, value, child) {
                  Provider.of<ScheduleProvider>(context, listen: false)
                      .fetchSchedulesFromHive(
                    'Night',
                    'flexible',
                  );
                  return BuildRoutineWidget(
                    timeOfDay: 'Night',
                    routineType: 'flexible',
                    scheduleProvider: value,
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
