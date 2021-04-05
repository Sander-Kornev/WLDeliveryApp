
import 'package:wl_delivery/model/db/models/sql_keys.dart';
import 'package:wl_delivery/model/db/models/sql_model_insertable.dart';

class Product extends SQLModelInsertable {

  String get tableName => tableProduct;
  static String get staticTableName => tableProduct;

  static String get createTable {
    return '''
      create table $tableProduct (
      $columnId int primary key,
      $columnTitle text,
      $columnImage text,
      $columnCategoryId int,
      $columnPrice double not null,
      FOREIGN KEY ($columnCategoryId) REFERENCES $tableCategory ($columnId) ON DELETE NO ACTION ON UPDATE NO ACTION)
      ''';
  }

  int id;
  int categoryId;
  String? title;
  String? image;
  double price;

  Map<String, Object?> get toMap {
    var map = <String, Object?>{
      columnId: id,
      columnTitle: title,
      columnImage: image,
      columnPrice: price
    };
    return map;
  }

  Product.fromMap(Map map):
        id = map[columnId] as int,
        categoryId = map[columnCategoryId] as int,
        price = map[columnPrice] as double {
    title = map[columnTitle] as String;
    image = map[columnImage] as String;
  }

  Product.withCategory(Map map, this.categoryId):
        id = map[columnId] as int,
        price = map[columnPrice] as double {

    title = map[columnTitle] as String;
    image = map[columnImage] as String;
  }
}