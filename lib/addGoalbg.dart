import 'package:flutter/material.dart';
import 'package:time_app/localdb2.dart';
import 'customize.dart';
import 'localdb.dart';
import 'setReminder.dart';
import 'server.dart';
import 'home.dart';
import 'customizeBg.dart';
import 'dart:math';
class addGoalbgPage extends StatefulWidget {
  addGoalbgPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _addGoalbgPageState createState() => _addGoalbgPageState();
}

class _addGoalbgPageState extends State<addGoalbgPage> {
//  final List<String> entries = <String>['A', 'B', 'C'];
//  final List<dynamic> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  List<Color> colors = [Color(0xFF89A998), Color(0xFFACD3AE), Color(0xFF469CAD), Color(0xFF9CCAD5), Color(0xFFB1D4C4)];
  Random random = new Random();
  var server = Server();
  var goalTitleController = TextEditingController();
  var difficultyController = TextEditingController();
  String dropdownValue = "Medium";
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
                Text('Choose Your Big Goal',
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
                              customizeBgPage(title: 'Customize')),
                    );
                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)))),
          SizedBox(height: 20,),
          Container(
              height: MediaQuery.of(context).size.height - 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20)),
              ),
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: LocalDB2.defaultGoals.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: colors[random.nextInt(5)],
                    ),
                    child: ListTile(
                      onTap: () {
                        server
                            .addBigGoal('${LocalDB2.defaultGoals[index]['name']}',
                            '${LocalDB2.defaultGoals[index]['difficulty']}')
                            .then((a) {
                          print("big goal added");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(title: 'Home', selectedIndex: 1,),
                              ));
                        }).catchError((a) {
                          print("There is an error");
                        });
                      },

                      title:
                                Text('${LocalDB2.defaultGoals[index]['name']}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                      leading: ImageIcon(AssetImage('${LocalDB2.defaultGoals[index]['image']}'), size: 40, color: Colors.black54,),
                      trailing: Text('${LocalDB2.defaultGoals[index]['difficulty']}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                    ),
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
