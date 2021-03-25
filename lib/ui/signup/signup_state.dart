

import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_state.freezed.dart';


@freezed
class SignupState with _$SignupState  {

  const SignupState._(); // Added constructor
  factory SignupState(
      {String? usernameValidationError,
      String? emailValidationError,
      String? passwordValidationError,
      String? confirmPasswordValidationError,
      String? termsValidationError,
      required bool termsAndConditionsValue}) = _SignupState;

  bool get isValid =>
      usernameValidationError == null &&
      emailValidationError == null &&
      passwordValidationError == null &&
      confirmPasswordValidationError == null &&
      termsValidationError == null;
}