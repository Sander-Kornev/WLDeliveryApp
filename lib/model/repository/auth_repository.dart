
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

abstract class AuthRepositoryProtocol {
  Future<String?> get accessToken;
  authInfoReceived(Map info);
}

class AuthRepository extends Cubit<AuthState> with AuthRepositoryProtocol {

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
    saveUser(authResult['user']);

    emit(LoggedInAuthState());
  }

  signup({fullName: String, email: String , password: String}) async {
    final authRequest = AuthAPI.register(fullName: fullName, email: email, password: password);
    final authResult = await apiManager.performRequest(authRequest);
    print(authResult);
    saveUser(authResult['user']);

    emit(LoggedInAuthState());
  }

  authInfoReceived(Map info) async {
    await authStore.login(info);
  }

  logout() async {
    _deleteUser();
    authStore.logout();
  }

  Future<String?> get accessToken async {
    return await authStore.accessToken;
  }

  saveUser(Map info) async {

    var userDB = Hive.box<User>(boxName);
    User? user;
    if (userDB.isEmpty) {
      user = User.fromJson(info);
      await userDB.add(user);
    } else {
      user = userDB.getAt(0);
      user?.update(info);
    }
    user?.save();
  }

  _deleteUser() async {

    var userDB = Hive.box<User>(boxName);
    await userDB.deleteAt(0);
  }

  Future<User?> get loggedInUser async {
    var userDB = Hive.box<User>(boxName);
    return userDB.isEmpty ? null : userDB.getAt(0);
  }

  Future<String?> get socialNetworkName async {
    return (await authStore.authModel)?.networkName;
  }

  updateUser({username: String, email: String}) async {
    final request = UserAPI.changeUserInfo(fullname: username, email: email);
    final result = await apiManager.performRequest(request);
    print(result);
    saveUser(result);
  }
}