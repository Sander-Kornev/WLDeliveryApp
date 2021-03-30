
import 'package:flutter/cupertino.dart';
import 'package:wl_delivery/router/bloc_common/bloc_base.dart';
import 'package:wl_delivery/router/bloc_common/bloc_context_base.dart';
import 'package:wl_delivery/router/router_delegate.dart';

import 'edit_profile_cubit.dart';

class EditProfileContext extends BlocContextBase<EditProfileCubit> {

  AppRouterDelegate router;
  EditProfileContext(this.router);

  void subscribe(EditProfileCubit bloc, BuildContext context) {
    bloc.outEvents.listen((BlocEvent<EditProfileBlocEvent> event) {
      switch (event.type) {
        case EditProfileBlocEvent.pop:
          router.popRoute();
          break;
        default:
          assert(false, "Should never reach there");
          break;
      }
    });

  }
}