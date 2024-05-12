import 'package:flutter/material.dart';
import 'package:task_app/components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    super.key,
    required super.child,
  });

  final List<Task> tasksList = [
    Task('Aprender Flutter', 'assets/images/dash.png', 3),
    Task('Andar de Bike', 'assets/images/bike.webp', 2),
    Task('Meditar', 'assets/images/meditar.jpeg', 5),
    Task('Ler', 'assets/images/livro.jpg', 4),
    Task('Jogar', 'assets/images/jogar.jpg', 1),
  ];

  void newTask(String name, String photo, int difficulty) =>
      tasksList.add(Task(name, photo, difficulty));

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
