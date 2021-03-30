
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:wl_delivery/model/api/APIManager/api_manager.dart';
import 'package:wl_delivery/model/api/APIRequest/requests/request+auth.dart';
import 'package:wl_delivery/router/bloc_common/bloc_base.dart';
import 'package:wl_delivery/router/bloc_common/bloc_context_base.dart';

import '../../model/repository/auth_repository.dart';
import 'login_state.dart';

enum LoginBlocEvent {
  signup,
  guestAuth
}

class LoginCubit extends BlocBaseObj<LoginState, LoginBlocEvent> {

  final authRepository = Get.find<AuthRepository>();
  final apiManager = Get.find<APIManager>();

  String? _email;
  String? _password;

  LoginCubit() : super(LoginState());

  // ACTIONS
  login() async {

    final emailError = _validateEmail(_email);
    final passwordError = _validatePassword(_password);

    if (emailError != null || passwordError != null) {
      emit(LoginState(emailValidationError: emailError, passwordValidationError: passwordError));
      return;
    }

    try {
      inLoadingEvents.add(true);
      await authRepository.login(email: _email!, password: _password!);
      inLoadingEvents.add(false);
    } catch (_) {
      inLoadingEvents.add(false);
      inMessageEvents.add('Error occured');
    }
  }

  fbLogin() async {

    inLoadingEvents.add(true);

    final LoginResult result = await FacebookAuth.instance.login(); // by the fault we request the email and the public profile
    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken!;
      print(accessToken.toJson());

      final userData = await FacebookAuth.instance
          .getUserData(fields: "email,first_name,last_name");

      print(userData);

      final firstName = userData["first_name"] as String? ?? '';
      final lastName = userData["last_name"] as String? ?? '';
      final email = userData["email"] as String? ?? '';
      final id = userData["id"] as String? ?? '';

      try {
        await authRepository.socialLogin(
            id: id,
            email: email,
            fullName: "$firstName $lastName",
            type: LoginSocialType.FB());
        inLoadingEvents.add(false);
      } catch (err) {
        inLoadingEvents.add(false);
        print(err.toString());
      }
    } else {
      inLoadingEvents.add(false);
    }
  }

  signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        // TODO: Remove these if you have no need for them
        nonce: 'example-nonce',
        state: 'example-state',
      );

      print(credential);

      // This is the endpoint that will convert an authorization code obtained
      // via Sign in with Apple into a session in your system
      String fullName = '';
      final id = credential.userIdentifier;
      if (credential.givenName != null) {
        fullName += credential.givenName!;
      }
      if (credential.familyName != null) {
        fullName += ' ';
        fullName += credential.familyName!;
      }

      inLoadingEvents.add(true);
      await authRepository.socialLogin(
          id: id,
          email: credential.email,
          fullName: fullName,
          type: LoginSocialType.Apple()
      );
      inLoadingEvents.add(false);
    } catch (err) {
      print(err.toString());
      inLoadingEvents.add(false);
    }

    // If we got this far, a session based on the Apple ID credential has been created in your system,
    // and you can now set this as the app's session
  }

  signup() {
    inEvents.add(BlocEvent(type: LoginBlocEvent.signup));
  }

  guestAuth() {
    inEvents.add(BlocEvent(type: LoginBlocEvent.guestAuth));
  }

  // FORGOT PASSWORD
  forgotPassword() {

    DialogTextField textField = DialogTextField(
        keyboardType: TextInputType.emailAddress,
        hintText: "Email",
        validator: _validateEmail
    );
    TextMessageAlert textAlert = TextMessageAlert(
        [textField],
        "Forgot Password",
        "Please enter your email",
        'Send',
        _sendForgotPassword
    );
    inTextAlertController.add(textAlert);
  }

  _sendForgotPassword(String? email) async {
    if (email == null) {
      return;
    }

    try {
      inLoadingEvents.add(true);
      final request = AuthAPI.forgotPassword(email: email);
      final result = await apiManager.performRequest(request);
      print(result);
      inLoadingEvents.add(false);
      inMessageEvents.add('Confirmation email was sent');
    } catch (err) {
      print(err.toString());
      inLoadingEvents.add(false);
      inMessageEvents.add('Error occured');
    }
  }

  // SETTERS
  setEmail(String? value) {
    _email = value;
    var newState = this.state.copyWith(emailValidationError: null);
    emit(newState);
  }

  setPassword(String? value) {
    _password = value;
    var newState = this.state.copyWith(passwordValidationError: null);
    emit(newState);
  }

  String? _validateEmail(String? value) {
    return value?.isEmail == true ? null : "Email should be valid.";
  }

  String? _validatePassword(String? value) {
    return value?.isNotEmpty == true ? null : "Password must not be empty.";
  }
}
