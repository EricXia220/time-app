import 'package:flutter/material.dart';
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
  var newTime = new DateTime.fromMillisecondsSinceEpoch(new DateTime.now().millisecondsSinceEpoch);
  Function completeButtonAction() {
    var lastTime = new DateTime.fromMillisecondsSinceEpoch(widget.goal['lastCompletionTime']);
    if (lastTime.day == newTime.day)
      {print("Already completed");
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
                builder: (context) =>
                    HomePage(title: 'Home', selectedIndex: 1,),
              ));
          server.setRank(); server.addStreak();
        });
      print(newTime.day);
      print(lastTime.day);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                child: Text(
              '${widget.goal["title"]}',
            )),
            Container(
              child: Text(
                 "Streak: " + '${widget.goal["streak"]}'
              )
            ),
            Container(
              child: Text(
                "Difficulty: " + '${widget.goal["difficulty"]}'
              )
            ),
            Container(
              child: Text(
                "Remind time: " + '${widget.goal["time"]}'
              )
            ),
            OutlineButton(
                child: new Text("Complete"),
                onPressed: completeButtonAction,
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
            ),
            OutlineButton(
                child: new Text("Remove"),
                onPressed: () {
                  server.deleteSmallGoal(widget.goal["id"]).then((d){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HomePage(title: 'Home', selectedIndex: 1,),
                        ));
                  }).catchError(
                          (e) {
                        print('Failed to remove ' + e.toString() +  "/" + "sm" + "/" + "sm-" + widget.goal["id"].toString());
                      }
                  );

                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0))),
          ],
        ),
      ),

    );
  }
}
