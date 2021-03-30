
import 'dart:ffi';

import 'package:wl_delivery/model/api/APIManager/api_manager.dart';
import 'package:wl_delivery/model/api/APIRequest/requests/request+grocery.dart';
import 'package:wl_delivery/model/db/db_provider.dart';
import 'package:wl_delivery/model/db/models/grocery_cafe.dart';
import 'package:wl_delivery/router/bloc_common/bloc_base.dart';
import 'package:get/get.dart';
import 'main_state.dart';

class MainCubit extends BlocBaseObj<MainScreenState, Void> {

  final apiManager = Get.find<APIManager>();
  final dbProvider = Get.find<DBProvider>();

  MainCubit(): super(MainScreenState.loading()) {
    getEstablishments();
  }

  getEstablishments() async {
    try {
      inLoadingEvents.add(true);
      final request = EstablishmentAPI.getEstablishments;
      final result = await apiManager.performRequest(request);
      print(result);

      final caffees = result['results'] as List<dynamic>;
      for (var i = 0; i < caffees.length; i++) {
        final cafeeObject = GroceryCafe.fromMap(caffees[i]);
        await dbProvider.insert(cafeeObject);
      }

      final data = await dbProvider.getAllGroceries();
      print(data!.map((e) => e.title).toList());

      inLoadingEvents.add(false);
    } catch (err) {
      print(err.toString());
      inLoadingEvents.add(false);
      inMessageEvents.add('Error occured');
    }
  }

}