
import 'package:get/get.dart';
import 'package:wl_delivery/model/api/APIManager/api_manager.dart';
import 'package:wl_delivery/model/api/APIRequest/requests/request+user.dart';
import 'package:wl_delivery/model/repository/auth_repository.dart';
import 'package:wl_delivery/router/bloc_common/bloc_base.dart';

import 'change_password_state.dart';

enum ChangePasswordBlocEvent {
  pop
}

class ChangePasswordCubit extends BlocBaseObj<ChangePasswordState, ChangePasswordBlocEvent> {

  final authRepository = Get.find<AuthRepository>();
  final apiManager = Get.find<APIManager>();

  String? _oldPassword;
  String? _newPassword;
  String? _confirmPassword;

  ChangePasswordCubit() : super(ChangePasswordState());

  // ACTIONS
  changePassword() async {

    final oldPasswordError = _validatePassword(_oldPassword);
    final newPasswordError = _validatePassword(_newPassword);
    final passwordConfirmError = _validateConfirmPassword(_newPassword, _confirmPassword);

    if (oldPasswordError != null ||
        newPasswordError != null ||
        passwordConfirmError != null) {

      emit(state.copyWith(
          oldPasswordValidationError: oldPasswordError,
          newPasswordValidationError: newPasswordError,
          confirmPasswordValidationError: passwordConfirmError)
      );
      return;
    }

    try {
      inLoadingEvents.add(true);
      final request = UserAPI.changePassword(oldPassword: _oldPassword!, newPassword: _newPassword!);
      final result = await apiManager.performRequest(request);
      print(result);
      inLoadingEvents.add(false);
      inEvents.add(BlocEvent(type: ChangePasswordBlocEvent.pop));
    } catch (_) {
      inLoadingEvents.add(false);
      inMessageEvents.add('Error occured');
    }
  }

  // SETTERS
  setOldPassword(String? value) {
    _oldPassword = value;
    var newState = state.copyWith(oldPasswordValidationError: null);
    emit(newState);
  }

  setNewPassword(String? value) {
    _newPassword = value;
    var newState = state.copyWith(newPasswordValidationError: null);
    emit(newState);
  }

  setConfirmPassword(String? value) {
    _confirmPassword = value;
    var newState = state.copyWith(confirmPasswordValidationError: null);
    emit(newState);
  }

  String? _validatePassword(String? value) {
    return value?.isNotEmpty == true ? null : "Password must not be empty.";
  }

  String? _validateConfirmPassword(String? confirmPass, String? pass) {
    return confirmPass == pass ? null : "Confirm password should match password.";
  }
}
