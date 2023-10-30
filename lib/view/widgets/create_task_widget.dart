import 'package:flutter/material.dart';
import 'package:healthy_routine/core/app_styles.dart';
import 'package:healthy_routine/core/components/reuseable_gap_widget.dart';
import 'package:healthy_routine/view/state/task_provider.dart';
import 'package:provider/provider.dart';

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
            child: const Row(
              children: [
                Icon(Icons.add_circle_outline),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'To-do',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        Consumer<TaskProvider>(
          builder: (context, taskProvider, child) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: taskProvider.tasks.length,
              itemBuilder: (context, index) {
                Task task = taskProvider.tasks[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: AppStyles.KContainerStyle,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${index + 1}. ${task.taskName}',
                        ),
                        Text(
                          'Time: ${_formatTime(task.time)}',
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
                    const ListTile(
                      title: Text('Enter Task Name'),
                    ),
                    ListTile(
                      title: TextField(
                        controller: _taskController,
                        decoration: const InputDecoration(
                          hintText: 'Task Name',
                        ),
                      ),
                    ),
                    ListTile(
                      trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the bottom sheet
                          _addTask(context, _taskController.text, selectedTime);
                        },
                        child: const Text('Add Task'),
                      ),
                      leading: const Icon(Icons.timer),
                      title: Text(
                        _formatTime(selectedTime),
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
      Provider.of<TaskProvider>(context, listen: false)
          .addTask(taskName, selectedTime);
      _taskController.clear();
    }
  }
}
