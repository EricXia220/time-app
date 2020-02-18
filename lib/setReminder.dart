import 'package:flutter/material.dart';
class SetReminderPage extends StatefulWidget {
  SetReminderPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SetReminderPageState createState() => _SetReminderPageState();
}

class _SetReminderPageState extends State<SetReminderPage> {

  String dropdownValue = 'Daily';

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
        DropdownButton<String>(
        value: dropdownValue,
          icon: Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(
            fontSize: 20,
              color: Colors.deepPurple,
          ),

          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
            });
          },
          items: <String>['Daily', 'Weekly', 'Monthly']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          })
              .toList(),
        )
          ],
        ),
      ),

    );
  }
}
