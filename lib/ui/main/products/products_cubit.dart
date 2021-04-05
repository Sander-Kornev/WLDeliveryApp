
import 'dart:ffi';

import 'package:wl_delivery/model/api/APIManager/api_manager.dart';
import 'package:wl_delivery/model/api/APIRequest/requests/request+grocery.dart';
import 'package:wl_delivery/model/db/models/category.dart';
import 'package:wl_delivery/model/db/models/grocery_cafe.dart';
import 'package:wl_delivery/model/db/models/product.dart';
import 'package:wl_delivery/model/repository/grocery_repository.dart';
import 'package:wl_delivery/router/bloc_common/bloc_base.dart';
import 'package:get/get.dart';
import 'package:wl_delivery/ui/common/list_state.dart';
import 'package:wl_delivery/extensions/optional.dart';

class ProductsCubit extends BlocBaseObj<ListScreenState<Product>, Void> {

  final apiManager = Get.find<APIManager>();
  final groceryProvider = GroceryRepository();

  GroceryCafe grocery;
  Category parentCategory;

  ProductsCubit(this.grocery, this.parentCategory): super(ListScreenState.loading()) {
    _getDetails();
  }

  _getDetails() async {

    final dbObjects = await groceryProvider.getProducts(parentCategory.id);
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

      final objects = await groceryProvider.saveProducts(result, parentCategory.id);

      if (objects.isEmpty) {
        emit(ListScreenState.error("Sorry. No products available yet."));
      } else {
        emit(ListScreenState.loaded(objects));
      }

    } catch (err) {
      print(err.toString());
      if (dbObjects.orEmpty.isEmpty == true) {
        emit(ListScreenState.error("Sorry. Error occured."));
      }
    }
  }

}