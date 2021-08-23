import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peers/api/services/UserRepository.dart';
import 'package:peers/models/User.dart';
import 'package:peers/view/screens/Home.dart';

class SignUpImage extends StatefulWidget {
  static const routeName = '/signupimage';

  const SignUpImage({Key? key, this.user}) : super(key: key);

  final User? user;

  @override
  _SignUpImageState createState() => _SignUpImageState();
}

class _SignUpImageState extends State<SignUpImage> {
  File? _image;

  _imgFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    _picker.pickImage(source: ImageSource.gallery).then((value) {
      setState(() {
        final path = value!.path;
        final bytes = File(path);
        _image = bytes;
      });
    }).catchError((e) {
      print(e.toString());
    });
  }

  String _initials(User user) {
    String result = '';
    result =
        '${user.firstname[0].toUpperCase()}${user.lastname[0].toUpperCase()}';
    return result;
  }

  void _submitImage(BuildContext context) {
    if(_image != null) {
      Map<String, dynamic> user = widget.user!.toDB();
      user['pfp'] = this._image!;
      UserRepository().signUp(user).then((value) {
        Navigator.of(context)
            .pushReplacementNamed(Home.routeName, arguments: value);

      }).catchError((e){
        print(e.toString());
      });
      // Navigator.of(context)
      //     .pushReplacementNamed(Home.routeName, arguments: widget.user!);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (this._image != null)
              ? CircleAvatar(
                  radius: 100,
                  backgroundImage: Image.file(_image!).image,

                )
              : CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey,
                  child: Text(_initials(widget.user!)),
                ),
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text("Add profile picture"),
                onPressed: () => _imgFromGallery(),
              ),
            ],
          )),
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text("Submit"),
                onPressed: () => _submitImage(context),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
