import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:peers/api/api_exception.dart';
import 'package:peers/api/services/BaseService.dart';

class EventService extends BaseService {
  final storage = new FlutterSecureStorage();

  @override
  Future getResponse(String url) async {
    dynamic responseJson;
    try {
      String? token = await storage.read(key: "accessToken");
      if (token != null) {
        final response = await http.get(Uri.parse(baseUrl + url),
            headers: <String, String>{'x-access-token': token});
        responseJson = returnResponse(response);
      } else {
        throw "No access token";
      }
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future postRequest(String url, Map<String, dynamic> body) async {
    dynamic responseJson;
    Uri uri = Uri.parse(baseUrl + url);
    try {
      String? token = await storage.read(key: "accessToken");

      if (token != null) {
        final response = await http.post(uri,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-access-token': token
            },
            body: jsonEncode(body));
        responseJson = returnResponse(response);
      } else {
        throw "No access token";
      }

      //print(responseJson);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }
}
