import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peers/models/User.dart';
import 'package:peers/util/DBHelper.dart';

import 'home/Profile.dart';
import 'home/Match.dart';

class Home extends StatefulWidget {
  static const routeName = '/home';

  const Home({Key? key, this.user}) : super(key: key);
  final User? user;

  @override
  _HomeState createState() => _HomeState();
}
// https://stackoverflow.com/questions/51224420/flutter-switching-to-tab-reloads-widgets-and-runs-futurebuilder
class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {
  // static const List<Widget> _pages = [
  //   Match(), Profile()
  // ];
  DBHelper localDB = DBHelper();
  Future<User>? _loadingUser;

  @override
  void initState() {
    _loadingUser = localDB.getUser();
    super.initState();
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget getPage(int index, User user) {
    // Widget page = Profile();
    return IndexedStack(
      index: index,
      children: <Widget>[Match(user: user), Profile(user: user)],
    );

  }

  Widget returnHome() {
    Widget child = Center(
      child: Text("Waiting"),
    );

    return child;
  }

  // source: https://stackoverflow.com/questions/54251317/passing-data-between-pages-with-bottom-navigation-bar-in-flutter/54254019#54254019
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   DBHelper localDB = DBHelper();
  //   localDB.getUser().then((value) => {
  //       setState(() {
  //         widget.user = value;
  //       })
  //   }).catchError((error) {
  //     print(error);
  //     returnToSignIn(this.context);
  //   });
  // }

  Widget _pages() {
    Widget page;
    (widget.user != null)
        ? page = getPage(_selectedIndex, widget.user!)
        : page = new FutureBuilder(
            future: _loadingUser,
            builder: (_, snapshot) {
              print('future builder: $snapshot');

              if (snapshot.connectionState != ConnectionState.done) {
                return Text('waiting');
              }

              if (snapshot.hasError) {
                return Text('Snapshot error: ${snapshot.error}');
              }

              if (snapshot.hasData) {
                return getPage(_selectedIndex, snapshot.data! as User);
              }

              return Text('no data');
            },
          );
    return page;
  }

  @override
  Widget build(BuildContext context) {
    //print('home: ${widget.user!.toString()}');

    return Scaffold(
      body: Center(child: _pages()),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Match"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "Profile"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
