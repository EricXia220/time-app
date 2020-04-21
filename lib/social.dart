import 'package:flutter/material.dart';
import 'package:time_app/displayUser.dart';
import 'server.dart';
import 'localdb3.dart';
class SocialPage extends StatefulWidget {
  SocialPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SocialPageState createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  var server = Server();
  List<dynamic> users = new List();
  List<Color> colors = [Color(0xFF89593D), Color(0xFF90A5AA), Color(0xFFC3A25C), Color(0xFF4E7370), Color(0xFF828BC1), Color(0xFF7B2683)];
  _SocialPageState() {
    server.getUsers().then((ds) {
      ds.value.forEach((k, v) {
        print(k);
        print(v["points"]);
        users.add(v);
      });
      setState(() {
        users.sort((a, b) => b["points"].compareTo(a["points"]));
      });
      print(users.toString());
    }).catchError((e) {
      print("Failed to get users.");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(
        bottom: 80,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: new EdgeInsets.only(bottom: 10.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF469CAD), Color(0xFF469CAD)]
                ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )
              ),
              child: Container(
                  margin:
                      EdgeInsets.all(20.0),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    ("Rank"),
                    style: TextStyle(fontSize: 40.0, color: Colors.white),
                  )),
              alignment: Alignment(0.0, 0.0),
            ),
            Container(
                child: Expanded(
                    child: ListView.separated(
                        padding: const EdgeInsets.all(8),
                        itemCount: users.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider();
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => displayUserPage(
                                        title: 'Home Page',
                                        user: users[index])),
                              );
                              ;
                            },
                            title: Text(
                              '${users[index]["name"]}',
                              style: TextStyle(fontSize: 30.0),
                            ),
                            leading: ImageIcon(AssetImage('${LocalDB3.defaultGoals[users[index]["rankBadge"] - 1]['image']}'), color: colors[users[index]["rankColor"] - 1], size: 40),
                            trailing: Text('${users[index]["rank"]}'),
                            subtitle: Text("Streak: " + '${users[index]["streak"]}'),
                          );
                        })))
          ],
        ),
      ),
    ));
  }
}
