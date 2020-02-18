import 'package:flutter/material.dart';
import 'setReminder.dart';

class customizePage extends StatefulWidget {
  customizePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _customizePageState createState() => _customizePageState();
}

class _customizePageState extends State<customizePage> {
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
                      obscureText: true,
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
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Difficulty',
                      ))),
            ]),
            Container(
                child: OutlineButton(
                    child: new Text("Confirm"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SetReminderPage(title: 'Set Reminder')),
                      );
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)))),
          ],
        ),
      ),
    );
  }
}
