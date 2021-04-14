// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'checkout_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$CheckoutStateTearOff {
  const _$CheckoutStateTearOff();

  _CheckoutState call(
      {String? addressValidationError,
      String? phoneValidationError,
      required PaymentOption paymentOption}) {
    return _CheckoutState(
      addressValidationError: addressValidationError,
      phoneValidationError: phoneValidationError,
      paymentOption: paymentOption,
    );
  }
}

/// @nodoc
const $CheckoutState = _$CheckoutStateTearOff();

/// @nodoc
mixin _$CheckoutState {
  String? get addressValidationError => throw _privateConstructorUsedError;
  String? get phoneValidationError => throw _privateConstructorUsedError;
  PaymentOption get paymentOption => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CheckoutStateCopyWith<CheckoutState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckoutStateCopyWith<$Res> {
  factory $CheckoutStateCopyWith(
          CheckoutState value, $Res Function(CheckoutState) then) =
      _$CheckoutStateCopyWithImpl<$Res>;
  $Res call(
      {String? addressValidationError,
      String? phoneValidationError,
      PaymentOption paymentOption});
}

/// @nodoc
class _$CheckoutStateCopyWithImpl<$Res>
    implements $CheckoutStateCopyWith<$Res> {
  _$CheckoutStateCopyWithImpl(this._value, this._then);

  final CheckoutState _value;
  // ignore: unused_field
  final $Res Function(CheckoutState) _then;

  @override
  $Res call({
    Object? addressValidationError = freezed,
    Object? phoneValidationError = freezed,
    Object? paymentOption = freezed,
  }) {
    return _then(_value.copyWith(
      addressValidationError: addressValidationError == freezed
          ? _value.addressValidationError
          : addressValidationError // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneValidationError: phoneValidationError == freezed
          ? _value.phoneValidationError
          : phoneValidationError // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentOption: paymentOption == freezed
          ? _value.paymentOption
          : paymentOption // ignore: cast_nullable_to_non_nullable
              as PaymentOption,
    ));
  }
}

/// @nodoc
abstract class _$CheckoutStateCopyWith<$Res>
    implements $CheckoutStateCopyWith<$Res> {
  factory _$CheckoutStateCopyWith(
          _CheckoutState value, $Res Function(_CheckoutState) then) =
      __$CheckoutStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? addressValidationError,
      String? phoneValidationError,
      PaymentOption paymentOption});
}

/// @nodoc
class __$CheckoutStateCopyWithImpl<$Res>
    extends _$CheckoutStateCopyWithImpl<$Res>
    implements _$CheckoutStateCopyWith<$Res> {
  __$CheckoutStateCopyWithImpl(
      _CheckoutState _value, $Res Function(_CheckoutState) _then)
      : super(_value, (v) => _then(v as _CheckoutState));

  @override
  _CheckoutState get _value => super._value as _CheckoutState;

  @override
  $Res call({
    Object? addressValidationError = freezed,
    Object? phoneValidationError = freezed,
    Object? paymentOption = freezed,
  }) {
    return _then(_CheckoutState(
      addressValidationError: addressValidationError == freezed
          ? _value.addressValidationError
          : addressValidationError // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneValidationError: phoneValidationError == freezed
          ? _value.phoneValidationError
          : phoneValidationError // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentOption: paymentOption == freezed
          ? _value.paymentOption
          : paymentOption // ignore: cast_nullable_to_non_nullable
              as PaymentOption,
    ));
  }
}

/// @nodoc
class _$_CheckoutState extends _CheckoutState with DiagnosticableTreeMixin {
  _$_CheckoutState(
      {this.addressValidationError,
      this.phoneValidationError,
      required this.paymentOption})
      : super._();

  @override
  final String? addressValidationError;
  @override
  final String? phoneValidationError;
  @override
  final PaymentOption paymentOption;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CheckoutState(addressValidationError: $addressValidationError, phoneValidationError: $phoneValidationError, paymentOption: $paymentOption)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CheckoutState'))
      ..add(
          DiagnosticsProperty('addressValidationError', addressValidationError))
      ..add(DiagnosticsProperty('phoneValidationError', phoneValidationError))
      ..add(DiagnosticsProperty('paymentOption', paymentOption));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CheckoutState &&
            (identical(other.addressValidationError, addressValidationError) ||
                const DeepCollectionEquality().equals(
                    other.addressValidationError, addressValidationError)) &&
            (identical(other.phoneValidationError, phoneValidationError) ||
                const DeepCollectionEquality().equals(
                    other.phoneValidationError, phoneValidationError)) &&
            (identical(other.paymentOption, paymentOption) ||
                const DeepCollectionEquality()
                    .equals(other.paymentOption, paymentOption)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(addressValidationError) ^
      const DeepCollectionEquality().hash(phoneValidationError) ^
      const DeepCollectionEquality().hash(paymentOption);

  @JsonKey(ignore: true)
  @override
  _$CheckoutStateCopyWith<_CheckoutState> get copyWith =>
      __$CheckoutStateCopyWithImpl<_CheckoutState>(this, _$identity);
}

abstract class _CheckoutState extends CheckoutState {
  factory _CheckoutState(
      {String? addressValidationError,
      String? phoneValidationError,
      required PaymentOption paymentOption}) = _$_CheckoutState;
  _CheckoutState._() : super._();

  @override
  String? get addressValidationError => throw _privateConstructorUsedError;
  @override
  String? get phoneValidationError => throw _privateConstructorUsedError;
  @override
  PaymentOption get paymentOption => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CheckoutStateCopyWith<_CheckoutState> get copyWith =>
      throw _privateConstructorUsedError;
}
