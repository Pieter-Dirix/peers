
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:peers/models/User.dart';
import 'package:peers/api/services/BaseService.dart';
import 'package:peers/api/services/UserService.dart';
import 'package:peers/util/DBHelper.dart';

DBHelper localDB = DBHelper();

class UserRepository {
  BaseService _userService = UserService();

  Future<User> signIn(String email, String password) async {
    final storage = new FlutterSecureStorage();

    Map<String, dynamic> body = {"email": email, "password": password};

    dynamic response = await _userService.postRequest("/signin", body);

    User user = User.fromJson(response);

    await storage.write(key: "accessToken", value: user.accessToken);
    await storage.write(key: "id", value: user.id);


    await localDB.insertUser(user);

    return user;
  }

  
  Future<User> signUp(Map<String, dynamic> user) async {
    print('repo: $user' );
    User u;
    try {
      dynamic signUpResp = await _userService.postRequest("/signup", user);


      u = User.fromJson(signUpResp);
      User result = await this.signIn(u.email, user["password"]);
      return result;
    } catch (e) {
      print(e.toString());
      throw ("Sign up failed");
    }
  }

}
