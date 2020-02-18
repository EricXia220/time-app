import 'package:flutter/material.dart';
import 'addGoal.dart';
class DisplayGoalPage extends StatefulWidget {
  DisplayGoalPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _DisplayGoalPageState createState() => _DisplayGoalPageState();
}

class _DisplayGoalPageState extends State<DisplayGoalPage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: new EdgeInsets.all(20.0),
                  padding: new EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text('Big Goal',
                    style: TextStyle(fontSize: 50.0),
                  ),
                  alignment: Alignment(0.0, 0.0),
                ),
                Container(
                  margin: new EdgeInsets.all(15.0),
                  padding: new EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.green,
                  ),
                  child: Text(
                    'Small Goal',
                    style: TextStyle(fontSize: 30.0),
                  ),
                  alignment: Alignment(0.0, 0.0),
                ),
                Container(
                  margin: new EdgeInsets.all(15.0),
                  padding: new EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.green,
                  ),
                  child: Text(
                    'Small Goal',
                    style: TextStyle(fontSize: 30.0),
                  ),
                  alignment: Alignment(0.0, 0.0),
                ),
                Container(
                  margin: new EdgeInsets.all(15.0),
                  padding: new EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.green,
                  ),
                  child: Text(
                    'Small Goal',
                    style: TextStyle(fontSize: 30.0),
                  ),
                  alignment: Alignment(0.0, 0.0),
                ),
              ])
      ),

      floatingActionButton: FloatingActionButton(
        //onPressed: _incrementCounter,
        elevation: 0.0,
        tooltip: 'Add',
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => addGoalPage(title: 'Add Goals')),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
