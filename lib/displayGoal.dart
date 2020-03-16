import 'package:flutter/material.dart';
import 'package:time_app/displaySm.dart';
import 'package:time_app/server.dart';
import 'addGoal.dart';
import 'customizeBg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'displayBg.dart';
class DisplayGoalPage extends StatefulWidget {
  DisplayGoalPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _DisplayGoalPageState createState() => _DisplayGoalPageState();
}

class _DisplayGoalPageState extends State<DisplayGoalPage> {
  var server = Server();
  List<dynamic> entries = new List();
  var bigGoalString;
  var bigGoal;
  _DisplayGoalPageState() {
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
    });}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Container(
              margin: new EdgeInsets.only(top: 40.0, bottom: 20.0, left: 20.0, right: 20.0),
              padding: new EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: FlatButton(
                  color: Colors.transparent,
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              displayBgPage(title: 'big goal', goal: bigGoal,),
                        ));
                  },
                  child: Text(
                    bigGoalString.toString(),
                    style: TextStyle(fontSize: 40.0),
                  )),
              alignment: Alignment(0.0, 0.0),
            ),
            Container(

                child: Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: entries.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => displaySmPage(title: 'Goals', goal: entries[index])),
                              );
                            },
                            title: Container(
                              padding: new EdgeInsets.all(10.0),
                              margin: new EdgeInsets.all(10.0),
                              height: 50,
                              color: Colors.green,
                              child: Center(child: Text('${entries[index]["title"]}')),
                            ),
                          );
                        })))
          ])),
      floatingActionButton: FloatingActionButton(
        //onPressed: _incrementCounter,
        elevation: 0.0,
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
