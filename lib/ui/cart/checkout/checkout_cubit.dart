
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

class CheckoutCubit extends BlocBaseObj<CheckoutState, void> {

  final cart = Get.find<Cart>();
  final apiManager = Get.find<APIManager>();
  GroceryCafe? get grocery { return cart.currentShop; }

  String? _address;
  String? _phoneNumber;
  String? _entrance;
  String? _floor;
  String? _apartment;

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

  setAddress(String? value) {
    _address = value;
    var newState = state.copyWith(addressValidationError: null);
    emit(newState);
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
    final addressError = _validateAddress(_address);
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
          address: _address!,
          entrance: _entrance,
          apartment: _apartment,
          floor: _floor,
          latitude: 0,
          longitude: 0
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
      inLoadingEvents.add(false);
    } catch (err) {
      print(err.toString());
      inLoadingEvents.add(false);
      inMessageEvents.add('Error occured');
    }
  }

  String? _validateAddress(String? value) {
    return value?.isNotEmpty == true
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