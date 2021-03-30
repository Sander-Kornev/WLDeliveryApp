
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:wl_delivery/router/bloc_common/bloc_base.dart';
import 'package:wl_delivery/router/bloc_common/bloc_context_base.dart';
import 'package:wl_delivery/router/router_delegate.dart';
import 'package:wl_delivery/ui/orders/orders_cubit.dart';

class OrdersBlocContext extends BlocContextBase<OrdersCubit> {

  AppRouterDelegate router;

  OrdersBlocContext(this.router);

  @override
  void subscribe(OrdersCubit bloc, BuildContext context) {
    bloc.outEvents.listen((BlocEvent<Void> event) {
      switch (event.type) {
      //   case LoginBlocEvent.signup:
      //     router.push(SignupPageConfig);
      //     break;
      //   default:
      //     assert(false, "Should never reach there");
      //     break;
      }
    });
  }
}