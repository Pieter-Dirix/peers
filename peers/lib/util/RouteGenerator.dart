import 'package:flutter/material.dart';
import 'package:peers/models/User.dart';
import 'package:peers/util/DBHelper.dart';
import 'package:peers/util/SecureStorage.dart';
import 'package:peers/view/screens/auth/SignIn.dart';
import 'package:peers/view/screens/auth/SignUp.dart';
import 'package:peers/view/screens/Home.dart';
import 'package:peers/view/screens/auth/SignUpCont.dart';
import 'package:peers/view/screens/auth/SignUpImage.dart';
import 'package:peers/view/screens/home/Match.dart';
import 'package:peers/view/screens/home/Profile.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    SecureStorage secureStorage = SecureStorage();

    final args = settings.arguments;
    print('type: ${args.runtimeType}');
    switch (settings.name) {

      case Home.routeName:
        if (args is User) {
          print('route generator: ${args.toString()}');
          return MaterialPageRoute(builder: (context) => Home(user: args));
        } else {
          return MaterialPageRoute(builder: (context) => Home());
        }
          // return _errorRoute();
      case SignIn.routeName:
        return MaterialPageRoute(builder: (context) => SignIn());
      case SignUp.routeName :
        return MaterialPageRoute(builder: (context) => SignUp());

      case SignUpCont.routeName :
      if (args is User) {
        print('route generator: ${args.toString()}');
        return MaterialPageRoute(builder: (context) => SignUpCont(user: args));
      } else {
        return MaterialPageRoute(builder: (context) => SignUpCont());
      }

      case SignUpImage.routeName:
        if (args is User) {
          print('route generator: ${args.toString()}');
          return MaterialPageRoute(builder: (context) => SignUpImage(user: args));
        } else {
          return MaterialPageRoute(builder: (context) => SignUpImage());
        }
      default:
        return _errorRoute();

      // DBHelper localDB = DBHelper();
      //
      // WidgetsFlutterBinding.ensureInitialized();
      //
      // bool token = await secureStorage.tokenInSecureStorage();
      //
      // if (token) {
      //   localDB.getUser().then((value) {
      //     runApp(Peers(home: Home(user: value)));
      //   });
      // } else {
      //   runApp(Peers(home: SignIn()));
      // }

    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
