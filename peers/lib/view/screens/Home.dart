import 'package:flutter/material.dart';
import 'package:peers/models/User.dart';

class Home extends StatefulWidget {
  static const routeName = '/home';

  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {

    return Center(
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Text(
          "Home",
          textDirection: TextDirection.ltr,
          style:
              TextStyle(decoration: TextDecoration.none, color: Colors.black),
        ),
      ),
    );
  }
}
