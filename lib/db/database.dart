import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class DBhelper {
  static Database? _database;
  static final int _version = 1;
  static final String _tableName = 'tasks';

  static Future<void> initDb() async {
    if (_database != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'tasks.db';
      _database =
          await openDatabase(_path, version: _version, onCreate: (db, version) {
        print('creating a new one ');
        return db.execute(
          "CREATE TABLE $_tableName("
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "title STRING,note TEXT , date STRING, "
          "startTime STRING, endTime STRING, "
          "remind INTEGER, repeat STRING, "
          "color INTEGER, "
          "isCompleted INTEGER)",
        );
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(Task? task) async {
    print("insert function called");
    return await _database?.insert(_tableName, task!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print("query function called");
    return await _database!.query(_tableName);
  }

  static delete(Task task) async {
    await _database!.delete(_tableName, where: "id= ?", whereArgs: [task.id]);
  }

  static update(int? id) async {
    await _database!.rawUpdate('''
      UPDATE tasks
      SET isCOMPLETED = ?
      WHERE id=?
    ''', [1, id]);
  }
}
