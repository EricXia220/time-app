import 'package:flutter/material.dart';
import 'setReminder.dart';

class customizePage extends StatefulWidget {
  customizePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _customizePageState createState() => _customizePageState();
}

class _customizePageState extends State<customizePage> {
  String dropdownValue = "Medium";
  var goalTitleController = TextEditingController();
  var difficultyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF469CAD),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 25.0),
          Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Row(
              children: <Widget>[
                Text('Customize Your Goal',
                    style: TextStyle(color: Colors.white, fontSize: 25.0)),
              ],
            ),
          ),
          SizedBox(height: 50.0),
          Container(
            height: MediaQuery.of(context).size.height - 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text("My Goal Is: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 20, top: 70),
                ),
                  Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(
                              color: Colors.grey[200]))
                      ),
                      child: TextField(
                          controller: goalTitleController,
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Name',
                          ))),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text("Difficulty: ", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),),
                      margin: EdgeInsets.only(left: 20, top: 20),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 50, top: 20),
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF469CAD),
                        ),
                        underline: Container(
                          height: 2,
                          color: Color(0xFF469CAD),
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: <String>['Easy', 'Medium', 'Hard']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),

                Container(
                  margin: EdgeInsets.only(top: 30),
                    child: OutlineButton(
                        child: new Text("Confirm"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SetReminderPage(
                                    title: 'Set Reminder',
                                    goalTitle:
                                    goalTitleController.text.toString(),
                                    difficulty:
                                   dropdownValue)),
                          );
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}