

import 'package:get/get.dart';
import 'package:wl_delivery/model/db/models/user.dart';
import 'package:wl_delivery/model/repository/auth_repository.dart';
import 'package:wl_delivery/router/bloc_common/bloc_base.dart';
import 'package:wl_delivery/ui/profile/profile/profile_state.dart';

enum ProfileBlocEvent {
  login,
  logout,
  editProfile,
  changePassword
}

class ProfileCubit extends BlocBaseObj<ProfileState, ProfileBlocEvent> {

  final authRepository = Get.find<AuthRepository>();
  User? _user;

  ProfileCubit() : super(ProfileLoggedOutState()) {
    _checkUserStatus();
  }

  _checkUserStatus() async {
    final user = await authRepository.loggedInUser;
    if (user != null) {
      _user = user;
      final socialName = await authRepository.socialNetworkName;
      if (socialName != null) {
        emit(ProfileLoggedInSocialState(user, socialName));
      } else {
        emit(ProfileLoggedInUsualState(user));
      }
    }
  }

  login() {
    inEvents.add(BlocEvent(type: ProfileBlocEvent.login));
  }

  logout() {
    inEvents.add(BlocEvent(type: ProfileBlocEvent.logout));
  }

  edit() {
    inEvents.add(
        BlocEvent(
            type: ProfileBlocEvent.editProfile,
            parameters: {
              'name': _user?.fullname,
              'email': _user?.email
            }
        )
    );
  }

  changePassword() {
    inEvents.add(BlocEvent(type: ProfileBlocEvent.changePassword));
  }

}