import 'package:flutter/material.dart';
import 'customize.dart';
import 'localdb.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: OutlineButton(
                    child: new Text("Define goal"),
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
            Expanded(
                flex: 5,
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: LocalDB.defaultGoals.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        print("choose " + LocalDB.defaultGoals[index].toString());
                      },
                      title: Container(
                        height: 50,
                        color: Colors.amber[colorCodes[index]],
                        child: Center(child: Text('${LocalDB.defaultGoals[index]['name']}')),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                ))
          ],
        ),
      ),
    );
  }
}
