import 'package:flutter/material.dart';
import 'package:wl_delivery/router/bloc_common/bloc_base.dart';
import 'package:wl_delivery/router/bloc_common/bloc_context_base.dart';
import 'package:wl_delivery/router/router_delegate.dart';
import 'package:wl_delivery/router/ui_pages.dart';
import 'package:wl_delivery/ui/login/login_cubit.dart';

class LoginBlocContext extends BlocContextBase<LoginCubit> {

  AppRouterDelegate router;
  LoginBlocContext(this.router);

  @override
  void subscribe(LoginCubit bloc, BuildContext context) {
    bloc.outEvents.listen((BlocEvent<LoginBlocEvent> event) {
      switch (event.type) {
        case LoginBlocEvent.signup:
          router.push(SignupPageConfig);
          break;
        case LoginBlocEvent.guestAuth:
          router.setNewRoutePath(NavigationBarPageConfig);
          break;
        default:
          assert(false, "Should never reach there");
          break;
      }
    });
  }
}
