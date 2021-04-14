
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:wl_delivery/model/logic/cart.dart';

class HomeTabBarCubit extends BlocBase<int> {

  final cart = Get.find<Cart>();

  HomeTabBarCubit() : super(0) {
    cart.cartChangesStream.listen((_) => _updateState());
  }

  _updateState() {
    emit(cart.totalCount);
  }
}