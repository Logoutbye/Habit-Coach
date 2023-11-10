import 'package:flutter/material.dart';
import 'package:healthy_routine/controllers/get_schedule_provider.dart';
import 'package:healthy_routine/core/components/build_routine_widget.dart';
import 'package:provider/provider.dart';

import 'fixed_routine_tab_bar_buttons.dart';

class FixedRoutineBodyWidget extends StatefulWidget {
  const FixedRoutineBodyWidget({
    super.key,
  });

  @override
  State<FixedRoutineBodyWidget> createState() => _FixedRoutineBodyWidgetState();
}

class _FixedRoutineBodyWidgetState extends State<FixedRoutineBodyWidget>
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
                      'fixed',
                    );
                    return BuildRoutineWidget(
                      timeOfDay: 'Morning',
                      routineType: 'fixed',
                      scheduleProvider: value,
                    );
                  },
                ),
                Consumer<ScheduleProvider>(builder: (context, value, child) {
                  Provider.of<ScheduleProvider>(context, listen: false)
                      .fetchSchedulesFromHive(
                    'Midday',
                    'fixed',
                  );
                  return BuildRoutineWidget(
                    timeOfDay: 'Midday',
                    routineType: 'fixed',
                    scheduleProvider: value,
                  );
                }),
                Consumer<ScheduleProvider>(builder: (context, value, child) {
                  Provider.of<ScheduleProvider>(context, listen: false)
                      .fetchSchedulesFromHive(
                    'Afternoon',
                    'fixed',
                  );
                  return BuildRoutineWidget(
                    timeOfDay: 'Afternoon',
                    routineType: 'fixed',
                    scheduleProvider: value,
                  );
                }),
                Consumer<ScheduleProvider>(builder: (context, value, child) {
                  Provider.of<ScheduleProvider>(context, listen: false)
                      .fetchSchedulesFromHive(
                    'Evening',
                    'fixed',
                  );

                  return BuildRoutineWidget(
                    timeOfDay: 'Evening',
                    routineType: 'fixed',
                    scheduleProvider: value,
                  );
                }),
                Consumer<ScheduleProvider>(builder: (context, value, child) {
                  Provider.of<ScheduleProvider>(context, listen: false)
                      .fetchSchedulesFromHive(
                    'Night',
                    'fixed',
                  );
                  return BuildRoutineWidget(
                    timeOfDay: 'Night',
                    routineType: 'fixed',
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
