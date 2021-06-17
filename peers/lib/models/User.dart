import 'package:objectid/objectid.dart';

class User {
  final String? id;
  final String firstname;
  final String lastname;
  final String email;
  final String? accessToken;
  final String? password;

  User(
      {required this.firstname,
      required this.lastname,
      required this.email,
      this.accessToken,
      this.id,
      this.password});

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      accessToken: json['accessToken'],
    );
  }

  factory User.fromLocalDB(Map<dynamic, dynamic> json) {
    return User(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "accessToken": accessToken
      };

  Map<String, dynamic> toLocalDB() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
      };
  Map<String, dynamic> toDB() => {
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "password": password
  };
}
