import 'package:flutter/material.dart';
import 'app.dart';

void main() async {
  await initilizedApp();
  // List<String> task = [
  //   "Take her from home",
  //   "Book a cab",
  //   "Goto hospital and send me the report"
  // ];

  // String staticKey = "YourStaticKey"; // Set your desired static key

  // Map<String, List<String>> taskMap = {staticKey: task};

  // print("Task Map: $taskMap");
  runApp(const MyApp());
}
