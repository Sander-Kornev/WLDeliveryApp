// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'login_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$LoginValidationErrorTearOff {
  const _$LoginValidationErrorTearOff();

  _LoginValidationError call(
      {String? emailValidationError, String? passwordValidationError}) {
    return _LoginValidationError(
      emailValidationError: emailValidationError,
      passwordValidationError: passwordValidationError,
    );
  }
}

/// @nodoc
const $LoginValidationError = _$LoginValidationErrorTearOff();

/// @nodoc
mixin _$LoginValidationError {
  String? get emailValidationError => throw _privateConstructorUsedError;
  String? get passwordValidationError => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginValidationErrorCopyWith<LoginValidationError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginValidationErrorCopyWith<$Res> {
  factory $LoginValidationErrorCopyWith(LoginValidationError value,
          $Res Function(LoginValidationError) then) =
      _$LoginValidationErrorCopyWithImpl<$Res>;
  $Res call({String? emailValidationError, String? passwordValidationError});
}

/// @nodoc
class _$LoginValidationErrorCopyWithImpl<$Res>
    implements $LoginValidationErrorCopyWith<$Res> {
  _$LoginValidationErrorCopyWithImpl(this._value, this._then);

  final LoginValidationError _value;
  // ignore: unused_field
  final $Res Function(LoginValidationError) _then;

  @override
  $Res call({
    Object? emailValidationError = freezed,
    Object? passwordValidationError = freezed,
  }) {
    return _then(_value.copyWith(
      emailValidationError: emailValidationError == freezed
          ? _value.emailValidationError
          : emailValidationError // ignore: cast_nullable_to_non_nullable
              as String?,
      passwordValidationError: passwordValidationError == freezed
          ? _value.passwordValidationError
          : passwordValidationError // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$LoginValidationErrorCopyWith<$Res>
    implements $LoginValidationErrorCopyWith<$Res> {
  factory _$LoginValidationErrorCopyWith(_LoginValidationError value,
          $Res Function(_LoginValidationError) then) =
      __$LoginValidationErrorCopyWithImpl<$Res>;
  @override
  $Res call({String? emailValidationError, String? passwordValidationError});
}

/// @nodoc
class __$LoginValidationErrorCopyWithImpl<$Res>
    extends _$LoginValidationErrorCopyWithImpl<$Res>
    implements _$LoginValidationErrorCopyWith<$Res> {
  __$LoginValidationErrorCopyWithImpl(
      _LoginValidationError _value, $Res Function(_LoginValidationError) _then)
      : super(_value, (v) => _then(v as _LoginValidationError));

  @override
  _LoginValidationError get _value => super._value as _LoginValidationError;

  @override
  $Res call({
    Object? emailValidationError = freezed,
    Object? passwordValidationError = freezed,
  }) {
    return _then(_LoginValidationError(
      emailValidationError: emailValidationError == freezed
          ? _value.emailValidationError
          : emailValidationError // ignore: cast_nullable_to_non_nullable
              as String?,
      passwordValidationError: passwordValidationError == freezed
          ? _value.passwordValidationError
          : passwordValidationError // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
class _$_LoginValidationError extends _LoginValidationError
    with DiagnosticableTreeMixin {
  _$_LoginValidationError(
      {this.emailValidationError, this.passwordValidationError})
      : super._();

  @override
  final String? emailValidationError;
  @override
  final String? passwordValidationError;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LoginValidationError(emailValidationError: $emailValidationError, passwordValidationError: $passwordValidationError)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LoginValidationError'))
      ..add(DiagnosticsProperty('emailValidationError', emailValidationError))
      ..add(DiagnosticsProperty(
          'passwordValidationError', passwordValidationError));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _LoginValidationError &&
            (identical(other.emailValidationError, emailValidationError) ||
                const DeepCollectionEquality().equals(
                    other.emailValidationError, emailValidationError)) &&
            (identical(
                    other.passwordValidationError, passwordValidationError) ||
                const DeepCollectionEquality().equals(
                    other.passwordValidationError, passwordValidationError)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(emailValidationError) ^
      const DeepCollectionEquality().hash(passwordValidationError);

  @JsonKey(ignore: true)
  @override
  _$LoginValidationErrorCopyWith<_LoginValidationError> get copyWith =>
      __$LoginValidationErrorCopyWithImpl<_LoginValidationError>(
          this, _$identity);
}

abstract class _LoginValidationError extends LoginValidationError {
  factory _LoginValidationError(
      {String? emailValidationError,
      String? passwordValidationError}) = _$_LoginValidationError;
  _LoginValidationError._() : super._();

  @override
  String? get emailValidationError => throw _privateConstructorUsedError;
  @override
  String? get passwordValidationError => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$LoginValidationErrorCopyWith<_LoginValidationError> get copyWith =>
      throw _privateConstructorUsedError;
}
