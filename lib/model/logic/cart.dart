import 'dart:async';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:wl_delivery/model/db/models/grocery_cafe.dart';
import 'package:wl_delivery/model/db/models/product.dart';
import 'package:wl_delivery/extensions/optional.dart';
import 'package:wl_delivery/model/repository/auth_repository.dart';
import 'package:wl_delivery/model/repository/cart_repository.dart';

part 'cart.freezed.dart';

@freezed
class CartAction with _$CartAction {
  const factory CartAction.add(Product product) = Add;

  const factory CartAction.remove(Product product) = Remove;

  const factory CartAction.removeAll(Product product) = RemoveAll;
}

enum CartError {
  userIsNotAuthorized,
  shopHasToBeChanged
}

class Cart {

  // publishers
  StreamController<void> _cartChangesController = StreamController.broadcast();

  Stream<void> get cartChangesStream => _cartChangesController.stream;
  Sink<void> get _cartChangesSink => _cartChangesController.sink;

  GroceryCafe? currentShop;

  Map<Product, int> products = {};

  AuthRepository _authStore;
  CartRepository cartRepository;
  Cart(this._authStore, this.cartRepository) {
    _loadCart();
  }

  _loadCart() async {

    await cartRepository.init();

    if (cartRepository.isCartSaved) {
      currentShop = await cartRepository.savedGrocery;
      products = await cartRepository.savedProduct ?? {};
      _cartChangesSink.add('');
    }
  }

  change({action: CartAction, shop: GroceryCafe}) async {
    if (await _authStore.loggedInUser == null) {
      throw CartError.userIsNotAuthorized;
    }

    if (action is Add && (shop == currentShop || currentShop == null)) {
      var count = products[action.product];
      if (count != null) {
        products[action.product] = count + 1;
      } else {
        products[action.product] = 1;
        currentShop = shop;
      }
      _cartChangesSink.add('');
    } else if (action is Add) {
      throw CartError.shopHasToBeChanged;
    } else if (action is Remove) {
      var count = products[action.product];
      if (count != null && count > 1) {
        products[action.product] = count - 1;
      } else {
        products.remove(action.product);
      }
      if (products.isEmpty) {
        currentShop = null;
      }
      _cartChangesSink.add('');
    } else if (action is RemoveAll) {
      products.remove(action.product);
      if (products.isEmpty) {
        currentShop = null;
      }
      _cartChangesSink.add('');
    }

    cartRepository.save(products, currentShop);
  }

  clearCart() async {
    products.clear();
    currentShop = null;
    _cartChangesSink.add('');
    cartRepository.clear();
  }

// MARK: - GET

  int countFor(Product model) {
    return products[model] ?? 0;
  }

  int get totalCount {
    if (products.values.isNotEmpty) {
      return products.values.reduce((summ, el) => summ + el);
    } else {
      return 0;
    }
  }

  List<Product> get totalProducts {
    return products.keys.sortedBy((element) => element.title.orEmpty);
  }

  double get subtotalPrice {
    if (products.values.isNotEmpty) {
      return products.entries
          .map((e) => e.value * e.key.price)
          .reduce((summ, price) => summ + price);
    } else {
      return 0;
    }
  }

  void dispose() {
    _cartChangesController.close();
  }
}