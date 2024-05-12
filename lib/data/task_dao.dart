import 'package:sqflite/sqflite.dart';
import 'package:task_app/components/task.dart';
import 'package:task_app/data/database.dart';

class TaskDao {
  static const String tableSql =
      'CREATE TABLE $_tableName($_name TEXT, $_difficulty INTEGER, $_image TEXT)';

  static const String _tableName = 'taskTable';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';

  save(Task task) async {
    final Database db = await getDatabase();
    await db.insert(_tableName,
        {_name: task.name, _image: task.image, _difficulty: task.difficulty});
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
    await db.delete(_tableName, where: 'name = ?', whereArgs: [taskName]);
  }

  List<Task> toTaskList(List<Map<String, dynamic>> mapTask) {
    final List<Task> taskList = [];

    for (Map<String, dynamic> row in mapTask) {
      taskList.add(Task(row[_name], row[_image], row[_difficulty]));
    }

    return taskList;
  }
}
