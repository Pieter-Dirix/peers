// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:peers/models/User.dart';
// import 'package:http/http.dart' as http;
// import 'package:peers/API/api_exception.dart';
// import 'package:peers/API/Services/BaseService.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:peers/util/DBHelper.dart';
// // api connection : https://github.com/jitsm555/Flutter-MVVM/blob/master/
//
// DBHelper localDB = DBHelper();
//
// class API {// extends BaseService{
//
//   Future<dynamic> post(String url, Map<String, dynamic> body) async {
//     dynamic responseJson;
//     try {
//       final response = await http.post(
//         Uri.parse(baseUrl + url),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(body)
//       );
//       responseJson = returnResponse(response);
//     } on SocketException {
//       throw FetchDataException("No Internet Connection");
//     }
//     return responseJson;
//   }
//
//   dynamic returnResponse(http.Response response) {
//     switch (response.statusCode) {
//       case 200:
//         dynamic responseJson = jsonDecode(response.body);
//         return responseJson;
//       case 400:
//         throw BadRequestException(response.body.toString());
//       case 401:
//       case 403:
//         throw UnauthorisedException(response.body.toString());
//       case 500:
//       default:
//         throw FetchDataException(
//             'Error occured while communication with server' +
//                 ' with status code : ${response.statusCode}');
//     }
//   }
//
//
//   //@override
//   Future getResponse(String url) async {
//     dynamic responseJson;
//     try {
//       final response = await http.get(Uri.parse(baseUrl + url));
//       responseJson = returnResponse(response);
//     } on SocketException {
//       throw FetchDataException('No Internet Connection');
//     }
//     return responseJson;
//   }
//
//   // static Future<User> signUp(String email, String password) async {
//   //   final storage = new FlutterSecureStorage();
//   //   final response = await http.post(Uri.parse(baseUrl + '/signin'),
//   //       headers: <String, String>{
//   //         'Content-Type': 'application/json; charset=UTF-8',
//   //       },
//   //       body: jsonEncode(<String, String>{"email": email, "password": password}));
//   //
//   //   if (response.statusCode == 200) {
//   //     User loggedInUser = User.fromJson(jsonDecode(response.body));
//   //     await storage.write(key: "accessToken", value: loggedInUser.accessToken);
//   //     await storage.write(key: "id", value: loggedInUser.id);
//   //     localDB.insertUser(loggedInUser);
//   //     return loggedInUser;
//   //   } else {
//   //     print(response.statusCode);
//   //     throw Exception("Login failed");
//   //   }
//   //}
//
//   static Future<User> signIn(String email, String password) async {
//     final storage = new FlutterSecureStorage();
//     final response = await http.post(Uri.parse('http://10.0.2.2:8000/signin'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(<String, String>{"email": email, "password": password}));
//
//     if (response.statusCode == 200) {
//       User loggedInUser = User.fromJson(jsonDecode(response.body));
//       await storage.write(key: "accessToken", value: loggedInUser.accessToken);
//       await storage.write(key: "id", value: loggedInUser.id);
//       localDB.insertUser(loggedInUser);
//       return loggedInUser;
//     } else {
//       print(response.statusCode);
//       throw Exception("Login failed");
//     }
//   }
// }
//
//
//
