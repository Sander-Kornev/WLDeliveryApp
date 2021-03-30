
final String tableProduct = 'product';
final String tableGrocery = 'grocery';

final String columnId = '_id';
final String columnTitle = 'title';
final String columnDescription = 'description';
final String columnImage = 'image';
final String columnPrice = 'price';
final String columnOpenTime = 'openTime';
final String columnStatus = 'status';

class GroceryCafe {

  late int id;
  String? title;
  String? description;
  String? image;
  String? openTime;
  String? status;
  late double deliveryPrice;

  // var categories: [CategoryModel]?

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnId: id,
      columnTitle: title,
      columnDescription: description,
      columnImage: image,
      columnOpenTime: openTime,
      columnStatus: status,
      columnPrice: deliveryPrice
    };
    return map;
  }

  GroceryCafe.fromMap(Map map) {
    id = map[columnId] as int? ?? 0;
    deliveryPrice = map[columnPrice] as double? ?? 0;
    title = map[columnTitle] as String;
    description = map[columnDescription] as String;
    image = map[columnImage] as String;
    openTime = map[columnOpenTime] as String;
    status = map[columnStatus] as String;
  }
}

class Category {
  late int id;
  String? title;
  String? image;
  // List<ProductModel>? productList;
  // List<CategoryModel>? subCategories;
}

class ProductModel {
  late int id;
  String? title;
  String? image;
  late double price;

  ProductModel(this.id, this.title, this.image, this.price);

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnId: id,
      columnTitle: title,
      columnImage: image,
      columnPrice: price
    };
    return map;
  }

  ProductModel.fromMap(Map<String, Object?> map) {
    id = map[columnId] as int? ?? 0;
    price = map[columnPrice] as double? ?? 0;
    title = map[columnTitle] as String;
    image = map[columnImage] as String;
  }
}

class CategoryModel {
  int id;
  String title;
  String? image;
  List<ProductModel>? productList;
  List<CategoryModel>? subCategories;

  CategoryModel(this.id, this.title, this.image, this.productList, this.subCategories);
}