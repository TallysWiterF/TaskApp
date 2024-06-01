import 'package:flutter/material.dart';
import 'package:task_app/components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    super.key,
    required super.child,
  });

  final List<Task> tasksList = [];

  void newTask(
          String name, String image, int difficulty, int level, int mastery) =>
      tasksList.add(Task(name, image, difficulty, level, mastery));

  static TaskInherited? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskInherited>();
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result = maybeOf(context);
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) =>
      oldWidget.tasksList.length != tasksList.length;
}
