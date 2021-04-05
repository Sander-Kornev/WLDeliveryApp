
import '../api_request.dart';

extension EstablishmentAPI on APIRequest {

  static APIRequest get getEstablishments {
    final request = APIRequest.GET();
    request.urlAdditionalPath = "/establishments/";
    request.isWithToken = false;

    return request;
  }

  static APIRequest getEstablishmentDetails(int id) {
    final request = APIRequest.GET();
    request.urlAdditionalPath = "/establishments/$id/";
    request.isWithToken = false;

    return request;
  }

  static APIRequest getProducts(int categoryId) {
    final request = APIRequest.GET();
    request.urlAdditionalPath = "/categories/$categoryId/products/";
    request.isWithToken = false;

    return request;
  }

  static APIRequest searchProducts(int groceryId, String text) {
    final request = APIRequest.GET();
    request.urlAdditionalPath = "/establishments/$groceryId/products/";
    request.getParameters = {'search': text};
    request.isWithToken = false;

    return request;
  }
}