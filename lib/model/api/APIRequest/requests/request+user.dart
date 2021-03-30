
import 'package:wl_delivery/model/api/APIRequest/api_request.dart';

extension UserAPI on APIRequest {

  static APIRequest get userInfo {

    final request = APIRequest.GET();
    request.urlAdditionalPath = "/user/";

    return request;
  }

  static APIRequest changeUserInfo({fullname: String, email: String}) {

    final request = APIRequest.PUT();
    request.urlAdditionalPath = "/user/";
    request.postParameters = {
      "fullname": fullname,
      "email": email
    };

    return request;
  }

  static APIRequest changePassword({oldPassword: String, newPassword: String}) {

    final request = APIRequest.PUT();
    request.urlAdditionalPath = "/user/change_password/";
    request.postParameters = {
      "old_password": oldPassword,
      "new_password": newPassword
    };

    return request;
  }
}