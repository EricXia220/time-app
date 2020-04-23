import 'package:flutter/material.dart';
import 'customizeBg.dart';
import 'home.dart';
import 'signUp.dart';
import 'server.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var usernameEditingController = TextEditingController();
  var emailTextEditingController = TextEditingController();
  var passwordTextEditingController = TextEditingController();
  var password2TextEditingController = TextEditingController();

  var server = Server();
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
                    height: 40,
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
                    height: 20,
                  ),
                  Align(
                    child: OutlineButton(
                        child: new Text("Change Goal"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    customizeBgPage(title: 'customize big goal'),
                              ));
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0))),
                  ),
                  Align(
                    child: OutlineButton(

                        child: new Text("Complete"),
                        onPressed: () {
                          server.completeBg().then((d) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      customizeBgPage(title: 'customize your new big goal'),
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