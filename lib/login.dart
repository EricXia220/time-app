import 'package:flutter/material.dart';
import 'home.dart';
class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          margin: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text(
              'Log in:',
            ),
            TextField(
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
        Container(
           margin: const EdgeInsets.only(top: 10.0),
           width: MediaQuery.of(context).size.width,
           child: FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8),
              splashColor: Colors.blueAccent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage(title: "Home Page")),
                );
              },
              child: Text(
                "Log in",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
        ),
        Container(
            margin: const EdgeInsets.only(top: 10.0),
          width: MediaQuery.of(context).size.width,
          child: FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8),
              splashColor: Colors.blueAccent,
              onPressed: () {
                /*...*/
              },
              child: Text(
                "Sign up",
                style: TextStyle(fontSize: 20.0),
              ),
            )
        ),
          ],
        ),
        ),
      ),
    );
  }
}
