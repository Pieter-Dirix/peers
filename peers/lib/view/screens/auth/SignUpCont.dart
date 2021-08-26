import 'package:flutter/material.dart';
import 'package:peers/api/services/UserRepository.dart';
import 'package:peers/models/User.dart';
import 'package:peers/view/screens/Home.dart';
import 'package:peers/view/screens/auth/SignUpImage.dart';
import 'package:flutter/services.dart';

class SignUpCont extends StatefulWidget {
  static const routeName = '/signupcont';

  const SignUpCont({Key? key, this.user}) : super(key: key);

  final User? user;

  @override
  _SignUpContState createState() => _SignUpContState();
}

class _SignUpContState extends State<SignUpCont> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _schoolCont = TextEditingController();
  TextEditingController _bioCont = TextEditingController();
  String _gender = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _gender = 'Other';
  }

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {

      widget.user!.school = _schoolCont.text;
      widget.user!.bio = _bioCont.text;
      widget.user!.gender = _gender;
      User u = User(
          firstname: widget.user!.firstname,
          lastname: widget.user!.lastname,
          email: widget.user!.email,
          password: widget.user!.password,
          bio: _bioCont.text,
          gender: this._gender,
          school: _schoolCont.text
      );
      print(u);
      // User u = User(firstname: _firstnameCont.text,
      //     lastname: _lastnameCont.text,
      //     email: _emailCont.text,
      //     password: _passwordCont.text);
      UserRepository().signUp(u.toDB()).then((value) {
        Navigator.of(context)
            .pushReplacementNamed(Home.routeName, arguments: value);
      }).catchError((e) {
        print("error: $e");
      });
    }
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
            "Extra Info",
            textDirection: TextDirection.ltr,
            style: TextStyle(
                fontSize: 24,
                decoration: TextDecoration.none,
                color: Colors.black),
          ),
          DropdownButton<String>(
            value: this._gender,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              color: Colors.blueGrey,
            ),
            onChanged: (String? newValue) {
              setState(() {
                _gender = newValue!;
              });
            },
            items: <String>['Man', 'Woman', 'Non-Binary', 'Other']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          TextFormField(
            controller: _schoolCont,
            decoration: InputDecoration(
              labelText: "School/University",
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
            keyboardType: TextInputType.multiline,
            minLines: 4,
            maxLines: null,
            maxLength: 250,
            controller: _bioCont,
            decoration: InputDecoration(
              labelText: "Bio",
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
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text("Submit"),
                onPressed: () => _submitForm(context),
              ),
            ],
          ))
        ],
      ),
    ));
  }
}
