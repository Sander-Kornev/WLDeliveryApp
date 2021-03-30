// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'edit_profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$EditProfileStateTearOff {
  const _$EditProfileStateTearOff();

  _EditProfileState call(
      {String? usernameValidationError, String? emailValidationError}) {
    return _EditProfileState(
      usernameValidationError: usernameValidationError,
      emailValidationError: emailValidationError,
    );
  }
}

/// @nodoc
const $EditProfileState = _$EditProfileStateTearOff();

/// @nodoc
mixin _$EditProfileState {
  String? get usernameValidationError => throw _privateConstructorUsedError;
  String? get emailValidationError => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EditProfileStateCopyWith<EditProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditProfileStateCopyWith<$Res> {
  factory $EditProfileStateCopyWith(
          EditProfileState value, $Res Function(EditProfileState) then) =
      _$EditProfileStateCopyWithImpl<$Res>;
  $Res call({String? usernameValidationError, String? emailValidationError});
}

/// @nodoc
class _$EditProfileStateCopyWithImpl<$Res>
    implements $EditProfileStateCopyWith<$Res> {
  _$EditProfileStateCopyWithImpl(this._value, this._then);

  final EditProfileState _value;
  // ignore: unused_field
  final $Res Function(EditProfileState) _then;

  @override
  $Res call({
    Object? usernameValidationError = freezed,
    Object? emailValidationError = freezed,
  }) {
    return _then(_value.copyWith(
      usernameValidationError: usernameValidationError == freezed
          ? _value.usernameValidationError
          : usernameValidationError // ignore: cast_nullable_to_non_nullable
              as String?,
      emailValidationError: emailValidationError == freezed
          ? _value.emailValidationError
          : emailValidationError // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$EditProfileStateCopyWith<$Res>
    implements $EditProfileStateCopyWith<$Res> {
  factory _$EditProfileStateCopyWith(
          _EditProfileState value, $Res Function(_EditProfileState) then) =
      __$EditProfileStateCopyWithImpl<$Res>;
  @override
  $Res call({String? usernameValidationError, String? emailValidationError});
}

/// @nodoc
class __$EditProfileStateCopyWithImpl<$Res>
    extends _$EditProfileStateCopyWithImpl<$Res>
    implements _$EditProfileStateCopyWith<$Res> {
  __$EditProfileStateCopyWithImpl(
      _EditProfileState _value, $Res Function(_EditProfileState) _then)
      : super(_value, (v) => _then(v as _EditProfileState));

  @override
  _EditProfileState get _value => super._value as _EditProfileState;

  @override
  $Res call({
    Object? usernameValidationError = freezed,
    Object? emailValidationError = freezed,
  }) {
    return _then(_EditProfileState(
      usernameValidationError: usernameValidationError == freezed
          ? _value.usernameValidationError
          : usernameValidationError // ignore: cast_nullable_to_non_nullable
              as String?,
      emailValidationError: emailValidationError == freezed
          ? _value.emailValidationError
          : emailValidationError // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
class _$_EditProfileState extends _EditProfileState
    with DiagnosticableTreeMixin {
  _$_EditProfileState({this.usernameValidationError, this.emailValidationError})
      : super._();

  @override
  final String? usernameValidationError;
  @override
  final String? emailValidationError;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EditProfileState(usernameValidationError: $usernameValidationError, emailValidationError: $emailValidationError)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EditProfileState'))
      ..add(DiagnosticsProperty(
          'usernameValidationError', usernameValidationError))
      ..add(DiagnosticsProperty('emailValidationError', emailValidationError));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _EditProfileState &&
            (identical(
                    other.usernameValidationError, usernameValidationError) ||
                const DeepCollectionEquality().equals(
                    other.usernameValidationError, usernameValidationError)) &&
            (identical(other.emailValidationError, emailValidationError) ||
                const DeepCollectionEquality()
                    .equals(other.emailValidationError, emailValidationError)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(usernameValidationError) ^
      const DeepCollectionEquality().hash(emailValidationError);

  @JsonKey(ignore: true)
  @override
  _$EditProfileStateCopyWith<_EditProfileState> get copyWith =>
      __$EditProfileStateCopyWithImpl<_EditProfileState>(this, _$identity);
}

abstract class _EditProfileState extends EditProfileState {
  factory _EditProfileState(
      {String? usernameValidationError,
      String? emailValidationError}) = _$_EditProfileState;
  _EditProfileState._() : super._();

  @override
  String? get usernameValidationError => throw _privateConstructorUsedError;
  @override
  String? get emailValidationError => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$EditProfileStateCopyWith<_EditProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}
