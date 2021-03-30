

import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_profile_state.freezed.dart';


@freezed
class EditProfileState with _$EditProfileState  {

  const EditProfileState._(); // Added constructor
  factory EditProfileState(
      {String? usernameValidationError,
      String? emailValidationError}) = _EditProfileState;

  bool get isValid =>
          usernameValidationError == null &&
          emailValidationError == null;
}