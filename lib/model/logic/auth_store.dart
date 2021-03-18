
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthState {}
class UnknownAuthState extends AuthState {}
class LoggedInAuthState extends AuthState {}
class LoggedOutAuthState extends AuthState {}

class AuthModel {
  final int expiresIn;
  final String refreshToken;
  final String accessToken;
  final String? networkName;

  AuthModel(this.expiresIn, this.refreshToken, this.accessToken, this.networkName);

  AuthModel.fromJson(Map json)
      : expiresIn = json['expires_in'],
        refreshToken = json['refresh_token'],
        accessToken = json['access_token'],
        networkName = json['network_name'];

  Map<String, dynamic> toJson() => {
        'expires_in': expiresIn,
        'refresh_token': refreshToken,
        'access_token': accessToken,
        'network_name': networkName
      };
}


class AuthStoreCubit extends Cubit<AuthState> {

  static const authModelKey = 'authModel';

  Future<AuthModel?> get authModel async {
    if (_authModel != null) {
      return _authModel!;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authValue = prefs.getString(authModelKey);
    if (authValue != null) {
      final savedModel = AuthModel.fromJson(jsonDecode(authValue));
      _authModel = savedModel;
      return savedModel;
    }
    return null;
  }

  AuthModel? _authModel;

  AuthStoreCubit(): super(UnknownAuthState());

  Future<String?> get accessToken async {
    return (await authModel)?.accessToken;
  }

  Future<bool> get isLoggedIn async {
    return (await accessToken)?.isNotEmpty == true;
  }

  login(Map info) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _authModel = AuthModel.fromJson(info);
    prefs.setString(authModelKey, jsonEncode(info));
    emit(LoggedInAuthState());
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _authModel = null;
    prefs.remove(authModelKey);
    emit(LoggedOutAuthState());
  }

}