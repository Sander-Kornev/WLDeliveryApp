
import 'package:hive/hive.dart';
import 'package:wl_delivery/model/db/models/grocery_cafe.dart';
import 'package:wl_delivery/model/db/models/product.dart';
import 'package:wl_delivery/model/repository/grocery_repository.dart';

part 'cart_repository.g.dart';

const String boxName = "cart";

class CartRepository {

  final groceryProvider = GroceryRepository();

  init() async {
    Hive.registerAdapter(CartObjectAdapter());
    await Hive.openBox<CartObject>(boxName);
  }

  Box<CartObject> get box => Hive.box<CartObject>(boxName);
  bool get isCartSaved => box.isEmpty == false;

  Future<GroceryCafe?> get savedGrocery async {
    if (box.isEmpty) {
      return null;
    }
    final groceryId = box.values.first.groceryId;
    return await groceryProvider.getGrocery(groceryId);
  }

  Future<Map<Product, int>?> get savedProduct async {
    if (box.isEmpty) {
      return null;
    }

    var map = Map<Product, int>();
    await Future.forEach<CartObject>(box.values, (elem) async {
      final product = await groceryProvider.getProduct(elem.productId);
      if (product != null) {
        map[product] = elem.productCount;
      }
    });
    print(map);
    return map;
  }

  save(Map<Product, int> products, GroceryCafe? grocery) async {
    await clear();
    if (grocery != null) {
      for (final entry in products.entries) {
        final obj = CartObject(
            groceryId: grocery.id, productId: entry.key.id, productCount: entry.value);
        await box.add(obj);
        await obj.save();
      }
    }
  }

  clear() async {
    await box.clear();
  }

}

@HiveType(typeId: 1)
class CartObject extends HiveObject {

  CartObject({required this.groceryId, required this.productId, required this.productCount});

  @HiveField(0)
  int groceryId;

  @HiveField(1)
  int productId;

  @HiveField(2)
  int productCount;
}