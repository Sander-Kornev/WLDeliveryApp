
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:wl_delivery/model/api/APIManager/api_manager.dart';
import 'package:wl_delivery/model/api/APIRequest/requests/request+grocery.dart';
import 'package:wl_delivery/model/db/models/category.dart';
import 'package:wl_delivery/model/db/models/grocery_cafe.dart';
import 'package:wl_delivery/model/db/models/product.dart';
import 'package:wl_delivery/model/logic/cart.dart';
import 'package:wl_delivery/model/repository/grocery_repository.dart';
import 'package:wl_delivery/router/bloc_common/bloc_base.dart';
import 'package:get/get.dart';
import 'package:wl_delivery/router/bloc_common/bloc_context_base.dart';
import 'package:wl_delivery/ui/common/list_state.dart';
import 'package:wl_delivery/extensions/optional.dart';

enum ProductsBlocAction {
  search,
  login
}

class ProductsCubit extends BlocBaseObj<ListScreenState<ProductCount>, ProductsBlocAction> {

  final apiManager = Get.find<APIManager>();
  final cart = Get.find<Cart>();
  final groceryProvider = GroceryRepository();

  GroceryCafe grocery;
  Category parentCategory;

  List<Product>? _products;

  ProductsCubit(this.grocery, this.parentCategory): super(ListScreenState.loading()) {
    _getDetails();

    cart.cartChangesStream.listen((_) => _updateState());
  }

  _getDetails() async {

    _products = await groceryProvider.getProducts(parentCategory.id);
    final dbObjects = _products?.map((e) => ProductCount(e, cart.countFor(e))).toList();
    if (dbObjects?.isEmpty == false) {
      emit(ListScreenState.loaded(dbObjects!));
    } else {
      emit(ListScreenState.loading());
    }

    // return;

    try {
      final request = EstablishmentAPI.getProducts(parentCategory.id);
      final result = await apiManager.performRequest(request);
      print(result);

      _products = await groceryProvider.saveProducts(result, parentCategory.id);
      final objects = _products?.map((e) => ProductCount(e, cart.countFor(e))).toList();

      if (objects?.isEmpty == false) {
        emit(ListScreenState.loaded(objects!));
      } else {
        emit(ListScreenState.error("Sorry. No products available yet."));
      }

    } catch (err) {
      print(err.toString());
      if (dbObjects.orEmpty.isEmpty == true) {
        emit(ListScreenState.error("Sorry. Error occured."));
      }
    }
  }

  search() {
    inEvents.add(
        BlocEvent(type: ProductsBlocAction.search, parameters: {GroceryCafe.staticTableName: grocery})
    );
  }

  add(Product product) {
    _cartAction(CartAction.add(product));
  }

  remove(Product product) {
    _cartAction(CartAction.remove(product));
  }

  _cartAction(CartAction action) async {
    try {
      await cart.change(action: action, shop: grocery);
    } catch (err) {
      switch (err as CartError) {
        case CartError.shopHasToBeChanged:
          List<AlertDialogAction<bool>> actions = [
            AlertDialogAction(key: true, label: 'New Cart', isDestructiveAction: true),
            AlertDialogAction(key: false, label: 'Cancel')
          ];
          inMessageAlertEvents.add(
              MessageAlert<bool>(
                  'Start new cart?',
                  'You already have some items in the cart from a different store. Would you like to clear the cart and add these items?',
                  actions,
                  _clearCart
              )
          );
          break;
        case CartError.userIsNotAuthorized:
          List<AlertDialogAction<bool>> actions = [
            AlertDialogAction(key: true, label: 'Login', isDefaultAction: true),
            AlertDialogAction(key: false, label: 'Cancel')
          ];
          inMessageAlertEvents.add(
              MessageAlert<bool>(
                  'Guest',
                  'Please, login to continue',
                  actions,
                  _login
              )
          );
          break;
      }
    }
  }

  _updateState() {
    final objects = _products?.map((e) => ProductCount(e, cart.countFor(e))).toList();
    emit(ListScreenState.loaded(objects!));
  }

  _clearCart(dynamic value) {
    if ((value is bool) && value) {
      cart.clearCart();
    }
  }

  _login(dynamic value) {
    if ((value is bool) && value) {
      inEvents.add(BlocEvent(type: ProductsBlocAction.login));
    }
  }
}