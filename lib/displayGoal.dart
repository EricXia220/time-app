import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:time_app/displaySm.dart';
import 'package:time_app/server.dart';
import 'addGoal.dart';
import 'customizeBg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'displayBg.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'main.dart';
class DisplayGoalPage extends StatefulWidget {
  DisplayGoalPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _DisplayGoalPageState createState() => _DisplayGoalPageState();
}

class _DisplayGoalPageState extends State<DisplayGoalPage> {
  var server = Server();
  var color = Color(0xFF469CAD);
  List<dynamic> entries = new List();
  var bigGoalString;
  var bigGoal;
  var background = 'assets/background4.jpg';
  _DisplayGoalPageState() {
    _showDailyAtTime();
    server.getSmallGoals().then((ds) {
      print(ds.key);
      print(ds.value);
      ds.value.forEach((k, v) {
        print(v);
        print(v['title']);

        setState(() {

          entries.add(v);
        });
      });
    }).catchError((e) {
      print("Failed to get the small goals.");
    });
    server.getBigGoals().then((ds2) {
      print(ds2.key);
      print(ds2.value);
      ds2.value.forEach((k, v) {
        print(v);
        print(v['title']);
        setState(() {
          bigGoalString = v['title'];
          bigGoal = v;
        });
        print("alreayd loaded");
      });
    }).catchError((e) {
      print("Failed to get the big goals.");
    });

      server.updateStreak().then((ds3) {
        print("streak updated");
      }).catchError((e) {
        print("failed to add streak");
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
  Future<void> _showDailyAtTime() async {
    var time = Time(10, 0, 0);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name',
        'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'Goal Reminder',
        'Make Sure to Complete Your Goals', time,
        platformChannelSpecifics);
  }

  Future<void> _showWeeklyAtTime(String title, int hour, int minute) async {
    var time = Time(hour, minute);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name',
        'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
        0,
        'Goal Reminder',
        title, Day.Monday, time,
        platformChannelSpecifics);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
          ),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(
            bottom: 80,
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(

                    padding: EdgeInsets.only(
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                       gradient: LinearGradient(begin: Alignment.topLeft, colors: [Color(0xFF469CAD), Color(0xFF469CAD)]),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        )),
                    child: Container(

                      margin: EdgeInsets.only(
                          top: 40, bottom: 30, left: 40, right: 40),
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      decoration: BoxDecoration(
                          image:
                          DecorationImage(image: AssetImage(background), fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          colors: [Color(0xFF469CAD), Color(0xFF469CAD), ],
                        ),
                      ),
                      child: FlatButton(
                          color: Colors.transparent,
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => displayBgPage(
                                    title: 'big goal',
                                    goal: bigGoal,
                                  ),
                                ));
                          },
                          child: Text(
                            bigGoalString.toString(),
                            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.normal, color: Colors.white,),
                          )),
                    )),
                Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 30,
                    ),
                    alignment: Alignment.topLeft,
                    child: Text("Small Goals",
                        style: TextStyle(
                          fontSize: 22,
                        ))),
                Container(

                  child: Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: entries.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => displaySmPage(
                                            title: 'Goals',
                                            goal: entries[index])),
                                  );
                                },
                                title: Container(
                                  alignment: Alignment.topLeft,
                                  padding: new EdgeInsets.all(10.0),
                                  margin: new EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  height: 50,
                                  color: Colors.white,
                                  child: Center(
                                      child:
                                          Text('${entries[index]["title"]}', style: TextStyle(fontSize: 20),), ),
                                ),
                              ));
                        }),
                  ),
                ),
              ])),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF469CAD),
        elevation: 5.0,
        tooltip: 'Add',
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => addGoalPage(title: 'Add Goals')),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
