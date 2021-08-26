import "package:flutter/material.dart";
import 'package:peers/models/User.dart';
import 'package:peers/util/DBHelper.dart';
import 'package:peers/view/screens/auth/SignIn.dart';

class Profile extends StatefulWidget {
  static const routeName = '/profile';
  final User? user;

  const Profile({Key? key, this.user}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Logging out failed'),
        action: SnackBarAction(
            label: 'Ok', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void _returnToSignIn(BuildContext context, User u) async {
    DBHelper localDB = DBHelper();
    bool result = await localDB.removeUser(widget.user!);
    if (result) {
      Navigator.pushReplacementNamed(context, SignIn.routeName);
    } else {
      this._showToast(context);
    }
  }

  Widget info() {
    print(widget.user!);
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('${widget.user!.firstname} ${widget.user!.lastname}'),
        Text('${widget.user!.gender}'),
        Text('${widget.user!.school}'),
        Text('${widget.user!.bio}', overflow: TextOverflow.clip,),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          (widget.user != null)
              ? info()
              : Text("iets misgegaan"),
          ElevatedButton(
            child: Text("log out"),
            onPressed: () => _returnToSignIn(context, widget.user!),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      )),
    );
  }
}
