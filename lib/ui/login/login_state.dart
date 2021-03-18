
import 'package:flutter/foundation.dart';

import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:build_runner/build_runner.dart';

part 'login_state.freezed.dart';

abstract class LoginState {}

class LoginWaitingState extends LoginState {}
class LoginLoadingState extends LoginState {}
class LoginSuccessState extends LoginState {}

@freezed
class LoginValidationError with _$LoginValidationError, LoginState  {

  const LoginValidationError._(); // Added constructor
  factory LoginValidationError({String? emailValidationError, String? passwordValidationError}) = _LoginValidationError;

  bool get isEmpty => emailValidationError == null && passwordValidationError == null;
}
class LoginErrorState extends LoginState {}