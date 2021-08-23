import 'package:flutter/material.dart';
import 'package:peers/api/services/UserRepository.dart';
import 'package:peers/models/User.dart';
import 'package:peers/view/screens/auth/SignUp.dart';

import '../Home.dart';

class SignIn extends StatefulWidget {
  static const routeName = '/signin';

  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailCont = TextEditingController();
  TextEditingController _passwordCont = TextEditingController();
  User? user;

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String email = _emailCont.text.trim();
      String password = _passwordCont.text.trim();
      UserRepository().signIn(email, password).then((value) {
        print('sign in: ${value.toString()}');
        //https://stackoverflow.com/questions/53304340/navigator-pass-arguments-with-pushnamed
        Navigator.of(context).pushReplacementNamed(Home.routeName, arguments: value);
        // Navigator.pushReplacementNamed(context, Home.routeName, arguments: value);
      }).catchError((e) {
        print("error: $e");
      });
    }
  }

  void _register(BuildContext context) {
    Navigator.pushNamed(context, SignUp.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Sign in",
            textDirection: TextDirection.ltr,
            style: TextStyle(
                fontSize: 24,
                decoration: TextDecoration.none,
                color: Colors.black),
          ),
          TextFormField(
            controller: _emailCont,
            decoration: InputDecoration(
              labelText: "email",
              labelStyle: Theme.of(context).textTheme.headline6,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            obscureText: true,
            controller: _passwordCont,
            decoration: InputDecoration(
                labelText: "password",
                labelStyle: Theme.of(context).textTheme.headline6,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text("Submit"),
                onPressed: () => _submitForm(context),
              ),
              ElevatedButton(
                child: Text("Register"),
                onPressed: () => _register(context),
              ),
            ],
          ))
        ],
      ),
    ));
  }

// FutureBuilder<User> buildUserBuilder() {
//   return FutureBuilder<User>(
//     future: _futureUser,
//     builder: (context, snapshot) {
//       if (snapshot.hasData) {
//         return Text('user ${snapshot.data!.firstname} ${snapshot.data!
//             .lastname} is nog logged in');
//       } else if (snapshot.hasError) {
//         return Text('${snapshot.error}');
//       }
//
//       return CircularProgressIndicator();
//     },
//   );
// }
}
