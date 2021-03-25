

import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wl_delivery/model/api/APIManager/api_manager.dart';
import 'package:wl_delivery/router/bloc_common/bloc_base.dart';
import 'package:wl_delivery/router/bloc_common/bloc_context_base.dart';
import 'package:wl_delivery/ui/signup/signup_state.dart';

import '../../model/repository/auth_repository.dart';

class SignupContextBase extends BlocContextBase<SignupCubit> {
  void subscribe(SignupCubit bloc, BuildContext context) {}
}

class SignupCubit extends BlocBaseObj<SignupState, Void> {

  final authRepository = Get.find<AuthRepository>();
  final apiManager = Get.find<APIManager>();

  String? _username;
  String? _email;
  String? _password;
  String? _confirmPassword;

  SignupCubit() : super(SignupState(termsAndConditionsValue: false));

  // ACTIONS
  signup() async {

    final usernameError = _validateUsername(_username);
    final emailError = _validateEmail(_email);
    final passwordError = _validatePassword(_password);
    final passwordConfirmError = _validateConfirmPassword(_password, _confirmPassword);
    final termsError = _validateTerms(state.termsAndConditionsValue);

    if (usernameError != null ||
        emailError != null ||
        passwordError != null ||
        passwordConfirmError != null ||
        termsError != null) {

      emit(state.copyWith(
          usernameValidationError: usernameError,
          emailValidationError: emailError,
          passwordValidationError: passwordError,
          confirmPasswordValidationError: passwordConfirmError,
          termsValidationError: termsError)
      );
      return;
    }

    try {
      inLoadingEvents.add(true);
      await authRepository.signup(fullName: _username, email: _email!, password: _password!);
      inLoadingEvents.add(false);
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

  setPassword(String? value) {
    _password = value;
    var newState = state.copyWith(passwordValidationError: null);
    emit(newState);
  }

  setUsername(String? value) {
    _username = value;
    var newState = state.copyWith(usernameValidationError: null);
    emit(newState);
  }

  setConfirmPassword(String? value) {
    _confirmPassword = value;
    var newState = state.copyWith(confirmPasswordValidationError: null);
    emit(newState);
  }

  setTermsValue(bool value) {
    var newState = state.copyWith(termsValidationError: null, termsAndConditionsValue: value);
    emit(newState);
  }

  String? _validateUsername(String? value) {
    return (value ?? '').length >= 3  ? null : "Username must have at least 3 characters.";
  }

  String? _validateEmail(String? value) {
    return value?.isEmail == true ? null : "Email should be valid.";
  }

  String? _validatePassword(String? value) {
    return value?.isNotEmpty == true ? null : "Password must not be empty.";
  }

  String? _validateConfirmPassword(String? confirmPass, String? pass) {
    return confirmPass == pass ? null : "Confirm password should match password.";
  }

  String? _validateTerms(bool value) {
    return value ? null : "Please agree Terms and Conditions.";
  }
}
