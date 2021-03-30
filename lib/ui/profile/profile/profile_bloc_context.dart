

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wl_delivery/model/repository/auth_repository.dart';
import 'package:wl_delivery/router/bloc_common/bloc_base.dart';
import 'package:wl_delivery/router/bloc_common/bloc_context_base.dart';
import 'package:wl_delivery/router/bloc_common/bloc_provider.dart';
import 'package:wl_delivery/router/router_delegate.dart';
import 'package:wl_delivery/router/ui_pages.dart';
import 'package:wl_delivery/ui/profile/edit_profile/edit_profile.dart';
import 'package:wl_delivery/ui/profile/edit_profile/edit_profile_bloc_context.dart';
import 'package:wl_delivery/ui/profile/edit_profile/edit_profile_cubit.dart';
import 'package:wl_delivery/ui/profile/profile/profile_cubit.dart';

class ProfileBlocContext extends BlocContextBase<ProfileCubit> {

  AppRouterDelegate router;
  final authRepository = Get.find<AuthRepository>();

  ProfileBlocContext(this.router);

  @override
  void subscribe(ProfileCubit bloc, BuildContext context) {
    bloc.outEvents.listen((BlocEvent<ProfileBlocEvent> event) {
      switch (event.type) {
        case ProfileBlocEvent.login:
          router.setNewRoutePath(LoginPageConfig);
          break;
        case ProfileBlocEvent.logout:
          authRepository.logout();
          router.setNewRoutePath(LoginPageConfig);
          break;
        case ProfileBlocEvent.editProfile:
          router.pushWidget(BlocProviderObj(
            child: EditProfile(),
            bloc: EditProfileCubit(event.parameters?['name'] as String?, event.parameters?['email'] as String?),
            blocContext: EditProfileContext(router),
          ), LoginPageConfig);
          break;
        case ProfileBlocEvent.changePassword:
          router.push(ChangePasswordPageConfig);
          break;
        default:
          assert(false, "Should never reach there");
          break;
      }
    });
  }
}