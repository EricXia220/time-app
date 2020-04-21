import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:time_app/customizeBg.dart';
import 'package:time_app/home.dart';
import 'customizeBg.dart';
import 'server.dart';

class displaySmPage extends StatefulWidget {
  displaySmPage({Key key, this.title, this.goal}) : super(key: key);
  final String title;
  var goal;
  @override
  _displaySmPageState createState() => _displaySmPageState();
}

class _displaySmPageState extends State<displaySmPage> {
  var server = Server();
  var newTime = new DateTime.fromMillisecondsSinceEpoch(
      new DateTime.now().millisecondsSinceEpoch);
  Function completeButtonAction() {
    var lastTime = new DateTime.fromMillisecondsSinceEpoch(
        widget.goal['lastCompletionTime']);
    if (lastTime.day == newTime.day) {
      print("Already completed");
      print(newTime.day);
      print(lastTime.day);
    } else {
      print("Complete");

      setState(() {
        server.completeSm(widget.goal["id"]);
        server.setLastCompletionTime(widget.goal["id"]);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(
                title: 'Home',
                selectedIndex: 1,
              ),
            ));
        server.setRank();
        server.addStreak();
      });
      print(newTime.day);
      print(lastTime.day);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage('assets/background1.jpg'), fit: BoxFit.cover)),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.black.withOpacity(.3),
                Colors.black.withOpacity(.3),
              ]),
            ),
            child: Padding(
              padding: EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )),
                  ),
                  Text(
                    '${widget.goal["title"]}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Streaks",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      Text(
                        '${widget.goal["streak"]}',
                        style: TextStyle(
                            color: Colors.yellow[400],
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Difficulty",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      Text(
                        '${widget.goal["difficulty"]}',
                        style: TextStyle(
                            color: Colors.yellow[400],
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Remind time",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      Text(
                        '${widget.goal["time"]}',
                        style: TextStyle(
                            color: Colors.yellow[400],
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    child: FlatButton(
                        child: new Text(
                          "Complete",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        onPressed: completeButtonAction,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0))),
                  ),
                  Align(
                    child: FlatButton(
                        child: new Text(
                          "Remove",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        onPressed: () {
                          server.deleteSmallGoal(widget.goal["id"]).then((d) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(
                                    title: 'Home',
                                    selectedIndex: 1,
                                  ),
                                ));
                          }).catchError((e) {
                            print('Failed to remove ' +
                                e.toString() +
                                "/" +
                                "sm" +
                                "/" +
                                "sm-" +
                                widget.goal["id"].toString());
                          });
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0))),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
