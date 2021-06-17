import "package:flutter/material.dart";
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:peers/view/screens/auth/SignIn.dart';
import 'package:peers/view/screens/Home.dart';
import 'package:peers/view/screens/auth/SignUp.dart';

import 'Models/User.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Widget _home = SignIn();
  bool token = await tokenInSecureStorage();
  if(token) {
    _home = Home();
  }
  runApp(Peers(home: _home));
}

Future<bool> tokenInSecureStorage() async {
  final storage = new FlutterSecureStorage();
  String? value = await storage.read(key: "accessToken");
  print(value);

  if (value != null) {
    return Future<bool>.value(true);
  }
  return Future<bool>.value(false);
}

class Peers extends StatelessWidget {
  const Peers({Key? key, required this.home}) : super(key: key);
  final Widget home;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Peers",
      home: home,
      routes: {
        Home.routeName: (context) => Home(),
        SignIn.routeName: (context) => SignIn(),
        SignUp.routeName: (context) => SignUp(),
      },
    );
  }
}
