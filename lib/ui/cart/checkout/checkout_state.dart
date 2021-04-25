
import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkout_state.freezed.dart';

enum PaymentOption {
  card,
  cash
}

@freezed
class CheckoutState with _$CheckoutState  {

  const CheckoutState._(); // Added constructor
  factory CheckoutState(
      {String? addressValue,
        String? addressValidationError,
        String? phoneValidationError,
        required PaymentOption paymentOption}) = _CheckoutState;

  bool get isValid =>
      addressValidationError == null &&
          phoneValidationError == null;
}