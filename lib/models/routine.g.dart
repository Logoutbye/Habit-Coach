// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoutineAdapter extends TypeAdapter<Routine> {
  @override
  final int typeId = 1;

  @override
  Routine read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Routine(
      routineName: fields[0] as String,
      routineDescription: fields[1] as String,
      selectedOption: fields[2] as String,
      isSwitchOn: fields[3] as bool,
      selectedDays: (fields[4] as List).cast<String>(),
      todos: (fields[5] as List).cast<Todo>(),
      routineType: fields[6] as String,
      notificationIds: (fields[7] as List?)?.cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, Routine obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.routineName)
      ..writeByte(1)
      ..write(obj.routineDescription)
      ..writeByte(2)
      ..write(obj.selectedOption)
      ..writeByte(3)
      ..write(obj.isSwitchOn)
      ..writeByte(4)
      ..write(obj.selectedDays)
      ..writeByte(5)
      ..write(obj.todos)
      ..writeByte(6)
      ..write(obj.routineType)
      ..writeByte(7)
      ..write(obj.notificationIds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoutineAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TodoAdapter extends TypeAdapter<Todo> {
  @override
  final int typeId = 0;

  @override
  Todo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Todo(
      todoName: fields[0] as String,
      time: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Todo obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.todoName)
      ..writeByte(1)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
