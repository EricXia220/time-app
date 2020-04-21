import 'package:flutter/material.dart';
import 'package:time_app/addGoalbg.dart';
import 'package:time_app/customizeBg.dart';
import 'customizeBg.dart';
import 'home.dart';
import 'server.dart';

class displayBgPage extends StatefulWidget {
  displayBgPage({Key key, this.title, this.goal}) : super(key: key);
  final String title;
  var goal;
  @override
  _displayBgPageState createState() => _displayBgPageState();
}

class _displayBgPageState extends State<displayBgPage> {
  var server = Server();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              image:
              DecorationImage(image: AssetImage('assets/background1.jpg'), fit: BoxFit.cover)),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.black.withOpacity(.3),
                Colors.black.withOpacity(.3),
              ]),
            ),
            child: Padding(
              padding: EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )),
                  ),
                  Text(
                    '${widget.goal["title"]}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Difficulty",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      Text(
                        '${widget.goal["difficulty"]}',
                        style: TextStyle(
                            color: Colors.yellow[400],
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 80,
                  ),
                  Align(
                    child: FlatButton(
                        child: new Text("Change Goal", style: TextStyle(fontSize: 20, color: Colors.white),),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    addGoalbgPage(title: 'customize big goal'),
                              ));
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0))),
                  ),
                  Align(
                    child: FlatButton(

                        child: new Text("Complete", style: TextStyle(fontSize: 20, color: Colors.white),),
                        onPressed: () {
                          server.completeBg().then((d) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      addGoalbgPage(title: 'customize your new big goal'),
                                )); server.setRank();
                          }).catchError((e) {
                            print('Failed to complete ' + e.toString());
                          });
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0))),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}