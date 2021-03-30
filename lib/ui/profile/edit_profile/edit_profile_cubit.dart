

import 'package:get/get.dart';
import 'package:wl_delivery/model/api/APIManager/api_manager.dart';
import 'package:wl_delivery/model/repository/auth_repository.dart';
import 'package:wl_delivery/router/bloc_common/bloc_base.dart';

import 'edit_profile_state.dart';

enum EditProfileBlocEvent {
  pop
}

class EditProfileCubit extends BlocBaseObj<EditProfileState, EditProfileBlocEvent> {

  final authRepository = Get.find<AuthRepository>();
  final apiManager = Get.find<APIManager>();

  String? _username;
  String? _email;

  String? get username => _username;
  String? get email => _email;

  EditProfileCubit(String? username, String? email) : super(EditProfileState()) {
    _username = username;
    _email = email;
  }

  // ACTIONS
  updateProfileAction() async {

    final usernameError = _validateUsername(_username);
    final emailError = _validateEmail(_email);

    if (usernameError != null ||
        emailError != null) {

      emit(state.copyWith(
          usernameValidationError: usernameError,
          emailValidationError: emailError)
      );
      return;
    }

    try {
      inLoadingEvents.add(true);
      await authRepository.updateUser(username: _username!, email: _email!);
      inLoadingEvents.add(false);
      inEvents.add(BlocEvent(type: EditProfileBlocEvent.pop));
    } catch (_) {
      inLoadingEvents.add(false);
      inMessageEvents.add('Error occured');
    }
  }

  // SETTERS
  setEmail(String? value) {
    _email = value;
    var newState = state.copyWith(emailValidationError: null);
    emit(newState);
  }

  setUsername(String? value) {
    _username = value;
    var newState = state.copyWith(usernameValidationError: null);
    emit(newState);
  }

  String? _validateUsername(String? value) {
    return (value ?? '').length >= 3  ? null : "Username must have at least 3 characters.";
  }

  String? _validateEmail(String? value) {
    return value?.isEmail == true ? null : "Email should be valid.";
  }
}
