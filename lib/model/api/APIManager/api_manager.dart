
import 'dart:convert';
import 'dart:io';

import 'package:wl_delivery/model/api/APIManager/api_constants.dart';
import 'package:wl_delivery/model/api/APIRequest/api_request.dart';

import 'package:http/http.dart' as http;
import 'package:wl_delivery/model/repository/auth_repository.dart';

class APIManager {

  AuthRepositoryProtocol authReceivedDelegate;
  APIManager({required this.authReceivedDelegate});

  Future<Map> performRequest(APIRequest request) async {

    var headers = {
      "Tenant": "test",
      "Staff": "0",
    };

    if (request.isWithToken) {
      final token = await authReceivedDelegate.accessToken;
      headers[HttpHeaders.authorizationHeader] = "Bearer $token";
    } else if (request.credentials != null) {
      headers[HttpHeaders.authorizationHeader] = _basicAuthHeader(request.credentials!);
    }

    String queryString = Uri(queryParameters: request.getParameters).query;

    var endpoint = Uri.parse(APIConstants.baseUrl + request.apiVersion.value + request.urlAdditionalPath + '?' + queryString);

    http.Response response;
    switch (request.httpMethod) {
      case APIRequestType.GET:
        response = await http.get(endpoint, headers: headers);
        break;
      case APIRequestType.POST:
        response = await http.post(endpoint, headers: headers, body: request.postParameters);
        break;
      case APIRequestType.PUT:
        response = await http.put(endpoint, headers: headers, body: request.postParameters);
        break;
    }
    _printRequest(response.request);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final mapValue = jsonDecode(response.body);
      if (request.containsAuthInfo) {
        authReceivedDelegate.authInfoReceived(mapValue);
      }
      return mapValue;
    } else {
      _printError(response);
      throw "Error occured";
    }
  }

  void _printRequest(http.BaseRequest? request) {
    print('====== REQUEST ======');
    print(request?.toString());
    print('====== /REQUEST ======');
  }

  void _printError(http.Response response) {
    if (response.statusCode != 200) {
      print('====== ERROR ======');
      print(response.body);
      print('====== /ERROR ======');
    }
  }

  String _basicAuthHeader(APICredentials credentials) {
    var userPass = Uri.encodeFull(credentials.client) + ':' + Uri.encodeFull(credentials.secret);
    return 'Basic ' + base64Encode(ascii.encode(userPass));
  }
}