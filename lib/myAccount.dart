import 'package:flutter/material.dart';
import 'package:time_app/login.dart';
import 'server.dart';

class MyAccountPage extends StatefulWidget {
  MyAccountPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  var server = Server();
  var userName;
  var rank;
  var streak;
  List<String> entries = new List();
  _MyAccountPageState() {
    server.getRank().then((ds) {
      setState(() {
        server.setRank();
        rank = ds.value.toString();
      });
    }).catchError((e) {
      print(e);
    });
    server.getAchievements().then((ds) {
      ds.value.forEach((k, v) {
        setState(() {
          entries.add(v['title']);
        });
      });
    }).catchError((e) {
      print("Failed to get the small goals.");
    });
    server.getName().then((ds) {
      userName = ds.value;
      print('${userName}');
    }).catchError((e) {
      print("failed to getuser");
    });
    server.getStreak().then((ds) {
      streak = ds.value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
              color: Color(0xFF0B0157),
            )),
            Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 64.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2.0),
                        ),
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    ]),

              ),
              Text('${userName}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21.0,
                      color: Colors.white)),
            ]),
           Container(
             margin: EdgeInsets.only(top: 250.0),
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.only(
                 topLeft: Radius.circular(20.0),
                 topRight: Radius.circular(20.0),
               )
             ),
           ),
            Container(
              margin: EdgeInsets.only(top: 225.0),
              decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  )
              ),
              child: ListView(
                children: ListTile.divideTiles(
                  context: context,
                    tiles: [
                      ListTile(
                        title: Text("Rank"),
                        trailing: Text(rank.toString()),
                      ),
                      ListTile(
                        title: Text("Streak"),
                        trailing: Text('${streak}'),
                      ),
                      ListTile(
                        title: Text("Achievements"),
                        trailing:  DropdownButton<String>(
                          elevation: 0,
                          items: entries.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (_) {},
                        ),
                      ),
                    ] ).toList(),


              )
            ),

          ],
        ),
      ),
    );
  }
}
