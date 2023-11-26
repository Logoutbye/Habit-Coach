import 'package:flutter/material.dart';
import 'package:healthy_routine/controllers/routine_controller.dart';
import 'package:healthy_routine/core/app_colors.dart';
import 'package:healthy_routine/core/app_strings.dart';
import 'package:healthy_routine/core/components/reuseable_gap_widget.dart';
import 'package:healthy_routine/controllers/get_schedule_provider.dart';
import 'package:healthy_routine/state/set_screen_index_for_fixed_routine_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../app_styles.dart';

class BuildRoutineWidget extends StatefulWidget {
  final String timeOfDay;
  final String routineType;
  final scheduleProvider;

  BuildRoutineWidget({
    required this.timeOfDay,
    required this.routineType,
    required this.scheduleProvider,
    Key? key,
  }) : super(key: key);

  @override
  State<BuildRoutineWidget> createState() => _BuildRoutineWidgetState();
}

class _BuildRoutineWidgetState extends State<BuildRoutineWidget> {
  @override
  void initState() {
    var screenIndexProvider =
        Provider.of<SetScreenIndexForFixedRoutineProvider>(context,
            listen: false);
    Future.microtask(() {

      if (widget.routineType == 'fixed' && widget.timeOfDay == 'Morning') {
        screenIndexProvider.SetScreenIndex(0);
      } else if (widget.routineType == 'fixed' &&
          widget.timeOfDay == 'Midday') {
        screenIndexProvider.SetScreenIndex(1);
      } else if (widget.routineType == 'fixed' &&
          widget.timeOfDay == 'Afternoon') {
        screenIndexProvider.SetScreenIndex(2);
      } else if (widget.routineType == 'fixed' &&
          widget.timeOfDay == 'Evening') {
        screenIndexProvider.SetScreenIndex(3);
      } else if (widget.routineType == 'fixed' && widget.timeOfDay == 'Night') {
        screenIndexProvider.SetScreenIndex(4);
      }
    });
    Provider.of<ScheduleProvider>(context, listen: false)
        .fetchSchedulesFromHive(widget.timeOfDay, widget.routineType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.scheduleProvider.schedules.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Lottie.asset(AppStrings.animationPath,
                  width: MediaQuery.of(context).size.width / 1.5)),
          Text(
            'No routine for ${widget.timeOfDay}',
            style: AppStyles.titleTextStyleprimarycolor,
          ),
          Text(
            'Press "Add New" to create one.',
            style: AppStyles.weekDaysTextPrimarycolor,
          )
        ],
      );
    }
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: widget.scheduleProvider.schedules.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(left: 16, right: 16),
                decoration: AppStyles.KContainerStyle,
                child: ExpansionTile(
                  initiallyExpanded: false,
                  collapsedIconColor: AppColors.kgrey,
                  collapsedBackgroundColor: Colors.transparent,
                  trailing: Column(
                    children: [
                      FittedBox(
                        child: Row(
                          children: [
                            Icon(
                              widget.scheduleProvider.schedules[index]
                                          ['alerts'] ==
                                      true
                                  ? Icons.notifications_on
                                  : Icons.notifications_off,
                              color: AppColors.kprimaryColor,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 15,
                            ),
                            const Icon(
                              Icons.arrow_drop_down_circle,
                              color: AppColors.kprimaryColor,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'S',
                                  style: widget.scheduleProvider
                                          .schedules[index]['weekDays']
                                          .contains('sunday')
                                      ? AppStyles.weekDaysTextPrimarycolor
                                      : AppStyles.weekDaysTextGreycolor),
                              TextSpan(
                                  text: 'M',
                                  style: widget.scheduleProvider
                                          .schedules[index]['weekDays']
                                          .contains('monday')
                                      ? AppStyles.weekDaysTextPrimarycolor
                                      : AppStyles.weekDaysTextGreycolor),
                              TextSpan(
                                  text: 'T',
                                  style: widget.scheduleProvider
                                          .schedules[index]['weekDays']
                                          .contains('tuesday')
                                      ? AppStyles.weekDaysTextPrimarycolor
                                      : AppStyles.weekDaysTextGreycolor),
                              TextSpan(
                                  text: 'W',
                                  style: widget.scheduleProvider
                                          .schedules[index]['weekDays']
                                          .contains('wednesday')
                                      ? AppStyles.weekDaysTextPrimarycolor
                                      : AppStyles.weekDaysTextGreycolor),
                              TextSpan(
                                  text: 'T',
                                  style: widget.scheduleProvider
                                          .schedules[index]['weekDays']
                                          .contains('thursday')
                                      ? AppStyles.weekDaysTextPrimarycolor
                                      : AppStyles.weekDaysTextGreycolor),
                              TextSpan(
                                  text: 'F',
                                  style: widget.scheduleProvider
                                          .schedules[index]['weekDays']
                                          .contains('friday')
                                      ? AppStyles.weekDaysTextPrimarycolor
                                      : AppStyles.weekDaysTextGreycolor),
                              TextSpan(
                                  text: 'S',
                                  style: widget.scheduleProvider
                                          .schedules[index]['weekDays']
                                          .contains('saturday')
                                      ? AppStyles.weekDaysTextPrimarycolor
                                      : AppStyles.weekDaysTextGreycolor),
                            ]),
                          )),
                    ],
                  ),
                  title: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width / 2,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 8),
                            decoration: ShapeDecoration(
                              color: AppColors.kprimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    widget.scheduleProvider.schedules[index]
                                        ['taskName'],
                                    textAlign: TextAlign.center,
                                    style: AppStyles.titleTextStylewhitecolor),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width / 2,
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            child: Text(
                              widget.scheduleProvider.schedules[index]
                                  ['description'],
                              style: AppStyles.taskSubtitleTextStyleblackcolor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: <Widget>[
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 28.0),
                          child: Text('Task',
                              style: AppStyles.weekDaysTextGreycolor),
                        ),
                        InkWell(
                          onTap: () {
                            RoutineController routinecontroller =
                                RoutineController();
                            routinecontroller.deleteRoutine(index, context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 28.0),
                            child: Icon(
                              Icons.delete,
                              color: AppColors.kprimaryColor,
                              size: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget
                          .scheduleProvider.schedules[index]['todos'].length,
                      itemBuilder: (context, todoIndex) {
                        var todos =
                            widget.scheduleProvider.schedules[index]['todos'];
                        if (todoIndex < todos.length) {
                          var todo = todos[todoIndex];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 24.0),
                                  child: Text(
                                    '${todoIndex + 1}',
                                    style:
                                        AppStyles.tasktitleTextStyleblackcolor,
                                  ),
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width / 1.4,
                                  ),
                                  margin: const EdgeInsets.all(8),
                                  padding: const EdgeInsets.all(8),
                                  decoration: ShapeDecoration(
                                    color: AppColors.kprimaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${todo['todoName']}',
                                        style:
                                            AppStyles.titleTextStylewhitecolor,
                                      ),
                                      Text(
                                        '${todo['time']}',
                                        style:
                                            AppStyles.titleTextStylewhitecolor,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const SizedBox
                              .shrink(); // Return an empty widget if index is out of bounds
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const ReuseableGapWidget(),
          ],
        );
      },
    );
  }
}
