import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';
import 'package:healthy_routine/core/app_colors.dart';
import 'package:healthy_routine/core/app_styles.dart';
import 'package:healthy_routine/core/components/re_use_able_create_button.dart';
import 'package:healthy_routine/core/components/reuseable_gap_widget.dart';
import 'package:healthy_routine/view/state/drop_down_provider.dart';
import 'package:healthy_routine/view/state/toggle_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/create_task_widget.dart';

class CreateFlexibleRoutineDashboard extends StatefulWidget {
  const CreateFlexibleRoutineDashboard({super.key});

  @override
  State<CreateFlexibleRoutineDashboard> createState() =>
      _CreateFlexibleRoutineDashboardState();
}

class _CreateFlexibleRoutineDashboardState
    extends State<CreateFlexibleRoutineDashboard> {
  final List<DayInWeek> _days = [
    DayInWeek("Mon", dayKey: "monday"),
    DayInWeek("Tue", dayKey: "tuesday"),
    DayInWeek("Wed", dayKey: "wednesday"),
    DayInWeek("Thur", dayKey: "thursday"),
    DayInWeek("Fri", dayKey: "friday"),
    DayInWeek("Sat", dayKey: "saturday"),
    DayInWeek("Sun", dayKey: "sunday"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kprimaryColor,
        foregroundColor: AppColors.kwhite,
        title:const Text('Create',),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Routine Name',
                    style: AppStyles.titleTextStyleprimarycolor,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 15,
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, top: 12, bottom: 6),
                  margin: const EdgeInsets.only(
                      left: 12, right: 12, bottom: 12, top: 4),
                  decoration: AppStyles.KContainerStyle,
                  child: TextFormField(
                    maxLines: 1,
                    decoration: const InputDecoration(
                        hintText: 'e.g Workout', border: InputBorder.none),
                  ),
                ),
              ],
            ),
            const ReuseableGapWidget(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Description',
                    style: AppStyles.titleTextStyleprimarycolor,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 10,
                  padding: const EdgeInsets.only(
                    left: 12,
                    right: 12,
                  ),
                  margin: const EdgeInsets.only(
                      left: 12, right: 12, bottom: 12, top: 4),
                  decoration: AppStyles.KContainerStyle,
                  child: TextFormField(
                    maxLines: 3,
                    decoration: const InputDecoration(
                        hintText: 'e.g   six biceps exercises on friday ',
                        border: InputBorder.none),
                  ),
                ),
              ],
            ),
            const ReuseableGapWidget(),
            Consumer<DropdownProvider>(
              builder: (context, dropdownModel, child) {
                return Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 15,
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, top: 12, bottom: 6),
                  margin: const EdgeInsets.only(
                      left: 12, right: 12, bottom: 12, top: 4),
                  decoration: AppStyles.KContainerStyle,
                  child: DropdownButton<String>(
                    borderRadius: BorderRadius.circular(20),
                    underline: const SizedBox(),
                    value: dropdownModel.selectedOption,
                    onChanged: (String? newValue) {
                      dropdownModel.setOption(
                          newValue!); // Use '!' to assert non-nullability
                    },
                    items: <String>[
                      'Morning',
                      'Midday',
                      'Afternoon',
                      'Evening',
                      'Night',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        alignment: Alignment.center,
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                );
              },
            ),

            // Consumer<TimeProvider>(builder: (context, timeProvider, _) {
            //   return InkWell(
            //     onTap: () => timeProvider.pickTime(context),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 16),
            //           child: Text(
            //             'Time',
            //             style: AppStyles.titleTextStyleprimarycolor,
            //           ),
            //         ),
            //         Container(
            //           width: double.infinity,
            //           height: MediaQuery.of(context).size.height / 15,
            //           padding: const EdgeInsets.only(
            //               left: 12, right: 12, top: 12, bottom: 6),
            //           margin: const EdgeInsets.only(
            //               left: 12, right: 12, bottom: 12, top: 4),
            //           decoration: AppStyles.KContainerStyle,
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Consumer<TimeProvider>(
            //                 builder: (context, timeProvider, _) {
            //                   return Column(
            //                     mainAxisAlignment: MainAxisAlignment.center,
            //                     children: [
            //                       Text(
            //                         timeProvider.formattedTime == ''
            //                             ? _formatTime(TimeOfDay.now())
            //                             : timeProvider.formattedTime,
            //                       ),
            //                     ],
            //                   );
            //                 },
            //               ),
            //               const Icon(
            //                 Icons.av_timer,
            //                 color: AppColors.kgrey,
            //               )
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   );
            // }),
            const ReuseableGapWidget(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 15,
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, top: 12, bottom: 12),
                  margin: const EdgeInsets.only(
                      left: 12, right: 12, bottom: 12, top: 4),
                  decoration: AppStyles.KContainerStyle,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Reminder'),
                      Consumer<SwitchProvider>(
                        builder: (context, switchProvider, _) {
                          return Switch(
                            activeColor: AppColors.kwhite,
                            activeTrackColor: AppColors.kprimaryColor,
                            value: switchProvider.isSwitchOn,
                            onChanged: (value) {
                              switchProvider.toggleSwitch();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const ReuseableGapWidget(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Repeat',
                    style: AppStyles.titleTextStyleprimarycolor,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 15,
                  // padding: const EdgeInsets.only(
                  //     left: 12, right: 12, top: 12, bottom: 6),
                  margin: const EdgeInsets.only(
                      left: 12, right: 12, bottom: 12, top: 4),
                  decoration: AppStyles.KContainerStyle,
                  child: SelectWeekDays(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    days: _days,
                    border: false,
                    selectedDayTextColor: AppColors.kprimaryColor,
                    unSelectedDayTextColor: AppColors.kgrey,
                    backgroundColor: Colors.transparent,
                    onSelect: (values) {
                      print(values);
                    },
                  ),
                ),
              ],
            ),
            const ReuseableGapWidget(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Add Activities',
                    style: AppStyles.titleTextStyleprimarycolor,
                  ),
                ),
                //
              ],
            ),
            CreateTaskWidget(),
            const ReuseableGapWidget(),
            ReUseAbleCreateButton(
              onTap: () {},
              buttonTextTitle: 'Create Routine',
            ),
          ],
        ),
      ),
    );
  }
}
