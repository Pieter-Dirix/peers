import 'package:flutter/material.dart';
import 'package:peers/models/User.dart';

class Match extends StatefulWidget {
  static const routeName = '/match';
  final User? user;
  const Match({Key? key, this.user}) : super(key: key);

  @override
  _MatchState createState() => _MatchState();
}

class _MatchState extends State<Match> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: (widget.user != null)? Text(widget.user!.firstname) : Text("iets misgegaan")
      ),
    );
  }
}
