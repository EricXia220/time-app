import 'package:flutter/material.dart';
import 'home.dart';
import 'login.dart';
import 'server.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var usernameEditingController = TextEditingController();
  var emailTextEditingController = TextEditingController();
  var passwordTextEditingController = TextEditingController();
  var password2TextEditingController = TextEditingController();

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
          ),
          child: Container(
            margin: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sign up:',
                ),
                TextField(
                  controller: usernameEditingController,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
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
                TextField(
                  controller: password2TextEditingController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirm Password',
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
                        print(password2TextEditingController.text.toString());
                        server
                            .signUpWithProfile(emailTextEditingController.text.toString(),
                                passwordTextEditingController.text.toString(), usernameEditingController.text.toString())
                            .then((uid) {
                              server.addBigGoal("New Big Goal", "-");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LoginPage(title: "Login Page")),
                          );
                          print('successfully signed up');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LoginPage(title: "Login Page")),
                          );
                        }).catchError((e) {
                          print('fail to sign up an account' + e.toString());
                        });
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
