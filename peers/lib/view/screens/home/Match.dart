import 'package:flutter/material.dart';
import 'package:peers/api/services/EventRepository.dart';
import 'package:peers/models/Event.dart';
import 'package:peers/models/Tags.dart';
import 'package:peers/models/User.dart';
import 'package:peers/util/DBHelper.dart';
import 'package:peers/view/screens/home/event/CreateEvent.dart';

class Match extends StatefulWidget {
  static const routeName = '/match';
  final User? user;

  const Match({Key? key, this.user}) : super(key: key);

  @override
  _MatchState createState() => _MatchState();
}

class _MatchState extends State<Match> {
  EventRepository eventRepository = EventRepository();
  Future<List>? _loadingEvents;

  @override
  void initState() {
    // setState(() {
    //   _loadingEvents = eventRepository.getEvents(
    //       widget.user!.id!, [Tags.music.toString().split('.').elementAt(1)]);
    // });
    super.initState();
  }

  Widget body() {
    return FutureBuilder(
      future: eventRepository.getEvents(
          widget.user!.id!, [Tags.music.toString().split('.').elementAt(1)]),
      builder: (_, snapshot) {
        print('future builder: $snapshot');

        if (snapshot.connectionState != ConnectionState.done) {
          return SizedBox(
            child: CircularProgressIndicator(),
            width: 60,
            height: 60,
          );
        }

        if (snapshot.hasError) {
          return Text('Snapshot error: ${snapshot.error}');
        }

        if (snapshot.hasData) {
          List e = snapshot.data as List;

          return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: e.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                Event event = e[index];
                return Container(margin: EdgeInsets.only(bottom: 16.0, left: 16.0, right:  16.0 ),child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Title(
                              color: Colors.black,
                              child: Text(
                                event.name,
                                textAlign: TextAlign.left,
                              ),
                            )),
                        Expanded(
                            child: Text(
                              event.date,
                              textAlign: TextAlign.right,
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                              event.location,
                              textAlign: TextAlign.left,
                            )),
                        Expanded(
                            child: Text(
                              event.description,
                              textAlign: TextAlign.right,
                            )),
                      ],
                    ),
                  ],
                ),);
              });
          // return Column(children: [
          //   Row(
          //     children: [
          //       Expanded(child: Text('${e.name}',textAlign: TextAlign.left,)),
          //       Expanded(child: Text('${e.date}',textAlign: TextAlign.right,)),
          //     ],
          //   ),
          //   Row(
          //     children: [
          //       Expanded(child: Text('${e.name}',textAlign: TextAlign.left,)),
          //       Expanded(child: Text('${e.date}',textAlign: TextAlign.right,)),
          //     ],
          //   )
          // ],);
        }

        return Text('no data');
      },
    );
  }

  void onPressed(BuildContext context) {
    Navigator.of(context)
        .pushNamed(CreateEvent.routeName, arguments: widget.user!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: (widget.user != null) ? body() : Text("iets misgegaan")),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => onPressed(context), label: Text('Add event')),
    );
  }
}
