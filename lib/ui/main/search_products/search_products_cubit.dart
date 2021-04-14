
import 'package:wl_delivery/model/api/APIManager/api_manager.dart';
import 'package:wl_delivery/model/api/APIRequest/requests/request+grocery.dart';
import 'package:wl_delivery/model/db/models/grocery_cafe.dart';
import 'package:wl_delivery/model/db/models/product.dart';
import 'package:wl_delivery/model/logic/cart.dart';
import 'package:wl_delivery/model/repository/grocery_repository.dart';
import 'package:wl_delivery/router/bloc_common/bloc_base.dart';
import 'package:get/get.dart';
import 'package:wl_delivery/ui/common/list_state.dart';
import 'package:wl_delivery/extensions/optional.dart';

class SearchProductsCubit extends BlocBaseObj<ListScreenState<ProductCount>, void> {

  final apiManager = Get.find<APIManager>();
  final cart = Get.find<Cart>();
  final groceryProvider = GroceryRepository();

  GroceryCafe grocery;
  String searchQuery = '';

  List<Product>? _products;

  SearchProductsCubit(this.grocery, [String? query]): super(ListScreenState.loading()) {
    if (query?.isNotEmpty == true) {
      updateSearch(query!);
    }
  }

  updateSearch(String query) async {

    print('SearchProductsCubit: update $query');
    searchQuery = query;

    try {
      final request = EstablishmentAPI.searchProducts(grocery.id, searchQuery);
      final result = await apiManager.performRequest(request);
      print(result);

      _products = (result['results'] as List<dynamic>)
          .orEmpty
          .map((e) => Product.withCategory(e, 0))
          .toList();
      final objects = _products?.map((e) => ProductCount(e, cart.countFor(e))).toList();

      if (objects?.isEmpty == false) {
        emit(ListScreenState.loaded(objects!));
      } else {
        emit(ListScreenState.error("Sorry. No products available yet."));
      }

    } catch (err) {
      print(err.toString());
      emit(ListScreenState.error("Sorry. Error occured."));
    }
  }

  Future<ListScreenState<ProductCount>> searchResultFuture(String query) async {

    print('SearchProductsCubit: update $query');
    searchQuery = query;

    try {
      final request = EstablishmentAPI.searchProducts(grocery.id, searchQuery);
      final result = await apiManager.performRequest(request);
      print(result);

      _products = (result['results'] as List<dynamic>)
          .orEmpty
          .map((e) => Product.withCategory(e, 0))
          .toList();
      final objects = _products?.map((e) => ProductCount(e, cart.countFor(e))).toList();

      if (objects?.isEmpty == false) {
        return ListScreenState.loaded(objects!);
      } else {
        return ListScreenState.error("Sorry. No products available yet.");
      }

    } catch (err) {
      print(err.toString());
      return ListScreenState.error("Sorry. Error occured.");
    }
  }

  ListScreenState<ProductCount> add(Product product) {
    cart.change(action: CartAction.add(product), shop: grocery);
    return _updateState();
  }

  ListScreenState<ProductCount> remove(Product product) {
    cart.change(action: CartAction.remove(product), shop: grocery);
    return _updateState();
  }

  ListScreenState<ProductCount> _updateState() {
    final objects = _products?.map((e) => ProductCount(e, cart.countFor(e))).toList();
    return ListScreenState.loaded(objects!);
  }

}