import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:to_do_app_mvvm/model/task_model.dart';
import 'package:to_do_app_mvvm/service/Repository/task_repository.dart';


class DbHelper implements TaskRepository {
  static const String taskList = 'tasks';

  static Future<void> createTable(sql.Database database) async {
    await database.execute('''CREATE TABLE $taskList(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT,
              description TEXT,
              date TEXT,
              time TEXT
            )''');
  }

 static Future<sql.Database> openDB() async{
  return sql.openDatabase(
    'tasks_db.db',
    version: 1,
    onCreate: (sql.Database database, int version) async{
      await createTable(database);
    }
  );
 }

  @override
  Future<List<Task>> getTasks() async {
    final db = await openDB();
    final List<Map<String, dynamic>> maps = await db.query(taskList);
    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  @override
  Future<void> insertTask(Task task) async {
    final db = await openDB();
    await db.insert(
      taskList,
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateTask(Task task) async {
    final db = await openDB();
    await db.update(
      taskList,
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  @override
  Future<void> deleteTask(int id) async {
    final db = await openDB();
    try{
       await db.delete(
      taskList,
      where: 'id = ?',
      whereArgs: [id],
    );
    }
   catch(error){
    debugPrint("Something went wrong while deleting a item : $error");
   }
  }
}
