
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wl_delivery/model/db/db_provider.dart';
import 'package:wl_delivery/model/db/models/category.dart';
import 'package:wl_delivery/model/db/models/grocery_cafe.dart';
import 'package:wl_delivery/model/db/models/product.dart';
import 'package:wl_delivery/model/db/models/sql_keys.dart';
import 'package:wl_delivery/extensions/optional.dart';

class GroceryRepository {

  final dbProvider = Get.find<DBProvider>();

  /// Get groceries.
  Future<List<GroceryCafe>?> getAllGroceries() async {
    return await dbProvider.getAllGroceries();
  }

  Future<GroceryCafe?> getGrocery(int id) async {
    return await dbProvider.findById(id, GroceryCafe.staticTableName, (x) => GroceryCafe.fromMap(x));
  }


  Future<List<Category>?> getCategories(int groceryId, [int? parentCategoryId]) async {
    return await dbProvider.getCategories(groceryId, parentCategoryId);
  }

  Future<List<Product>?> getProducts(int categoryId) async {
    return await dbProvider.getProducts(categoryId);
  }

  Future<List<GroceryCafe>> saveGroceries(Map map) async {

    final cafes = (map['results'] as List<dynamic>)
        .map((e) => GroceryCafe.fromMap(e))
        .toList();
    await dbProvider.replaceGroceries(cafes);

    return cafes;
  }

  Future<List<Category>> saveCategories(Map map) async {

    final groceryId = map['id'] as int;

    final batch = dbProvider.db.batch();
    await dbProvider.deleteAllCategories(groceryId, batch);

    final objects = (map['categories'] as List<dynamic>)
        .map((e) => _saveCategory(e, groceryId, null, batch))
        .toList();

    await batch.commit();
    return objects;
  }

  Category _saveCategory(Map map, int groceryId, int? parentCategoryId, Batch batch) {

    final localParentCategoryId = map['id'] as int;

    final category = Category.withGrocery(map, groceryId, parentCategoryId);
    batch.insertObject(category);

    List<Category> categories = (map[columnHasSubcategories] as List<dynamic>)
        .map((e) => _saveCategory(e, groceryId, localParentCategoryId, batch))
        .toList();
    batch.insertObjects(categories);

    return category;
  }

  Future<List<Product>> saveProducts(Map map, int categoryId) async {

    final batch = dbProvider.db.batch();
    await dbProvider.deleteAllProducts(categoryId, batch);

    final objects = (map['results'] as List<dynamic>)
        .orEmpty
        .map((e) => Product.withCategory(e, categoryId))
        .toList();
    batch.insertObjects(objects);

    await batch.commit();
    return objects;
  }

  Future<Product?> getProduct(int id) async {
    return await dbProvider.findById(id, Product.staticTableName, (x) => Product.fromMap(x));
  }
}