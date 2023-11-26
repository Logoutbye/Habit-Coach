import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';
import 'package:healthy_routine/controllers/routine_controller.dart';
import 'package:healthy_routine/core/app_colors.dart';
import 'package:healthy_routine/core/app_styles.dart';
import 'package:healthy_routine/core/components/re_use_able_create_button.dart';
import 'package:healthy_routine/core/components/reuseable_gap_widget.dart';
import 'package:healthy_routine/core/utils.dart';
import 'package:healthy_routine/models/routine.dart';
import 'package:healthy_routine/state/drop_down_provider.dart';
import 'package:healthy_routine/state/selected_day_provider.dart';
import 'package:healthy_routine/state/task_provider.dart';
import 'package:healthy_routine/state/toggle_provider.dart';
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
  void initState() {
    Future.delayed(Duration.zero, () {
      var todoProvider = Provider.of<TodoProvider>(context, listen: false);
      todoProvider.clearTasks(); // Clear the tasks list
    });
    super.initState();
  }

  TextEditingController routineNameTextController = TextEditingController();
  TextEditingController routineDescriptionTextController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    var dropDownProvider = Provider.of<DropdownProvider>(context);
    var reminderProvider = Provider.of<SwitchProvider>(context);
    var selectedDaysProvider = Provider.of<SelectedDaysProvider>(context);
    var todoProvider = Provider.of<TodoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kprimaryColor,
        foregroundColor: AppColors.kwhite,
        title: const Text(
          'Create',
        ),
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
                    style: AppStyles.titleTextStyleofCreateScreen,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 15,
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, top: 12, bottom: 12),
                  margin: const EdgeInsets.only(
                      left: 12, right: 12, bottom: 12, top: 4),
                  decoration: AppStyles.KContainerStyle,
                  child: TextFormField(
                    controller: routineNameTextController,
                    maxLines: 1,
                    style: AppStyles.titleTextStyleprimarycolor,
                    decoration: InputDecoration(
                        hintStyle: AppStyles.weekDaysTextGreycolor,
                        hintText: 'e.g Workout',
                        border: InputBorder.none),
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
                    style: AppStyles.titleTextStyleofCreateScreen,
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
                    controller: routineDescriptionTextController,
                    maxLines: 3,
                    style: AppStyles.titleTextStyleprimarycolor,
                    decoration: InputDecoration(
                        hintText: 'e.g   six biceps exercises on friday ',
                        hintStyle: AppStyles.weekDaysTextGreycolor,
                        border: InputBorder.none),
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
                    // style: TextStyle(
                    //   color: AppColors.kprimaryColor,
                    //   fontSize: 13,
                    //   fontFamily: AppStyles.appFontFamily,
                    //   fontWeight: FontWeight.w500,
                    // ),
                    style: AppStyles.titleTextStyleofCreateScreen,
                  ),
                ),
                //
              ],
            ),
            CreateTaskWidget(),
            const ReuseableGapWidget(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Time Of the Day',
                    style: AppStyles.titleTextStyleofCreateScreen,
                    // style: AppStyles.titleTextStyleprimarycolor,
                  ),
                ),
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
                        alignment: Alignment.center,
                        icon: Icon(
                          Icons.arrow_drop_down_rounded,
                          color: AppColors.kprimaryColor,
                        ),
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
                            child: Text(
                              value,
                              style: AppStyles.titleTextStyleprimarycolor,
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
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
                    'Recieve Notifications',
                    style: AppStyles.titleTextStyleofCreateScreen,
                    // style: AppStyles.titleTextStyleprimarycolor,
                  ),
                ),
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
                      Text(
                        'Reminder',
                        style: AppStyles.weekDaysTextGreycolor,
                      ),
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
                    style: AppStyles.titleTextStyleofCreateScreen,
                    // style: AppStyles.titleTextStyleprimarycolor,
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
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    days: _days,
                    border: false,
                    daysFillColor: AppColors.kprimaryColor,
                    selectedDayTextColor: AppColors.kwhite,
                    unSelectedDayTextColor: AppColors.kgrey,
                    backgroundColor: Colors.transparent,
                    onSelect: (values) {
                      List<String> fixedOrderDays = [
                        "monday",
                        "tuesday",
                        "wednesday",
                        "thursday",
                        "friday",
                        "saturday",
                        "sunday",
                      ];

                      // Sort the selected days based on the fixed order
                      values.sort((a, b) =>
                          fixedOrderDays.indexOf(a) -
                          fixedOrderDays.indexOf(b));

                      selectedDaysProvider.setDays(values);
                    },
                  ),
                ),
              ],
            ),
            const ReuseableGapWidget(),
            ReUseAbleCreateButton(
              onTap: () async {
                if (routineNameTextController.text.isEmpty) {
                  Utils.showFlushbar('Routine Name Empty!', context);
                } else if (routineDescriptionTextController.text.isEmpty) {
                  Utils.showFlushbar('Routine Description Empty!', context);
                } else if (selectedDaysProvider.selectedDays.isEmpty) {
                  Utils.showFlushbar('Choose Day!', context);
                } else if (todoProvider.tasks.isEmpty) {
                  Utils.showFlushbar(
                      'please enter at least one to-do!', context);
                } else {
                  RoutineController routineController = RoutineController();
                  Routine newRoutine = Routine(
                      routineName: routineNameTextController.text,
                      routineDescription: routineDescriptionTextController.text,
                      selectedOption: dropDownProvider.selectedOption,
                      isSwitchOn: reminderProvider.isSwitchOn,
                      selectedDays: selectedDaysProvider.selectedDays,
                      todos: todoProvider.tasks,
                      routineType: 'flexible');

                  await routineController.saveRoutine(newRoutine, context);

                  routineNameTextController.clear();
                  routineDescriptionTextController.clear();
                  dropDownProvider.setOption(
                      'Morning'); // Set it to the initial state or another default value
                  reminderProvider
                      .toggleSwitch(); // Set it to the initial state or another default value
                  selectedDaysProvider.setDays(
                      []); // Set it to the initial state or another default value
                  // todoProvider.clearTasks(); // Clear the tasks list
                }
              },
              buttonTextTitle: 'Create Routine',
            ),
          ],
        ),
      ),
    );
  }
}
