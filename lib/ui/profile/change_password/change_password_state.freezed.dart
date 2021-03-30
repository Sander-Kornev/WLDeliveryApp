// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'change_password_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ChangePasswordStateTearOff {
  const _$ChangePasswordStateTearOff();

  _ChangePasswordState call(
      {String? oldPasswordValidationError,
      String? newPasswordValidationError,
      String? confirmPasswordValidationError}) {
    return _ChangePasswordState(
      oldPasswordValidationError: oldPasswordValidationError,
      newPasswordValidationError: newPasswordValidationError,
      confirmPasswordValidationError: confirmPasswordValidationError,
    );
  }
}

/// @nodoc
const $ChangePasswordState = _$ChangePasswordStateTearOff();

/// @nodoc
mixin _$ChangePasswordState {
  String? get oldPasswordValidationError => throw _privateConstructorUsedError;
  String? get newPasswordValidationError => throw _privateConstructorUsedError;
  String? get confirmPasswordValidationError =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChangePasswordStateCopyWith<ChangePasswordState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChangePasswordStateCopyWith<$Res> {
  factory $ChangePasswordStateCopyWith(
          ChangePasswordState value, $Res Function(ChangePasswordState) then) =
      _$ChangePasswordStateCopyWithImpl<$Res>;
  $Res call(
      {String? oldPasswordValidationError,
      String? newPasswordValidationError,
      String? confirmPasswordValidationError});
}

/// @nodoc
class _$ChangePasswordStateCopyWithImpl<$Res>
    implements $ChangePasswordStateCopyWith<$Res> {
  _$ChangePasswordStateCopyWithImpl(this._value, this._then);

  final ChangePasswordState _value;
  // ignore: unused_field
  final $Res Function(ChangePasswordState) _then;

  @override
  $Res call({
    Object? oldPasswordValidationError = freezed,
    Object? newPasswordValidationError = freezed,
    Object? confirmPasswordValidationError = freezed,
  }) {
    return _then(_value.copyWith(
      oldPasswordValidationError: oldPasswordValidationError == freezed
          ? _value.oldPasswordValidationError
          : oldPasswordValidationError // ignore: cast_nullable_to_non_nullable
              as String?,
      newPasswordValidationError: newPasswordValidationError == freezed
          ? _value.newPasswordValidationError
          : newPasswordValidationError // ignore: cast_nullable_to_non_nullable
              as String?,
      confirmPasswordValidationError: confirmPasswordValidationError == freezed
          ? _value.confirmPasswordValidationError
          : confirmPasswordValidationError // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$ChangePasswordStateCopyWith<$Res>
    implements $ChangePasswordStateCopyWith<$Res> {
  factory _$ChangePasswordStateCopyWith(_ChangePasswordState value,
          $Res Function(_ChangePasswordState) then) =
      __$ChangePasswordStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? oldPasswordValidationError,
      String? newPasswordValidationError,
      String? confirmPasswordValidationError});
}

/// @nodoc
class __$ChangePasswordStateCopyWithImpl<$Res>
    extends _$ChangePasswordStateCopyWithImpl<$Res>
    implements _$ChangePasswordStateCopyWith<$Res> {
  __$ChangePasswordStateCopyWithImpl(
      _ChangePasswordState _value, $Res Function(_ChangePasswordState) _then)
      : super(_value, (v) => _then(v as _ChangePasswordState));

  @override
  _ChangePasswordState get _value => super._value as _ChangePasswordState;

  @override
  $Res call({
    Object? oldPasswordValidationError = freezed,
    Object? newPasswordValidationError = freezed,
    Object? confirmPasswordValidationError = freezed,
  }) {
    return _then(_ChangePasswordState(
      oldPasswordValidationError: oldPasswordValidationError == freezed
          ? _value.oldPasswordValidationError
          : oldPasswordValidationError // ignore: cast_nullable_to_non_nullable
              as String?,
      newPasswordValidationError: newPasswordValidationError == freezed
          ? _value.newPasswordValidationError
          : newPasswordValidationError // ignore: cast_nullable_to_non_nullable
              as String?,
      confirmPasswordValidationError: confirmPasswordValidationError == freezed
          ? _value.confirmPasswordValidationError
          : confirmPasswordValidationError // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
class _$_ChangePasswordState extends _ChangePasswordState
    with DiagnosticableTreeMixin {
  _$_ChangePasswordState(
      {this.oldPasswordValidationError,
      this.newPasswordValidationError,
      this.confirmPasswordValidationError})
      : super._();

  @override
  final String? oldPasswordValidationError;
  @override
  final String? newPasswordValidationError;
  @override
  final String? confirmPasswordValidationError;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChangePasswordState(oldPasswordValidationError: $oldPasswordValidationError, newPasswordValidationError: $newPasswordValidationError, confirmPasswordValidationError: $confirmPasswordValidationError)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChangePasswordState'))
      ..add(DiagnosticsProperty(
          'oldPasswordValidationError', oldPasswordValidationError))
      ..add(DiagnosticsProperty(
          'newPasswordValidationError', newPasswordValidationError))
      ..add(DiagnosticsProperty(
          'confirmPasswordValidationError', confirmPasswordValidationError));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ChangePasswordState &&
            (identical(other.oldPasswordValidationError,
                    oldPasswordValidationError) ||
                const DeepCollectionEquality().equals(
                    other.oldPasswordValidationError,
                    oldPasswordValidationError)) &&
            (identical(other.newPasswordValidationError,
                    newPasswordValidationError) ||
                const DeepCollectionEquality().equals(
                    other.newPasswordValidationError,
                    newPasswordValidationError)) &&
            (identical(other.confirmPasswordValidationError,
                    confirmPasswordValidationError) ||
                const DeepCollectionEquality().equals(
                    other.confirmPasswordValidationError,
                    confirmPasswordValidationError)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(oldPasswordValidationError) ^
      const DeepCollectionEquality().hash(newPasswordValidationError) ^
      const DeepCollectionEquality().hash(confirmPasswordValidationError);

  @JsonKey(ignore: true)
  @override
  _$ChangePasswordStateCopyWith<_ChangePasswordState> get copyWith =>
      __$ChangePasswordStateCopyWithImpl<_ChangePasswordState>(
          this, _$identity);
}

abstract class _ChangePasswordState extends ChangePasswordState {
  factory _ChangePasswordState(
      {String? oldPasswordValidationError,
      String? newPasswordValidationError,
      String? confirmPasswordValidationError}) = _$_ChangePasswordState;
  _ChangePasswordState._() : super._();

  @override
  String? get oldPasswordValidationError => throw _privateConstructorUsedError;
  @override
  String? get newPasswordValidationError => throw _privateConstructorUsedError;
  @override
  String? get confirmPasswordValidationError =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ChangePasswordStateCopyWith<_ChangePasswordState> get copyWith =>
      throw _privateConstructorUsedError;
}
