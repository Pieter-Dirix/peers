import "package:flutter/material.dart";

void main() => runApp(Peers());

class Peers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Peers",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Peers"),
        ),
        body: Center(
          child: Text("Hello World"),
        ),
      ),
    );
  }
}
