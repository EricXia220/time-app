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
      body: Container(
          decoration: BoxDecoration(
              image:
              DecorationImage(image: AssetImage('assets/background5.jpg'), fit: BoxFit.cover)),
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
                    '${widget.user["name"]}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Rank",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      Text(
                        '${widget.user["rank"]}',
                        style: TextStyle(
                            color: Colors.yellow[400],
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Points",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      Text(
                        '${widget.user["points"]}',
                        style: TextStyle(
                            color: Colors.yellow[400],
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Last Achievement",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      Text(
                        '${widget.user["lastAchievement"]}',
                        style: TextStyle(
                            color: Colors.yellow[400],
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(

                  )


                ],
              ),
            ),
          )),
    );
  }
}