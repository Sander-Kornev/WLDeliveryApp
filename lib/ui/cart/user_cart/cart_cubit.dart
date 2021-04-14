
import 'package:wl_delivery/model/db/models/grocery_cafe.dart';
import 'package:wl_delivery/model/db/models/product.dart';
import 'package:wl_delivery/model/logic/cart.dart';
import 'package:wl_delivery/router/bloc_common/bloc_base.dart';
import 'package:wl_delivery/extensions/double_extension.dart';
import 'package:get/get.dart';
import 'package:wl_delivery/ui/common/list_state.dart';

enum CartCubitEvent {
  checkout
}

class CartCubit extends BlocBaseObj<ListScreenState<ProductCount>, CartCubitEvent> {

  final cart = Get.find<Cart>();
  GroceryCafe? get grocery { return cart.currentShop; }

  String? get subtotal => cart.subtotalPrice.toCurrency;
  String? get deliveryFee => grocery?.deliveryPrice.toCurrency;
  String? get total => (cart.subtotalPrice + (grocery?.deliveryPrice ?? 0)).toCurrency;

  CartCubit(): super(ListScreenState.error('Cart is empty')) {

    cart.cartChangesStream.listen((_) => _updateState());
    _updateState();
  }

  add(Product product) {
    cart.change(action: CartAction.add(product), shop: grocery);
  }

  remove(Product product) {
    cart.change(action: CartAction.remove(product), shop: grocery);
  }

  removeAll(Product product) {
    cart.change(action: CartAction.removeAll(product), shop: grocery);
  }

  _updateState() {
    final objects = cart.products.entries.map((e) => ProductCount(e.key, e.value)).toList();
    if (objects.isNotEmpty) {
      emit(ListScreenState.loaded(objects));
    } else {
      emit(ListScreenState.error('Cart is empty'));
    }
  }

  checkoutAction() {
    inEvents.add(BlocEvent(type: CartCubitEvent.checkout));
  }
}