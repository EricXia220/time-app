import 'package:flutter/material.dart';
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
  var emailTextEditingController = TextEditingController();
  var passwordTextEditingController = TextEditingController();

  var server = Server();
  @override
Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: new LinearGradient(
                colors: [const Color(0xFF31FF87), const Color(0xFF55BAFF)],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ), child: Container(
          margin: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text(
              'Log in:',
            ),
            TextField(
              controller: emailTextEditingController,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: passwordTextEditingController,
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

              color: Colors.transparent,
              textColor: Colors.black54,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8),
              splashColor: Colors.lightBlueAccent,
             onPressed: () {
               print(emailTextEditingController.text.toString());
               print(passwordTextEditingController.text.toString());
               server
                   .signIn(emailTextEditingController.text.toString(),
                   passwordTextEditingController.text.toString())
                   .then((uid) {
                 Navigator.push(
                   context,
                   MaterialPageRoute(
                       builder: (context) =>
                           HomePage(title: "Home Page")),
                 );
                 print('successfully signed in');
               }).catchError((e) {
                 print('fail to sign in' + e.toString());
               });
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
              color: Colors.transparent,
              textColor: Colors.black54,
              disabledColor: Colors.grey,
              padding: EdgeInsets.all(8),
              splashColor: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SignUpPage(title: "Sign Up Page")),
                );
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
      ),
    );
  }
}
