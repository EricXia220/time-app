import 'package:flutter/material.dart';
import 'package:time_app/customizeBg.dart';
import 'customizeBg.dart';
import 'home.dart';
import 'server.dart';

class displayBgPage extends StatefulWidget {
  displayBgPage({Key key, this.title, this.goal}) : super(key: key);
  final String title;
  var goal;
  @override
  _displayBgPageState createState() => _displayBgPageState();
}

class _displayBgPageState extends State<displayBgPage> {
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
            Container(child: Text('${widget.goal["title"]}')),
            Container(
                child: Text("Difficulty: " + '${widget.goal["difficulty"]}')),
            OutlineButton(
                child: new Text("Change Goal"),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            customizeBgPage(title: 'customize big goal'),
                      ));
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0))),
            OutlineButton(

                child: new Text("Complete"),
                onPressed: () {
                  server.completeBg().then((d) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              customizeBgPage(title: 'customize your new big goal'),
                        )); server.setRank();
                  }).catchError((e) {
                    print('Failed to complete ' + e.toString());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0))),
          ],
        ),
      ),
    );
  }
}
