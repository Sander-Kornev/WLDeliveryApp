
import 'package:wl_delivery/model/api/APIRequest/api_request.dart';

extension UserAPI on APIRequest {

  static APIRequest get userInfo {

    final request = APIRequest.GET();
    request.urlAdditionalPath = "/user/";

    return request;
  }
}