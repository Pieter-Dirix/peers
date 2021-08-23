import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:peers/api/services/BaseService.dart';
import 'package:http/http.dart' as http;

import '../api_exception.dart';

class UserService extends BaseService {
  @override
  Future getResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(baseUrl + url));
      responseJson = returnResponse(response);
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
      if (!body.containsKey("pfp")) {
        final response = await http.post(uri,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(body));
        responseJson = returnResponse(response);
      } else {
        File file = body['pfp'];
        var stream = new http.ByteStream(file.openRead())..cast();
        var length = await file.length();

        var multipartFile = http.MultipartFile('pfp', stream, length,
            filename: basename(file.path));

        var request = new http.MultipartRequest("POST", uri);

        request.files.add(multipartFile);
        request.fields['id'] = body['id'];
        request.fields['firstname'] = body['firstname'];
        request.fields['lastname'] = body['lastname'];
        request.fields['email'] = body['email'];
        request.fields['gender'] = body['gender'];
        request.fields['school'] = body['school'];
        request.fields['bio'] = body['bio'];

        final response = await request.send();

        responseJson = returnResponse(await http.Response.fromStream(response));
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
