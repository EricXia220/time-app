import 'package:flutter/material.dart';
import 'myAccount.dart';
import 'social.dart';
import 'setReminder.dart';
import 'displayGoal.dart';
import 'package:google_fonts/google_fonts.dart';
import 'server.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:gradient_bottom_navigation_bar/gradient_bottom_navigation_bar.dart';
class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.selectedIndex}) : super(key: key);
  final String title;
  var selectedIndex;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


    final List<Widget> _widgetOptions= <Widget>[
      SocialPage(title: "Social"),
      DisplayGoalPage(title: "Goal"),
      MyAccountPage(title: "Account")
    ];
    void _onItemTapped(int index) {
      setState(() {
        widget.selectedIndex = index;
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center( child: _widgetOptions.elementAt(widget.selectedIndex),
          ),
      bottomNavigationBar: BottomNavigationBar(

        backgroundColor: Color(0xFF469CAD),
        type: BottomNavigationBarType.fixed,

        unselectedItemColor: Colors.white60,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            title: Text('Social'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_available),
            title: Text('Goal'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Account'),
          ),
        ],
        currentIndex: widget.selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
