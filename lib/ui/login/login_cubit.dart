
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:wl_delivery/model/api/APIManager/api_manager.dart';
import 'package:wl_delivery/model/api/APIRequest/api_request.dart';
import 'package:wl_delivery/model/api/APIRequest/requests/request+auth.dart';
import 'package:wl_delivery/model/api/APIRequest/requests/request+user.dart';
import 'package:wl_delivery/router/router_delegate.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {

  final apiManager = Get.find<APIManager>();
  final delegate = Get.find<AppRouterDelegate>();

  String? _email;
  String? _password;

  LoginCubit() : super(LoginWaitingState());

  void login() async {

    final emailError = _validateEmail(_email);
    final passwordError = _validatePassword(_password);

    if (emailError != null || passwordError != null) {
      emit(LoginValidationError(emailValidationError: emailError, passwordValidationError: passwordError));
      return;
    }

    try {
      emit(LoginWaitingState());
      delegate.showLoaderDialog();
      final authRequest = AuthAPI.login(email: _email, password: _password);
      final authResult = await apiManager.performRequest(authRequest);
      print(authResult);
      final userRequest = UserAPI.userInfo;
      final userInfo = await apiManager.performRequest(userRequest);
      print(userInfo);
      delegate.hideLoader();
      emit(LoginSuccessState());
    } catch (_) {
      delegate.hideLoader();
      delegate.openOkDialog('Error occured');
    }
  }

  void setEmail(String? value) {
    _email = value;
    if (this.state is LoginValidationError) {
      var newState = (this.state as LoginValidationError).copyWith(emailValidationError: null);
      if (newState.isEmpty) {
        emit(LoginWaitingState());
      } else {
        emit(newState);
      }
    }
  }

  void setPassword(String? value) {
    _password = value;
    if (this.state is LoginValidationError) {
      var newState = (this.state as LoginValidationError).copyWith(passwordValidationError: null);
      if (newState.isEmpty) {
        emit(LoginWaitingState());
      } else {
        emit(newState);
      }
    }
  }

  String? _validateEmail(String? value) {
    return value?.isEmail == true ? null : "Email should be valid.";
  }

  String? _validatePassword(String? value) {
    return value?.isNotEmpty == true ? null : "Password must not be empty.";
  }
}
