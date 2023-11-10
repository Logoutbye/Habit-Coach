import 'package:flutter/material.dart';
import 'package:healthy_routine/core/app_colors.dart';
import 'package:healthy_routine/core/app_styles.dart';
import 'package:healthy_routine/core/components/reuseable_gap_widget.dart';
import 'package:healthy_routine/state/task_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/routine.dart';

class CreateTaskWidget extends StatelessWidget {
  final TextEditingController _taskController = TextEditingController();

  CreateTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => _showAddTaskDialog(context),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 15,
            padding:
                const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
            margin:
                const EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 4),
            decoration: AppStyles.KContainerStyle,
            child: Row(
              children: [
                Icon(
                  Icons.add_circle_outline,
                  color: AppColors.kgrey,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'To-do',
                  style: AppStyles.weekDaysTextGreycolor,
                ),
              ],
            ),
          ),
        ),
        Consumer<TodoProvider>(
          builder: (context, taskProvider, child) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: taskProvider.tasks.length,
              itemBuilder: (context, index) {
                Todo task = taskProvider.tasks[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: AppStyles.KContainerStyle,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${index + 1}.',
                                style: AppStyles.weekDaysTextGreycolor),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('Task:',
                                        style: AppStyles.weekDaysTextGreycolor),
                                    Text(
                                      '${task.todoName}',
                                      style: AppStyles.weekDaysTextPrimarycolor,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Time:',
                                        style: AppStyles.weekDaysTextGreycolor),
                                    Text(
                                      '${_formatTime(task.time)}',
                                      style: AppStyles.weekDaysTextPrimarycolor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Future<void> _showAddTaskDialog(BuildContext context) async {
    DateTime selectedTime = DateTime.now();

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Builder(
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text(
                        'Enter Task Name',
                        style: AppStyles.titleTextStyleprimarycolor,
                      ),
                    ),
                    ListTile(
                      title: TextField(
                        controller: _taskController,
                        decoration: InputDecoration(
                            hintText: 'Task Name',
                            hintStyle: AppStyles.weekDaysTextGreycolor),
                      ),
                    ),
                    ListTile(
                      trailing: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(); // Close the bottom sheet
                          _addTask(context, _taskController.text, selectedTime);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: AppColors.kprimaryColor,
                              borderRadius: BorderRadius.circular(29)),
                          child: Text(
                            'Add Task',
                            style: AppStyles.titleTextStylewhitecolor,
                          ),
                        ),
                      ),
                      leading: const Icon(
                        Icons.timer,
                        color: AppColors.kgrey,
                      ),
                      title: Text(
                        _formatTime(selectedTime),
                        style: AppStyles.weekDaysTextGreycolor,
                      ),
                      onTap: () async {
                        TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(selectedTime),
                        );

                        if (picked != null) {
                          selectedTime = DateTime(
                            selectedTime.year,
                            selectedTime.month,
                            selectedTime.day,
                            picked.hour,
                            picked.minute,
                          );
                        }
                      },
                    ),
                    const ReuseableGapWidget(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _formatTime(DateTime dateTime) {
    String period = dateTime.hour < 12 ? 'AM' : 'PM';
    int hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    String minute = '${dateTime.minute}'.padLeft(2, '0');
    return '$hour:$minute $period';
  }

  void _addTask(BuildContext context, String taskName, DateTime selectedTime) {
    if (taskName.isNotEmpty) {
      Provider.of<TodoProvider>(context, listen: false)
          .addTask(taskName, selectedTime);
      _taskController.clear();
    }
  }
}
