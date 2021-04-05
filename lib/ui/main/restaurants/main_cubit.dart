
import 'package:wl_delivery/model/api/APIManager/api_manager.dart';
import 'package:wl_delivery/model/api/APIRequest/requests/request+grocery.dart';
import 'package:wl_delivery/model/db/models/grocery_cafe.dart';
import 'package:wl_delivery/model/db/models/sql_keys.dart';
import 'package:wl_delivery/model/repository/grocery_repository.dart';
import 'package:wl_delivery/router/bloc_common/bloc_base.dart';
import 'package:get/get.dart';
import 'package:wl_delivery/ui/common/list_state.dart';



class MainCubit extends BlocBaseObj<ListScreenState<GroceryCafe>, ListBlocEvent> {

  final apiManager = Get.find<APIManager>();
  final groceryProvider = GroceryRepository();

  MainCubit(): super(ListScreenState.loading()) {
    _getEstablishments();
  }

  _getEstablishments() async {

    final dbCafes = await groceryProvider.getAllGroceries();
    if (dbCafes?.isEmpty == false) {
      emit(ListScreenState.loaded(dbCafes!));
    } else {
      emit(ListScreenState.loading());
    }
    // return;

    try {
      final request = EstablishmentAPI.getEstablishments;
      final result = await apiManager.performRequest(request);
      print(result);

      final cafes = await groceryProvider.saveGroceries(result);

      if (cafes.isEmpty) {
        emit(ListScreenState.error("Sorry. No restaurants available yet."));
      } else {
        emit(ListScreenState.loaded(cafes));
      }

    } catch (err) {
      print(err.toString());
      if (dbCafes?.isEmpty == true) {
        emit(ListScreenState.error("Sorry. Error occured."));
      }
    }
  }

  openCategories(GroceryCafe cafe) {
    inEvents.add(BlocEvent(type: ListBlocEvent.openDetails,
      parameters: {
        tableGrocery: cafe
      }));
  }

}