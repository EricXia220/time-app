import 'package:flutter/material.dart';

class MyAccountPage extends StatefulWidget {
  MyAccountPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  int _counter = 0;

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
            )
          ],
        ),
      ),
    );
  }
}
