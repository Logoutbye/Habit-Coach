import 'package:flutter/material.dart';
import 'package:healthy_routine/models/routine.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> tasks = [];

  void addTask(String taskName, DateTime time) {
    tasks.add(Todo(todoName: taskName, time: time));
    notifyListeners();
  }

  void clearTasks() {
    tasks.clear();
    notifyListeners(); // Notify listeners after clearing tasks
  }
}
