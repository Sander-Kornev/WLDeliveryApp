
import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:wl_delivery/model/db/models/grocery_cafe.dart';

import 'package:path/path.dart';
import 'package:wl_delivery/model/db/models/sql_model_insertable.dart';

import 'models/category.dart';
import 'models/product.dart';
import 'models/sql_keys.dart';

class DBProvider {
  /// The database when opened.
  late Database db;

  /// create the folder and returns its path
  static Future<String> initDB(String dbName) async {
    final databasePath = await getDatabasesPath();
    // print(databasePath);
    final path = join(databasePath, dbName);

    // make sure the folder exists
    // await Directory(dirname(path)).delete(recursive: true);
    if (await Directory(dirname(path)).exists() == false) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (e) {
        print(e);
      }
    }
    return path;
  }

  /// Open the database.
  Future open(String path) async {
    db = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {

      await db.execute(GroceryCafe.createTable);
      await db.execute(Category.createTable);
      await db.execute(Product.createTable);
    });
  }

  /// Get groceries.
  Future<List<GroceryCafe>?> getAllGroceries() async {
    List<Map> maps = await db.query(GroceryCafe.staticTableName);
    if (maps.isNotEmpty) {
      return maps.map((info) => GroceryCafe.fromMap(info)).toList();
    }
    return null;
  }

  Future<List<Category>?> getCategories(int groceryId, [int? parentCategoryId]) async {
    List<Map>? maps;
    if (parentCategoryId != null) {
      maps = await db.query(
          Category.staticTableName, where: '$columnGroceryId = ? AND $columnParentCategoryId = ?', whereArgs: [groceryId, parentCategoryId]);
    } else {
      maps = await db.query(
          Category.staticTableName, where: '$columnGroceryId = ? AND $columnParentCategoryId IS NULL', whereArgs: [groceryId]);
    }
    if (maps.isNotEmpty) {
      return maps.map((info) => Category.fromMap(info)).toList();
    }
    return null;
  }

  Future<List<Product>?> getProducts(int categoryId) async {
    List<Map>? maps = await db.query(
          Product.staticTableName, where: '$columnCategoryId = ?', whereArgs: [categoryId]);
    if (maps.isNotEmpty) {
      return maps.map((info) => Product.fromMap(info)).toList();
    }
    return null;
  }

  deleteAllCategories(int groceryId, Batch batch) async {
    batch.delete(Category.staticTableName, where: '$columnGroceryId = ?',
          whereArgs: [groceryId]);
  }

  deleteAllProducts(int categoryId, Batch batch) async {
    batch.delete(Product.staticTableName, where: '$columnCategoryId = ?',
          whereArgs: [categoryId]);
  }

  /// Close database.
  Future close() async => db.close();

  replaceGroceries(List<GroceryCafe> list) async {
    final batch = db.batch();

    batch.delete(GroceryCafe.staticTableName);
    batch.insertObjects(list);

    await batch.commit();
  }
}

extension BatchExtension on Batch {
  insertObject<T extends SQLModelInsertable>(T object) {
    this.insert(object.tableName, object.toMap, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  insertObjects<T extends SQLModelInsertable>(List<T> list) {
    for (final elem in list) {
      this.insertObject(elem);
    }
  }
}