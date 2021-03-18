
import 'package:wl_delivery/model/api/APIManager/api_constants.dart';
import 'package:wl_delivery/model/api/APIRequest/api_request.dart';

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
}