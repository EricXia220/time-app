import 'package:flutter/material.dart';
import 'package:time_app/home.dart';
import 'server.dart';

class customizeBgPage extends StatefulWidget {
  customizeBgPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _customizeBgPageState createState() => _customizeBgPageState();
}

class _customizeBgPageState extends State<customizeBgPage> {
  var goalTitleController = TextEditingController();
  var difficultyController = TextEditingController();
  var server = Server();
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
            Row(children: <Widget>[
              Expanded(
                flex: 1,
                child: Text(
                  "Name: ",
                  textAlign: TextAlign.right,
                ),
              ),
              Expanded(
                  flex: 3,
                  child: TextField(
                      controller: goalTitleController,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ))),
            ]),
            Row(children: <Widget>[
              Expanded(
                flex: 1,
                child: Text(
                  "Difficulty: ",
                  textAlign: TextAlign.right,
                ),
              ),
              Expanded(
                  flex: 3,
                  child: TextField(
                      controller: difficultyController,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Difficulty',
                      ))),
            ]),
            Container(
                child: OutlineButton(
                    child: new Text("Confirm"),
                    onPressed: () {
                      server
                          .addBigGoal(goalTitleController.text.toString(),
                              difficultyController.text.toString())
                          .then((a) {
                        print("small goal added");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(title: 'Home'),
                            ));
                      }).catchError((a) {
                        print("There is an error");
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)))),
          ],
        ),
      ),
    );
  }
}
