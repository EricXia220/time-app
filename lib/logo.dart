import 'package:flutter/material.dart';
class LogoPage extends StatefulWidget {
  LogoPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LogoPageState createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {


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
        //onPressed:
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }
}
