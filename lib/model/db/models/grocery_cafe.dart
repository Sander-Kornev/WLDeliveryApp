
import 'package:wl_delivery/model/db/models/sql_keys.dart';
import 'package:wl_delivery/model/db/models/sql_model_insertable.dart';

class GroceryCafe extends SQLModelInsertable {

  String get tableName => tableGrocery;
  static String get staticTableName => tableGrocery;

  static String get createTable {
    return '''
      create table $tableGrocery (
      $columnId int primary key,
      $columnTitle text,
      $columnDescription text,
      $columnImage text,
      $columnOpenTime text,
      $columnStatus text,
      $columnDeliveryPrice double not null)
      ''';
  }

  int id;
  String? title;
  String? description;
  String? image;
  String? openTime;
  String? status;
  double deliveryPrice;

  Map<String, Object?> get toMap {
    var map = <String, Object?>{
      columnId: id,
      columnTitle: title,
      columnDescription: description,
      columnImage: image,
      columnOpenTime: openTime,
      columnStatus: status,
      columnDeliveryPrice: deliveryPrice
    };
    return map;
  }

  GroceryCafe.fromMap(Map map):
        id = map[columnId] as int,
        deliveryPrice = map[columnDeliveryPrice] as double {

    title = map[columnTitle] as String;
    description = map[columnDescription] as String;
    image = map[columnImage] as String;
    openTime = map[columnOpenTime] as String;
    status = map[columnStatus] as String;
  }
}