import 'package:flutter/material.dart';
import 'package:time_app/login.dart';
import 'server.dart';

class MyAccountPage extends StatefulWidget {
  MyAccountPage({Key key, this.title}) : super(key: key);
  final String title;
  var server = Server();
  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  var server = Server();

  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                child: CircleAvatar(
                    backgroundColor: Colors.grey.shade800,
                    child: Text('AH',
                        style:
                            new TextStyle(fontSize: 30.0, color: Colors.blue)),
                    radius: 50)),
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
              child: Text(
                'Streak',
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
              child: Text(
                'Achievement',
                style: TextStyle(fontSize: 30.0),
              ),
              alignment: Alignment(0.0, 0.0),
            ),
            OutlineButton(
                child: new Text("Sign Out"),
                onPressed: () {
                  server.signOut();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(title: 'Login'),
                      ));
                })
          ],
        ),
      ),
    );
  }
}
