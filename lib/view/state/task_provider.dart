import 'package:flutter/material.dart';

// class TaskProvider extends ChangeNotifier {
//   List<String> tasks = [];

//   void addTask(String task) {
//     tasks.add(task);
//     notifyListeners();
//   }
// }


class Task {
  String taskName;
  DateTime time;

  Task({required this.taskName, required this.time});
}

class TaskProvider extends ChangeNotifier {
  List<Task> tasks = [];

  void addTask(String taskName, DateTime time) {
    tasks.add(Task(taskName: taskName, time: time));
    notifyListeners();
  }
}