
import 'dart:async';

import 'package:wl_delivery/helper/location/geocoding_manager.dart';
import 'package:wl_delivery/model/api/APIManager/api_manager.dart';
import 'package:wl_delivery/model/api/APIRequest/requests/request+order.dart';
import 'package:wl_delivery/model/db/models/grocery_cafe.dart';
import 'package:wl_delivery/model/local_models/destination.dart';
import 'package:wl_delivery/model/local_models/preorder_model.dart';
import 'package:wl_delivery/model/logic/cart.dart';
import 'package:wl_delivery/router/bloc_common/bloc_base.dart';
import 'package:wl_delivery/extensions/double_extension.dart';
import 'package:get/get.dart';
import 'package:wl_delivery/ui/cart/checkout/checkout_state.dart';
import 'package:wl_delivery/extensions/optional.dart';

enum CheckoutCubitEvent {
  selectAddress
}

class CheckoutCubit extends BlocBaseObj<CheckoutState, CheckoutCubitEvent> {

  final cart = Get.find<Cart>();
  final apiManager = Get.find<APIManager>();
  GroceryCafe? get grocery { return cart.currentShop; }

  String? _phoneNumber;
  String? _entrance;
  String? _floor;
  String? _apartment;
  LocationItem? _locationItem;

  String? get total => (cart.subtotalPrice + (grocery?.deliveryPrice ?? 0)).toCurrency;
  bool get byCard => state.paymentOption == PaymentOption.card;
  bool get byCash => state.paymentOption == PaymentOption.cash;
  String get paymentDescription {
    if (byCard) {
      return 'Pay by card';
    } else {
      return 'Pay cash to the courier on delivery';
    }
  }

  CheckoutCubit(): super(CheckoutState(paymentOption: PaymentOption.cash));

  addressTap() async {
    Completer<LocationItem> completer = Completer();
    inEvents.add(BlocEvent(type: CheckoutCubitEvent.selectAddress, completer: completer));
    try {
      _locationItem = await completer.future;
      emit(state.copyWith(addressValue: _locationItem!.mainText));
    } catch (err) {
      print(err);
    }
  }

  setPhoneNumber(String? value) {
    _phoneNumber = value;
    var newState = state.copyWith(phoneValidationError: null);
    emit(newState);
  }

  setEntrance(String? value) {
    _entrance = value;
  }

  setFloor(String? value) {
    _floor = value;
  }

  setApartment(String? value) {
    _apartment = value;
  }

  cardOptionSelected() {
    emit(state.copyWith(paymentOption: PaymentOption.card));
  }

  cashOptionSelected() {
    emit(state.copyWith(paymentOption: PaymentOption.cash));
  }

  checkoutAction() async {
    final addressError = _validateAddress(_locationItem);
    final phoneError = _validatePhone(_phoneNumber);

    if (addressError != null ||
        phoneError != null) {

      emit(state.copyWith(
          addressValidationError: addressError,
          phoneValidationError: phoneError)
      );
      return;
    }

    try {
      inLoadingEvents.add(true);
      final destination = Destination(
          address: _locationItem!.mainText,
          entrance: _entrance,
          apartment: _apartment,
          floor: _floor,
          latitude: _locationItem!.latitude!,
          longitude: _locationItem!.longitude!
      );
      final preorderModel = PreorderModel(
          establishment: cart.currentShop!,
          products: cart.products,
          subtotalPrice: cart.subtotalPrice,
          deliveryPrice: cart.currentShop!.deliveryPrice,
          destination: destination,
          contact: _phoneNumber!
      );
      final request = OrdersAPI.createOrder(preorderModel);
      final response = await apiManager.performRequest(request);
      print(response);
      inLoadingEvents.add(false);
    } catch (err) {
      print(err.toString());
      inLoadingEvents.add(false);
      inMessageEvents.add('Error occured');
    }
  }

  String? _validateAddress(LocationItem? value) {
    return value != null && value.latitude != null && value.longitude != null
        ? null
        : "Address shouldn't be empty.";
  }

  String? _validatePhone(String? value) {
    final alphanumeric = RegExp(r'^\+?3?8?(0\d{9})$');
    return alphanumeric.hasMatch(value.orEmpty)
        ? null
        : "Phone number should be valid.";
  }
}