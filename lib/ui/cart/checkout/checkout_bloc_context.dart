
import 'package:flutter/material.dart';
import 'package:wl_delivery/router/bloc_common/bloc_base.dart';
import 'package:wl_delivery/router/bloc_common/bloc_context_base.dart';
import 'package:wl_delivery/router/router_delegate.dart';
import 'checkout_cubit.dart';

class CheckoutBlocContext extends BlocContextBase<CheckoutCubit> {

  AppRouterDelegate router;

  CheckoutBlocContext(this.router);

  @override
  void subscribe(CheckoutCubit bloc, BuildContext context) {
    bloc.outEvents.listen((BlocEvent<void> event) {
      // switch (event.type) {
      //   case LoginBlocEvent.signup:
      //     router.push(SignupPageConfig);
      //     break;
      //   default:
      //     assert(false, "Should never reach there");
      //     break;
      // }
    });
  }
}