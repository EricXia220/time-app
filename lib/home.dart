import 'package:flutter/material.dart';
import 'myAccount.dart';
import 'social.dart';
import 'setReminder.dart';
import 'displayGoal.dart';
import 'package:google_fonts/google_fonts.dart';
import 'server.dart';
class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


    int _selectedIndex = 1;
    final List<Widget> _widgetOptions= <Widget>[
      SocialPage(title: "Social"),
      DisplayGoalPage(title: "Goal"),
      MyAccountPage(title: "Account")
    ];
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center( child: _widgetOptions.elementAt(_selectedIndex),
          ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Social'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('Account'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
