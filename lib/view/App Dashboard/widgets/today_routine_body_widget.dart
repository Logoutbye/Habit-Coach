import 'package:flutter/material.dart';
import 'package:healthy_routine/controllers/get_schedule_provider.dart';
import 'package:healthy_routine/controllers/routine_controller.dart';
import 'package:healthy_routine/core/app_colors.dart';
import 'package:healthy_routine/core/app_strings.dart';
import 'package:healthy_routine/core/app_styles.dart';
import 'package:healthy_routine/core/components/reuseable_gap_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class TodayRoutineBodyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, Color> timeColors = {
      'Morning': Color(0xFFB0E0E6),
      'Midday': Color(0xFFFFFDD0),
      'Afternoon': Color(0xFFFFDAB9),
      'Evening': Color(0xFFE6E6FA),
      'Night': Color(0xFFFFD1DC),
      'Flexible Routine': Color(0xFF87CEFA),
    };
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
                var selectedOption =
                    scheduleProvider.schedules[index]['selectedOption'];

                var color = timeColors.containsKey(selectedOption)
                    ? timeColors[selectedOption]
                    : Colors.grey; // Default color for unknown options
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
                        // decoration: AppStyles.KContainerStyle,
                        decoration: ShapeDecoration(
                            // color: colors[index % colors.length],
                            color: scheduleProvider.schedules[index]
                                        ['routineType'] ==
                                    'flexible'
                                ? Color(0xFF87CEFA)
                                : color,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
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
                                                1.3,
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
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 4),
                                                    constraints: BoxConstraints(
                                                        maxWidth: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.5),
                                                    child: Text(
                                                      '${todo['todoName']}',
                                                      style: AppStyles
                                                          .titleTextStylewhitecolor,
                                                    ),
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
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 4),
                                                    child: Text(
                                                      '${todo['time']}',
                                                      style: AppStyles
                                                          .titleTextStylewhitecolor,
                                                    ),
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

  final List<Color> colors = [
    Color(0xFFFFD700), // Light Gold
    Color(0xFFFFD1DC), // Pale Pink
    Color(0xFFE6E6FA), // Light Lavender
    Color(0xFF98FF98), // Mint Green
    Color(0xFFFFDAB9), // Peach
    Color(0xFF87CEEB), // Sky Blue
    Color(0xFFD3D3D3), // Light Gray
    Color(0xFFFFFDD0), // Cream
    Color(0xFFFFF0F5), // Lavender Blush
    Color(0xFFE0FFFF), // Light Cyan
  ];
  // final List<Color> colors = [
  //   Colors.deepPurple, // Dark purple
  //   Colors.green, // Green
  //   Colors.deepOrange, // Deep orange
  //   Colors.blueGrey, // Blue-grey
  //   // Add more colors as needed
  // ];
  // final List<Color> colors = [
  //   Color(0xFFFF8C00), // Complementary color (orange)
  //   Color(0xFF00CED1), // Triadic color (teal)
  //   Color(0xFFFFD700), // Triadic color (yellow)
  //   Color(0xFF32CD32), // Analogous color (green)
  //   Color(0xFF8A2BE2), // Analogous color (purple)
  //   // Add more colors as needed
  // ];
}
