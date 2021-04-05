
import 'package:wl_delivery/model/db/models/sql_keys.dart';
import 'package:wl_delivery/model/db/models/sql_model_insertable.dart';

class Category extends SQLModelInsertable {

  String get tableName => tableCategory;
  static String get staticTableName => tableCategory;

  static String get createTable {
    return '''
      create table $tableCategory (
      $columnId int primary key,
      $columnGroceryId int not null,
      $columnHasSubcategories int not null,
      $columnTitle text,
      $columnImage text,
      $columnParentCategoryId int,
      FOREIGN KEY ($columnGroceryId) REFERENCES $tableGrocery ($columnId) ON DELETE NO ACTION ON UPDATE NO ACTION,
      FOREIGN KEY ($columnParentCategoryId) REFERENCES $tableCategory ($columnId) ON DELETE NO ACTION ON UPDATE NO ACTION)
      ''';
  }

  int id;
  String? title;
  String? image;
  int hasSubcategroies;

  int groceryId;
  int? parentCategoryId;


  Map<String, Object?> get toMap {
    var map = <String, Object?>{
      columnId: id,
      columnGroceryId: groceryId,
      columnParentCategoryId: parentCategoryId,
      columnTitle: title,
      columnImage: image,
      columnHasSubcategories: hasSubcategroies
    };
    return map;
  }

  Category.fromMap(Map map):
        id = map[columnId] as int,
        groceryId = map[columnGroceryId] as int,
        hasSubcategroies = map[columnHasSubcategories] as int {

    title = map[columnTitle] as String;
    image = map[columnImage] as String;
  }

  Category.withGrocery(Map map, this.groceryId, this.parentCategoryId):
        id = map[columnId] as int,
        hasSubcategroies = (map[columnHasSubcategories] as List).isNotEmpty ? 1 : 0 {

    title = map[columnTitle] as String;
    image = map[columnImage] as String;
  }
}