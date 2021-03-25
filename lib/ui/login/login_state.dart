
import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';


@freezed
class LoginState with _$LoginState  {

  const LoginState._(); // Added constructor
  factory LoginState({String? emailValidationError, String? passwordValidationError}) = _LoginValidationError;

  bool get isValid => emailValidationError == null && passwordValidationError == null;
}