
import 'package:flutter/material.dart';
import 'package:wl_delivery/router/bloc_common/bloc_base.dart';
import 'package:wl_delivery/router/bloc_common/bloc_context_base.dart';
import 'package:wl_delivery/router/router_delegate.dart';
import 'package:wl_delivery/router/ui_pages.dart';
import 'cart_cubit.dart';

class CartBlocContext extends BlocContextBase<CartCubit> {

  AppRouterDelegate router;

  CartBlocContext(this.router);

  @override
  void subscribe(CartCubit bloc, BuildContext context) {
    bloc.outEvents.listen((BlocEvent<CartCubitEvent> event) {
      switch (event.type) {
        case CartCubitEvent.checkout:
          router.push(CheckoutPageConfig);
          break;
        default:
          assert(false, "Should never reach there");
          break;
      }
    });
  }
}