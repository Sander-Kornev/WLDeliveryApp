
import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:wl_delivery/model/db/models/grocery_cafe.dart';

import 'package:path/path.dart';

class DBProvider {
  /// The database when opened.
  late Database db;

  /// Open the database.
  Future open(String path) async {
    db = await openDatabase(path, version: 2, onCreate: (Database db, int version) async {
      await db.execute('''
  create table $tableGrocery ( 
  $columnId integer primary key, 
  $columnTitle text,
  $columnDescription text,
  $columnImage text,
  $columnOpenTime text,
  $columnStatus text,
  $columnPrice double not null)
''');
    });
  }

  /// Insert a grocery.
  Future<GroceryCafe> insert(GroceryCafe grocery) async {
    await db.insert(tableGrocery, grocery.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return grocery;
  }

  /// Get groceries.
  Future<List<GroceryCafe>?> getAllGroceries() async {
    List<Map> maps = await db.query(tableGrocery,
        columns: [columnId, columnTitle, columnDescription],
        // where: '$columnId = ?',
        // whereArgs: [id]
    );
    if (maps.isNotEmpty) {
      return maps.map((info) => GroceryCafe.fromMap(info)).toList();
    }
    return null;
  }

  // /// Delete a todo.
  // Future<int> delete(int id) async {
  //   return await db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
  // }
  //
  // /// Update a todo.
  // Future<int> update(Todo todo) async {
  //   return await db.update(tableTodo, todo.toMap(),
  //       where: '$columnId = ?', whereArgs: [todo.id!]);
  // }

  /// Close database.
  Future close() async => db.close();


  /// create the folder and returns its path
  static Future<String> initDB(String dbName) async {
    final databasePath = await getDatabasesPath();
    // print(databasePath);
    final path = join(databasePath, dbName);

    // make sure the folder exists
    if (await Directory(dirname(path)).exists() == false) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (e) {
        print(e);
      }
    }
    return path;
  }
}