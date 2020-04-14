import 'package:flutter/material.dart';
import 'myAccount.dart';
import 'social.dart';
import 'setReminder.dart';
import 'displayGoal.dart';
import 'package:google_fonts/google_fonts.dart';
import 'server.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:gradient_bottom_navigation_bar/gradient_bottom_navigation_bar.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'main.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.selectedIndex}) : super(key: key);
  final String title;
  var selectedIndex;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState() {
    _init_notifications();
  }

  final List<Widget> _widgetOptions = <Widget>[
    SocialPage(title: "Social"),
    DisplayGoalPage(title: "Goal"),
    MyAccountPage(title: "Account")
  ];
  void _onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
  }

  void _init_notifications() {
    print("Initializing the periodic notification");
    // Show a notification every minute with the first appearance happening a minute after invoking the method
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'repeating channel id',
        'repeating channel name',
        'repeating description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    flutterLocalNotificationsPlugin.periodicallyShow(
        0,
        'Goal Reminder',
        'Check Your Goal',
        RepeatInterval.EveryMinute,
        platformChannelSpecifics);
  }

  void _show_notification_once() {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    flutterLocalNotificationsPlugin.show(
        0, 'Goal Reminder', 'Check Your Goal', platformChannelSpecifics,
        payload: 'Item 1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(widget.selectedIndex),
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
