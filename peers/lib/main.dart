import "package:flutter/material.dart";
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:peers/util/DBHelper.dart';
import 'package:peers/util/SecureStorage.dart';
import 'package:peers/util/RouteGenerator.dart';
import 'package:peers/view/screens/auth/SignIn.dart';
import 'package:peers/view/screens/auth/SignUp.dart';
import 'package:peers/view/screens/Home.dart';
import 'package:peers/view/screens/home/Match.dart';
import 'package:peers/view/screens/home/Profile.dart';

import 'Models/User.dart';

SecureStorage secureStorage = SecureStorage();

void main() async {


  WidgetsFlutterBinding.ensureInitialized();

  bool token = await secureStorage.tokenInSecureStorage();
 // final MyApp myApp = MyApp(
    //   initialRoute: isLogged ? '/home' : '/',
    // );
    // runApp(myApp);
  final Peers peers = Peers(
    initialRoute: (token)? '/home' : '/signin'
  );
  runApp(peers);
}

class Peers extends StatelessWidget {
  const Peers({Key? key, required this.initialRoute}) : super(key: key);
  final String initialRoute;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Peers",
      initialRoute: this.initialRoute,
      onGenerateRoute: RouteGenerator.generateRoute,
      // home: home,
      // routes: {
      //   Home.routeName: (context) => Home(),
      //   SignIn.routeName: (context) => SignIn(),
      //   SignUp.routeName: (context) => SignUp(),
      //   Match.routeName: (context) => Match(),
      //   Profile.routeName: (context) => Profile()
      // },
    );
  }
}
