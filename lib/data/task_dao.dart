import 'package:sqflite/sqflite.dart';
import 'package:task_app/components/task.dart';
import 'package:task_app/data/database.dart';

class TaskDao {
  static const String tableSql =
      'CREATE TABLE $_tableName($_name TEXT, $_difficulty INTEGER, $_image TEXT, $_level INTEGER, $_mastery INTEGER)';

  static const String _tableName = 'taskTable';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';
  static const String _level = 'level';
  static const String _mastery = 'mastery';

  save(Task task) async {
    final Database db = await getDatabase();
    var itemExists = await find(task.name);
    Map<String, dynamic> taskMap = toTaskMap(task);

    if (itemExists.isEmpty) {
      return await db.insert(_tableName, taskMap);
    }

    return await db.update(_tableName, taskMap,
        where: '$_name = ?', whereArgs: [task.name]);
  }

  Future<List<Task>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> mapTask = await db.query(_tableName);
    return toTaskList(mapTask);
  }

  Future<List<Task>> find(String taskName) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> mapTask = await db
        .query(_tableName, where: '$_name LIKE ?', whereArgs: [taskName]);
    return toTaskList(mapTask);
  }

  delete(String taskName) async {
    final Database db = await getDatabase();
    await db.delete(_tableName, where: '$_name = ?', whereArgs: [taskName]);
  }

  List<Task> toTaskList(List<Map<String, dynamic>> mapTask) {
    final List<Task> taskList = [];

    for (Map<String, dynamic> row in mapTask) {
      taskList.add(Task(row[_name], row[_image], row[_difficulty], row[_level],
          row[_mastery]));
    }

    return taskList;
  }

  Map<String, dynamic> toTaskMap(Task task) {
    final Map<String, dynamic> taskMap = {};

    taskMap[_name] = task.name;
    taskMap[_image] = task.image;
    taskMap[_difficulty] = task.difficulty;
    taskMap[_level] = task.level;
    taskMap[_mastery] = task.mastery;

    return taskMap;
  }
}
