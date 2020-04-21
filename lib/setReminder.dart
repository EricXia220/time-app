import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'displayGoal.dart';
import 'home.dart';
import 'server.dart';

class SetReminderPage extends StatefulWidget {
  SetReminderPage({Key key, this.title, this.goalTitle, this.difficulty}) : super(key: key);
  final String title;
  String goalTitle;
  String difficulty;
  @override
  _SetReminderPageState createState() => _SetReminderPageState();
}

class _SetReminderPageState extends State<SetReminderPage> {
  String dropdownValue = 'Daily';
  String _time = "Not set";
  int hour;
  int minute;
  var server = Server();
  var frequencyController = TextEditingController();
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
                Text('Set Reminder',
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
                  child: Text("Pick a time: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
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
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    elevation: 4.0,
                    onPressed: () {
                      DatePicker.showTimePicker(context,
                          theme: DatePickerTheme(
                            containerHeight: 210.0,
                          ),
                          showTitleActions: true, onConfirm: (time) {
                            print('confirm $time');
                            _time = '${time.hour} : ${time.minute}';
                            setState(() {hour = int.parse('${time.hour}'); minute = int.parse('${time.minute}'); });
                          }, currentTime: DateTime.now(), locale: LocaleType.en);
                      setState(() {});
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.access_time,
                                      size: 18.0,
                                      color: Colors.teal,
                                    ),
                                    Text(
                                      " $_time",
                                      style: TextStyle(
                                          color: Colors.teal,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Text(
                            "  Change",
                            style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                    color: Colors.white,
                  ),),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text("Frequency: ", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),),
                      margin: EdgeInsets.only(left: 20, top: 20),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30, top: 20),
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
                        items: <String>['Daily', 'Weekly']
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
                          server
                              .addSmallGoal(
                              widget.goalTitle, widget.difficulty, dropdownValue, _time, hour, minute)
                              .then((a) {
                            print("small goal added");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage(title: 'Home Page', selectedIndex: 1,)),
                            );
                          }).catchError((a) {
                            print("There is an error");
                          });
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