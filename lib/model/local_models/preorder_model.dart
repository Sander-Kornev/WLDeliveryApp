
import 'package:wl_delivery/model/db/models/grocery_cafe.dart';
import 'package:wl_delivery/model/db/models/product.dart';
import 'package:wl_delivery/extensions/optional.dart';

import 'destination.dart';

class PreorderModel {
  GroceryCafe establishment;
  Map<Product, int> products;
  double subtotalPrice;
  double deliveryPrice;
  Destination? destination;
  String contact;

  PreorderModel({
    required this.establishment,
    required this.products,
    required this.subtotalPrice,
    required this.deliveryPrice,
    required this.destination,
    required this.contact,
  });

  Map<String, dynamic> get apiJSON {

    var productsInfo = List<Map<String, dynamic>>.empty(growable: true);
    for (final tuple in products.entries) {
      productsInfo.add({
            "id": tuple.key.id,
            "quantity": tuple.value
          });
    }

    return {
      "delivery_price": deliveryPrice,
      "subtotal_price": subtotalPrice,
      "products": productsInfo,
      "address": destination?.apiJSON,
      "contact_number": contact.orEmpty,
      "payment_method": "in_cash",
      "establishment": establishment.id
    };
  }
}