import 'package:flutter/material.dart';
import 'server.dart';
class SocialPage extends StatefulWidget {
  SocialPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SocialPageState createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  var server = Server();
  List <dynamic> users = new List();
  _SocialPageState() {
    server.getUsers().then((ds) {

      ds.value.forEach((k, v) {
        print(k);
        print(v["points"]);
        setState(() {
          users.add(v);
        });
      });
    }).catchError((e) {
      print("Failed to get users.");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: new EdgeInsets.all(15.0),
              padding: new EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.lightBlue,
              ),
              child: Text(
                'Rank',
                style: TextStyle(fontSize: 30.0),
              ),
              alignment: Alignment(0.0, 0.0),
            ),
            Container(
              margin: new EdgeInsets.all(15.0),
              padding: new EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.lightBlue,
              ),
              child: Row(children: <Widget>[
                Expanded(
                    flex: 1,
                    child: CircleAvatar(
                        backgroundColor: Colors.grey.shade800,
                        child: Text('AH',
                            style: new TextStyle(
                                fontSize: 10.0, color: Colors.blue)),
                        radius: 25)),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      'User 1',
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ),
                ),
              ]),
            ),
            Container(
              margin: new EdgeInsets.all(15.0),
              padding: new EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.lightBlue,
              ),
              child: Row(children: <Widget>[
                Expanded(
                    flex: 1,
                    child: CircleAvatar(
                        backgroundColor: Colors.grey.shade800,
                        child: Text('AH',
                            style: new TextStyle(
                                fontSize: 10.0, color: Colors.blue)),
                        radius: 25)),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      'User 2',
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ),
                ),
              ]),
            ),
            Container(
              margin: new EdgeInsets.all(15.0),
              padding: new EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.lightBlue,
              ),
              child: Row(children: <Widget>[
                Expanded(
                    flex: 1,
                    child: CircleAvatar(
                        backgroundColor: Colors.grey.shade800,
                        child: Text('AH',
                            style: new TextStyle(
                                fontSize: 10.0, color: Colors.blue)),
                        radius: 25)),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      'User 3',
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
