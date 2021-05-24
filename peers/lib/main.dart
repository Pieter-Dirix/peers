
import "package:flutter/material.dart";

void main() => runApp(Peers());

class Peers extends StatelessWidget {

  const Peers({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Peers",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Peers"),
        ),
        body: Center(
          child: SignUpButton(),
        ),
      ),
    );
  }
}

class EmailInput extends StatefulWidget {
  @override
  _EmailInputState createState() => _EmailInputState();
}

class _EmailInputState extends State<EmailInput> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class SignUpButton extends StatefulWidget {
  @override
  _SignUpButtonState createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
  void _signUp() {
    print("tapped");
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
            onPressed: _signUp,
            child: Text("Sign Up")
        ),
      ],
    );
  }
}
