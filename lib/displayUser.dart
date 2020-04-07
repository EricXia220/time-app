import 'package:flutter/material.dart';
import 'package:time_app/customizeBg.dart';
import 'package:time_app/home.dart';
import 'customizeBg.dart';
import 'server.dart';
import 'social.dart';
class displayUserPage extends StatefulWidget {
  displayUserPage({Key key, this.title, this.user}) : super(key: key);
  final String title;
  var user;
  @override
  _displayUserPageState createState() => _displayUserPageState();
}

class _displayUserPageState extends State<displayUserPage> {
  var server = Server();
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
            Container(
                child: Text(
             "Rank: " + '${widget.user["rank"]}',
            )),
            Container(
                child: Text(
                  "Points: " + '${widget.user["points"]}',
                )),
            Container(
              child: Text(
                "Last Achievement: " + '${widget.user["lastAchievement"]}'
              )
            ),

            OutlineButton(
                child: new Text("Back"),
                onPressed: () { setState(() {

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            HomePage(title: 'Home', selectedIndex: 0,),
                      ));
                });

                },
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
            ),



          ],
        ),
      ),

    );
  }
}
