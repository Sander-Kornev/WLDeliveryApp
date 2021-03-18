

enum APIRequestType {
  GET,
  POST,
  PUT
}

enum APIEncoding {
  url,
  json
}

enum APIVersion {
  v1,
  v2
}

extension APIVersionString on APIVersion {
  String get value {
    switch (this) {
      case APIVersion.v1:
        return "v1";
      case APIVersion.v2:
        return "v2";
    }
  }
}

class APICredentials {
  String client;
  String secret;

  APICredentials({required this.client, required this.secret});
}

class APIRequest {

  Map<String, dynamic>? postParameters;
  Map<String, String>? getParameters;
  String urlAdditionalPath = "";

  APIRequestType httpMethod;
  APIVersion apiVersion;

  APIEncoding encoding = APIEncoding.url;
  APICredentials? credentials;

  bool isWithToken = true;
  bool containsAuthInfo = false;

  // APIRequest.create(APIRequestType method, APIVersion? version) {
  //   APIRequest(httpMethod: method, apiVersion: version ?? APIVersion.v1);
  // }

  APIRequest({required this.httpMethod, required this.apiVersion});

  static APIRequest GET([APIVersion? apiVersion]) {
    return APIRequest(httpMethod: APIRequestType.GET,
        apiVersion: apiVersion ?? APIVersion.v1);
  }

  // ignore: non_constant_identifier_names
  static APIRequest POST([APIVersion? apiVersion]) {
    return APIRequest(httpMethod: APIRequestType.POST,
        apiVersion: apiVersion ?? APIVersion.v1);
  }

  static APIRequest PUT([APIVersion? apiVersion]) {
    return APIRequest(httpMethod: APIRequestType.PUT,
        apiVersion: apiVersion ?? APIVersion.v1);
  }
}

