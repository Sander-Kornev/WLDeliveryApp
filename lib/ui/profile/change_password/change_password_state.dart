

import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_password_state.freezed.dart';


@freezed
class ChangePasswordState with _$ChangePasswordState {

  const ChangePasswordState._(); // Added constructor
  factory ChangePasswordState({String? oldPasswordValidationError,
    String? newPasswordValidationError,
    String? confirmPasswordValidationError}) = _ChangePasswordState;

  bool get isValid =>
      oldPasswordValidationError == null &&
          newPasswordValidationError == null &&
          confirmPasswordValidationError == null;
}