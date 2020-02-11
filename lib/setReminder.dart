import 'package:flutter/material.dart';
class SetReminderPage extends StatefulWidget {
  SetReminderPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SetReminderPageState createState() => _SetReminderPageState();
}

class _SetReminderPageState extends State<SetReminderPage> {



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
