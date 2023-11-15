// routine_model.dart
import 'package:hive/hive.dart';

part 'routine.g.dart';

@HiveType(typeId: 1)
class Routine {
  @HiveField(0)
  String routineName;

  @HiveField(1)
  String routineDescription;

  @HiveField(2)
  String selectedOption; // Time of the day

  @HiveField(3)
  bool isSwitchOn; // Reminder

  @HiveField(4)
  List<String> selectedDays;

  @HiveField(5)
  List<Todo> todos;

  @HiveField(6)
  String routineType;

  @HiveField(7)
  List<int>? notificationIds; // Add this field

  Routine({
    required this.routineName,
    required this.routineDescription,
    required this.selectedOption,
    required this.isSwitchOn,
    required this.selectedDays,
    required this.todos,
    required this.routineType,
    List<int>? notificationIds, // Remove initialization from here
  }) : notificationIds =
            notificationIds ?? []; // Initialize with an empty list if null
}

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  String todoName;

  @HiveField(1)
  DateTime time; // Time for the todo

  Todo({required this.todoName, required this.time});
}
