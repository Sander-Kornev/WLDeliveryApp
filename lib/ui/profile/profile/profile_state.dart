
import 'package:wl_delivery/model/db/models/user.dart';

abstract class ProfileState {

  User? get user;

  bool get isLoggedIn => user != null;
}

class ProfileLoggedInUsualState extends ProfileState {
  final User user;

  ProfileLoggedInUsualState(this.user);
}

class ProfileLoggedInSocialState extends ProfileState {
  final User user;
  final String networkName;

  ProfileLoggedInSocialState(this.user, this.networkName);
}

class ProfileLoggedOutState extends ProfileState {
  User? get user => null;
}