import 'package:flutter/material.dart';
import 'package:healthy_routine/controllers/get_schedule_provider.dart';
import 'package:healthy_routine/controllers/routine_controller.dart';
import 'package:healthy_routine/core/app_colors.dart';
import 'package:healthy_routine/core/app_strings.dart';
import 'package:healthy_routine/core/app_styles.dart';
import 'package:healthy_routine/core/components/reuseable_gap_widget.dart';
import 'package:healthy_routine/core/routings/slide_transition_page.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../view/edit_routine_screen.dart';

class TodayRoutineBodyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Consumer<ScheduleProvider>(
          builder: (context, scheduleProvider, child) {
            // Fetch schedules for today when the widget is first built
            scheduleProvider.fetchSchedulesForToday();

            if (scheduleProvider.schedules.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Lottie.asset(AppStrings.animationPath,
                          width: MediaQuery.of(context).size.width / 1.5)),
                  Text(
                    'No routine for Today',
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
              itemCount: scheduleProvider.schedules.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Theme(
                      data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(6),
                        margin: const EdgeInsets.only(left: 12, right: 12),
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
                                      scheduleProvider.schedules[index]
                                                  ['alerts'] ==
                                              true
                                          ? Icons.notifications_on
                                          : Icons.notifications_off,
                                      color: AppColors.kprimaryColor,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          15,
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
                                child: scheduleProvider.schedules[index]
                                            ['routineType'] ==
                                        'fixed'
                                    ? Text('Fixed Routine')
                                    : Text('Flexible Routine'),
                              )
                            ],
                          ),
                          title: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width / 2,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: ShapeDecoration(
                                      color: AppColors.kprimaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            scheduleProvider.schedules[index]
                                                ['taskName'],
                                            textAlign: TextAlign.center,
                                            style: AppStyles
                                                .titleTextStylewhitecolor),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width / 2,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 0),
                                    child: Text(
                                      scheduleProvider.schedules[index]
                                          ['description'],
                                      style: AppStyles
                                          .taskSubtitleTextStyleblackcolor,
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
                                Row(
                                  children: [
                                    // InkWell(
                                    //   onTap: () {
                                    //     Navigator.push(
                                    //         context,
                                    //         SlideTransitionPage(
                                    //             page: EditRoutineScreen()));
                                    //   },
                                    //   child: Padding(
                                    //     padding:
                                    //         const EdgeInsets.only(right: 28.0),
                                    //     child: Icon(
                                    //       Icons.edit,
                                    //       color: AppColors.kprimaryColor,
                                    //       size: 22,
                                    //     ),
                                    //   ),
                                    // ),
                              
                                    InkWell(
                                      onTap: () {
                                        RoutineController routinecontroller =
                                            RoutineController();
                                        routinecontroller.deleteRoutine(
                                            index, context);
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 28.0),
                                        child: Icon(
                                          Icons.delete,
                                          color: AppColors.kprimaryColor,
                                          size: 22,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            ReuseableGapWidget(),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: scheduleProvider
                                  .schedules[index]['todos'].length,
                              itemBuilder: (context, todoIndex) {
                                var todos =
                                    scheduleProvider.schedules[index]['todos'];
                                if (todoIndex < todos.length) {
                                  var todo = todos[todoIndex];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 18.0),
                                          child: Text(
                                            '${todoIndex + 1} ',
                                            style: AppStyles
                                                .tasktitleTextStyleblackcolor,
                                          ),
                                        ),
                                        Container(
                                          constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.4,
                                          ),
                                          margin: const EdgeInsets.all(2),
                                          padding: const EdgeInsets.all(6),
                                          decoration: ShapeDecoration(
                                            color: AppColors.kprimaryColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.task,
                                                    color: AppColors.kwhite,
                                                    size: 18,
                                                  ),
                                                  Text(
                                                    '  ${todo['todoName']}',
                                                    style: AppStyles
                                                        .titleTextStylewhitecolor,
                                                  ),
                                                ],
                                              ),
                                              ReuseableGapWidget(),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.watch_later,
                                                    color: AppColors.kwhite,
                                                    size: 18,
                                                  ),
                                                  Text(
                                                    '  ${todo['time']}',
                                                    style: AppStyles
                                                        .titleTextStylewhitecolor,
                                                  ),
                                                ],
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
          },
        ),
      ),
    );
  }
}
