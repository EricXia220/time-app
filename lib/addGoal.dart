import 'package:flutter/material.dart';
import 'customize.dart';
import 'localdb.dart';
import 'setReminder.dart';

class addGoalPage extends StatefulWidget {
  addGoalPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _addGoalPageState createState() => _addGoalPageState();
}

class _addGoalPageState extends State<addGoalPage> {
//  final List<String> entries = <String>['A', 'B', 'C'];
//  final List<dynamic> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

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
                Container(
                    width: 125.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.filter_list),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.menu),
                          color: Colors.white,
                          onPressed: () {},
                        )
                      ],
                    ))
              ],
            ),
          ),
          SizedBox(height: 25.0),
          Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Row(
              children: <Widget>[
                Text('Add Your Goal',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0)),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(75.0)),
            ),
              child: FlatButton(
                  child: new Text("Customize", style: TextStyle(color: Colors.black, fontSize: 20),),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              customizePage(title: 'Customize')),
                    );
                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)))),
          SizedBox(height: 20,),
          Container(
              height: MediaQuery.of(context).size.height - 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
              ),
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: LocalDB.defaultGoals.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SetReminderPage(
                              title: 'Set Reminder',
                              goalTitle: LocalDB.defaultGoals[index]['name'],
                              difficulty: LocalDB.defaultGoals[index]
                                  ['difficulty'],
                            ),
                          ));
                      print("choose " + LocalDB.defaultGoals[index].toString());
                    },

                    title:
                              Text('${LocalDB.defaultGoals[index]['name']}'),
                    leading: ImageIcon(AssetImage("assets/camera.png"), color: Colors.blue,),
                    trailing: Text('${LocalDB.defaultGoals[index]['difficulty']}'),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              )),
        ],
      ),
    );
  }
}
