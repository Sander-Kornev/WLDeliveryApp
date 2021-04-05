
import 'package:wl_delivery/model/api/APIManager/api_manager.dart';
import 'package:wl_delivery/model/api/APIRequest/requests/request+grocery.dart';
import 'package:wl_delivery/model/db/models/category.dart';
import 'package:wl_delivery/model/db/models/grocery_cafe.dart';
import 'package:wl_delivery/model/repository/grocery_repository.dart';
import 'package:wl_delivery/router/bloc_common/bloc_base.dart';
import 'package:get/get.dart';
import 'package:wl_delivery/ui/common/list_state.dart';

enum CategoriesBlocEvent {
  openSubcategory,
  openProducts
}

class CategoriesCubit extends BlocBaseObj<ListScreenState<Category>, CategoriesBlocEvent> {

  final apiManager = Get.find<APIManager>();
  final groceryProvider = GroceryRepository();

  GroceryCafe grocery;
  Category? parentCategory;
  
  CategoriesCubit(this.grocery, this.parentCategory): super(ListScreenState.loading()) {
    _getDetails();
  }

  _getDetails() async {

    final dbObjects = await groceryProvider.getCategories(grocery.id, parentCategory?.id);
    if (dbObjects?.isEmpty == false) {
      emit(ListScreenState.loaded(dbObjects!));
    } else {
      emit(ListScreenState.loading());
    }

    // return;

    if (parentCategory != null) {
      return;
    }

    try {
      final request = EstablishmentAPI.getEstablishmentDetails(grocery.id);
      final result = await apiManager.performRequest(request);
      print(result);

      final objects = await groceryProvider.saveCategories(result);

      if (objects.isEmpty) {
        emit(ListScreenState.error("Sorry. No catgories available yet."));
      } else {
        emit(ListScreenState.loaded(objects));
      }

    } catch (err) {
      print(err.toString());
      if (dbObjects?.isEmpty == true) {
        emit(ListScreenState.error("Sorry. Error occured."));
      }
    }
  }

  openDetals(Category category) {
    if (category.hasSubcategroies == 1) {
      inEvents.add(BlocEvent(type: CategoriesBlocEvent.openSubcategory,
          parameters: {
            GroceryCafe.staticTableName: grocery,
            Category.staticTableName: category
          }));
    } else {
      inEvents.add(BlocEvent(type: CategoriesBlocEvent.openProducts,
          parameters: {
            GroceryCafe.staticTableName: grocery,
            Category.staticTableName: category
          }));
    }
  }

}