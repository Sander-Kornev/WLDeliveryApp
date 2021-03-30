
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:wl_delivery/router/bloc_common/bloc_base.dart';
import 'package:wl_delivery/router/bloc_common/bloc_context_base.dart';
import 'package:wl_delivery/router/router_delegate.dart';
import 'main_cubit.dart';

class MainBlocContext extends BlocContextBase<MainCubit> {

  AppRouterDelegate router;

  MainBlocContext(this.router);

  @override
  void subscribe(MainCubit bloc, BuildContext context) {
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
