
import 'dart:ffi';

import 'package:wl_delivery/router/bloc_common/bloc_base.dart';
import 'package:wl_delivery/ui/cart/cart_state.dart';

class CartCubit extends BlocBaseObj<CartState, Void> {

  CartCubit() : super(CartState());

}