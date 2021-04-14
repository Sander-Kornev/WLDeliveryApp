
import 'package:wl_delivery/model/api/APIRequest/api_request.dart';
import 'package:wl_delivery/model/local_models/preorder_model.dart';

extension OrdersAPI on APIRequest {

  static APIRequest createOrder(PreorderModel order) {
    final request = APIRequest.POST();
    request.urlAdditionalPath = "/order/";
    request.postParameters = order.apiJSON;
    request.encoding = APIEncoding.json;

    return request;
  }
}