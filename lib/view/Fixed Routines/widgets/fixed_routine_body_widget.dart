// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:healthy_routine/controllers/get_schedule_provider.dart';
import 'package:healthy_routine/core/components/build_routine_widget.dart';

import 'fixed_routine_tab_bar_buttons.dart';

class FixedRoutineBodyWidget extends StatefulWidget {
  late TabController tabController;
  FixedRoutineBodyWidget({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  State<FixedRoutineBodyWidget> createState() => _FixedRoutineBodyWidgetState();
}

class _FixedRoutineBodyWidgetState extends State<FixedRoutineBodyWidget>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          FixedRoutineTabbarButtons(tabController: widget.tabController),
          Expanded(
            child: TabBarView(
              controller: widget.tabController,
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
