import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:peers/API/API.dart';
import 'package:peers/models/User.dart';
import 'package:peers/api/services/UserRepository.dart';
import 'package:peers/view/screens/Home.dart';
import 'package:peers/view/screens/auth/SignUpCont.dart';

class SignUp extends StatefulWidget {
  static const routeName = '/signup';

  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}



class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _firstnameCont = TextEditingController();
  TextEditingController _lastnameCont = TextEditingController();
  TextEditingController _emailCont = TextEditingController();
  TextEditingController _passwordCont = TextEditingController();

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      User u = User(firstname: _firstnameCont.text, lastname: _lastnameCont.text, email: _emailCont.text, password: _passwordCont.text);
    //  UserRepository().signUp(u.toDB()).then((value) {
        Navigator.of(context).pushReplacementNamed(SignUpCont.routeName, arguments: u);
      // }).catchError((e) {
      //   print("error: $e");
      // });
    }


    // if (_formKey.currentState!.validate()) {
    //   String email = _emailCont.text.trim();
    //   String password = _passwordCont.text.trim();
    //
    //   API.signIn(email, password).then((value) {
    //     Navigator.pushNamed(context, Home.routeName);
    //   }).catchError((e) {
    //     print("error: $e");
    //   });
    // }
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
                "Sign up",
                textDirection: TextDirection.ltr,
                style: TextStyle(
                    fontSize: 24,
                    decoration: TextDecoration.none,
                    color: Colors.black),
              ),
              TextFormField(
                controller: _firstnameCont,
                decoration: InputDecoration(
                  labelText: "first name",
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
              ),TextFormField(
                controller: _lastnameCont,
                decoration: InputDecoration(
                  labelText: "last name",
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
                        child: Text("Next"),
                        onPressed: () => _submitForm(context),
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }
}
