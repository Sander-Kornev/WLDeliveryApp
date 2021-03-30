
import 'package:flutter/cupertino.dart';
import 'package:wl_delivery/router/bloc_common/bloc_base.dart';
import 'package:wl_delivery/router/bloc_common/bloc_context_base.dart';
import 'package:wl_delivery/router/router_delegate.dart';
import 'package:wl_delivery/ui/profile/change_password/change_password_cubit.dart';

class ChangePasswordContext extends BlocContextBase<ChangePasswordCubit> {

  AppRouterDelegate router;
  ChangePasswordContext(this.router);

  void subscribe(ChangePasswordCubit bloc, BuildContext context) {
    bloc.outEvents.listen((BlocEvent<ChangePasswordBlocEvent> event) {
      switch (event.type) {
        case ChangePasswordBlocEvent.pop:
          router.popRoute();
          break;
        default:
          assert(false, "Should never reach there");
          break;
      }
    });
  }
}