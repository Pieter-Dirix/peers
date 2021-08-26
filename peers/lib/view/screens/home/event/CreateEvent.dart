import 'package:flutter/material.dart';
import 'package:peers/api/services/EventRepository.dart';
import 'package:peers/models/Event.dart';
import 'package:peers/models/Tags.dart';
import 'package:peers/models/User.dart';
import 'package:flutter/services.dart';

class CreateEvent extends StatefulWidget {
  static const routeName = '/createevent';
  final User? user;

  const CreateEvent({Key? key, this.user}) : super(key: key);

  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameCont = TextEditingController();
  TextEditingController _locationCont = TextEditingController();
  TextEditingController _descriptionCont = TextEditingController();
  TextEditingController _dateCont = TextEditingController();

  // Map<int, bool> _selectedTags = {};

  // @override
  // void initState() {
  //   setState(() {
  //     _selectedTags = tagsToMap();
  //   });
  //   super.initState();
  // }

  // Widget checkBoxes() {
  //   List<Widget> boxes = [];
  //   Tags.values.forEach((tag) {
  //     //print(tag.toString().split('.').elementAt(1));
  //     boxes.add(CheckboxListTile(
  //       value: _selectedTags[tag.index],
  //       onChanged: (value) =>
  //       {
  //         //
  //         // if (value! == true) {
  //
  //         // }  else {
  //         //   setState(() {
  //         //     _selectedTags.remove(tag.toString().split('.').elementAt(1));
  //         //   })
  //         // }
  //         // _onTagSelected(value!, tag)
  //       },
  //       title: Text(tag.toString().split('.').elementAt(1)),
  //     ));
  //   });
  //   return Column(
  //     children: boxes,
  //   );
  // }


  // Map<int, bool> tagsToMap() {
  //   Map<int, bool> tags = {};
  //   Tags.values.forEach((element) {
  //     tags[element.index] = false;
  //   });
  //   return tags;
  // }

  // https://stackoverflow.com/questions/45153204/how-can-i-handle-a-list-of-checkboxes-dynamically-created-in-flutter


  int enumSize() {
    int s = 0;
    Tags.values.forEach((element) {
      s++;
    });
    print(s);
    return s;
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      print(widget.user!.id);
      Map<String, dynamic> event = {
        'name': _nameCont.text,
        'description': _descriptionCont.text,
        'location': _locationCont.text,
        'date': _dateCont.text,
        'tags': [Tags.music.toString().split('.').elementAt(1)],
        'userId': widget.user!.id!
      };
      EventRepository().addEvent(event).then((value) {
        Navigator.of(context).pop();
      }).catchError((e) {
        print(e.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: ListView(
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text('Create event'),
                    TextFormField(
                      controller: _nameCont,
                      decoration: InputDecoration(
                        labelText: "Name",
                        labelStyle: Theme
                            .of(context)
                            .textTheme
                            .headline6,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _locationCont,
                      decoration: InputDecoration(
                        labelText: "Location",
                        labelStyle: Theme
                            .of(context)
                            .textTheme
                            .headline6,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _descriptionCont,
                      decoration: InputDecoration(
                        labelText: "Description",
                        labelStyle: Theme
                            .of(context)
                            .textTheme
                            .headline6,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _dateCont,
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(10)
                      ],
                      decoration: InputDecoration(
                        hintText: "dd/mm/yyyy",
                        labelText: "Date",
                        labelStyle: Theme
                            .of(context)
                            .textTheme
                            .headline6,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        // if (value.length < 10) {
                        //   return 'Please fill in correctly';
                        // }
                        return null;
                      },
                    ),
                  ],
                )),
            // checkBoxes(),
            // ListView.builder(
            //     scrollDirection: Axis.vertical,
            //     shrinkWrap: true,
            //     itemCount: enumSize(),
            //     physics: NeverScrollableScrollPhysics(),
            //     itemBuilder: (BuildContext context, int index) {
            //       print(Tags.values[index].index);
            //       return CheckboxListTile(
            //         value: _selectedTags[Tags.values[index].index],
            //         onChanged: (value) =>
            //         {
            //           setState(() {
            //             _selectedTags[Tags.values[index].index] = value!;
            //           })
            //           // _onTagSelected(value!, Tags.values[index])
            //         },
            //         title: Text(
            //             Tags.values[Tags.values[index].index].toString().split('.').elementAt(1)),
            //       );
            //     }),
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
        ));
  }
}
