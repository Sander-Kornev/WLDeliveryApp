
import 'package:wl_delivery/model/api/APIManager/api_constants.dart';
import 'package:wl_delivery/model/api/APIRequest/api_request.dart';

class LoginSocialType {

  final String value;

  LoginSocialType(this.value);

  LoginSocialType.Apple(): this("apple");
  LoginSocialType.FB(): this("fb");
  LoginSocialType.server(): this("server");
}

extension AuthAPI on APIRequest {

  static APIRequest login({email: String, password: String}) {
    Map<String, String> postParams = {
      "username": email,
      "password": password,
      "grant_type": "password"
    };

    final request = APIRequest.POST();
    request.urlAdditionalPath = "/o/token/";
    request.credentials = APICredentials(client: APIConstants.clientId, secret: APIConstants.clientSecret);
    request.postParameters = postParams;
    request.isWithToken = false;
    request.containsAuthInfo = true;

    return request;
  }

  static APIRequest registerSocial({socialId: String, socialType: LoginSocialType, String? email, String? fullname}) {

    final value = socialType.value;
    Map<String, String> postParams = {
      "social_auth_id": socialId,
      "network_name": value
    };
    if (email?.isNotEmpty == true) {
      postParams["email"] = email!;
    }
    if (fullname?.isNotEmpty == true) {
      postParams["fullname"] = fullname!;
    }

    final request = APIRequest.POST();
    request.urlAdditionalPath = "/user/social_auth/";
    request.credentials = APICredentials(
        client: APIConstants.clientId, secret: APIConstants.clientSecret);
    request.postParameters = postParams;
    request.isWithToken = false;
    request.containsAuthInfo = true;

    return request;
  }

  static APIRequest register({required String fullName, required String email, required String password}) {

    final postParams = {
      "fullname": fullName,
      "password": password,
      "password2": password,
      "email": email
    };

    final request = APIRequest.POST();
    request.urlAdditionalPath = "/user/register/";
    request.credentials = APICredentials(
        client: APIConstants.clientId, secret: APIConstants.clientSecret);
    request.postParameters = postParams;
    request.isWithToken = false;
    request.containsAuthInfo = true;

    return request;
  }

  static APIRequest forgotPassword({required String email}) {

    Map<String, String> postParams = {
      "email": email
    };

    final request = APIRequest.POST();
    request.urlAdditionalPath = "/user/forgot_password/";
    request.postParameters = postParams;
    request.isWithToken = false;

    return request;
  }
}