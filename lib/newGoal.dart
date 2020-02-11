import 'package:flutter/material.dart';
class NewGoalPage extends StatefulWidget {
  NewGoalPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _NewGoalPageState createState() => _NewGoalPageState();
}

class _NewGoalPageState extends State<NewGoalPage> {


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
            Text(
              'You have clicked the button this many times:',
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //onPressed: _incrementCounter,
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }
}
