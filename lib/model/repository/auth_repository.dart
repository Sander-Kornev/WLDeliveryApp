
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'package:wl_delivery/model/api/APIManager/api_manager.dart';
import 'package:wl_delivery/model/api/APIRequest/requests/request+auth.dart';
import 'package:wl_delivery/model/api/APIRequest/requests/request+user.dart';
import 'package:wl_delivery/model/db/models/user.dart';
import 'package:wl_delivery/model/logic/auth_store.dart';

const String boxName = "db";

abstract class AuthState {}
class UnknownAuthState extends AuthState {}
class LoggedInAuthState extends AuthState {}
class LoggedOutAuthState extends AuthState {}

class AuthRepository extends Cubit<AuthState> {

  late APIManager apiManager;
  final authStore = AuthStore();

  AuthRepository(): super(UnknownAuthState());

  login({email: String, password: String}) async {

    final authRequest = AuthAPI.login(email: email, password: password);
    final authResult = await apiManager.performRequest(authRequest);
    print(authResult);
    final userRequest = UserAPI.userInfo;
    final userInfo = await apiManager.performRequest(userRequest);
    print(userInfo);
    saveUser(userInfo);

    emit(LoggedInAuthState());
  }

  socialLogin({id: String, type: LoginSocialType, String? email, String? fullName}) async {
    final authRequest = AuthAPI.registerSocial(socialId: id, socialType: type, email: email, fullname: fullName);
    final authResult = await apiManager.performRequest(authRequest);
    print(authResult);
    saveUser(authResult);

    emit(LoggedInAuthState());
  }

  signup({fullName: String, email: String , password: String}) async {
    final authRequest = AuthAPI.register(fullName: fullName, email: email, password: password);
    final authResult = await apiManager.performRequest(authRequest);
    print(authResult);
    saveUser(authResult);

    emit(LoggedInAuthState());
  }

  authInfoReceived(Map info) async {
    await authStore.login(info);
  }

  logout() async {
    authStore.logout();
  }

  Future<String?> get accessToken async {
    return await authStore.accessToken;
  }

  saveUser(Map info) async {

    var userDB = Hive.box('db');
    final user = User.fromJson(info);

    userDB.add(user);
    user.save();
  }

  _deleteUser() async {

    var userDB = Hive.box(boxName);
    userDB.deleteFromDisk();
  }

  Future<User?> get loggedInUser async {
    var userDB = Hive.box(boxName);
    return userDB.values.first;
  }
}