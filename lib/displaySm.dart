import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:time_app/customizeBg.dart';
import 'package:time_app/home.dart';
import 'customizeBg.dart';
import 'server.dart';

class displaySmPage extends StatefulWidget {
  displaySmPage({Key key, this.title, this.goal}) : super(key: key);
  final String title;
  var goal;
  @override
  _displaySmPageState createState() => _displaySmPageState();
}

class _displaySmPageState extends State<displaySmPage> {
  var server = Server();
  var newTime = new DateTime.fromMillisecondsSinceEpoch(new DateTime.now().millisecondsSinceEpoch);
  Function completeButtonAction() {
    var lastTime = new DateTime.fromMillisecondsSinceEpoch(widget.goal['lastCompletionTime']);
    if (lastTime.day == newTime.day)
      {print("Already completed");
      print(newTime.day);
      print(lastTime.day);
      } else {
      print("Complete");

        setState(() {
          server.completeSm(widget.goal["id"]);
          server.setLastCompletionTime(widget.goal["id"]);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    HomePage(title: 'Home', selectedIndex: 1,),
              ));
          server.setRank(); server.addStreak();
        });
      print(newTime.day);
      print(lastTime.day);
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: mediaQuery.size.height / 3,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                      end: Alignment.center,
                      colors:[
                        Color(0xFF8AC1CF), Color(0xFF8AC1CF)]
                  ),
                ), child: Container(
                margin: EdgeInsets.only(
                    top: 50, bottom: 50, left: 30, right: 30),
                width: MediaQuery.of(context).size.width,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [Color(0xFF469CAD), Color(0xFF469CAD)],
                  ),
                ),
                  child: Container(
                    alignment: Alignment.center,
                    child: (
                    Text('${widget.goal["title"]}', style: TextStyle(fontSize: 40.0, color: Colors.white))
                    )
                  )
              ),

              ),
            ),
            Positioned(
              top: 50, 
              left: 10, 
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context); 
                },
                icon: Icon(Icons.arrow_back_ios, color: Colors.white,)
              )
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: mediaQuery.size.height / 1.4,
              child:
              Container (
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  )
                ),
                child: SingleChildScrollView(
                  child: Column(children: <Widget>[

                    SizedBox(height: 20,),

                    Text("Streak: " +'${widget.goal["streak"]}', style: TextStyle(
                      color: Color.fromRGBO(97, 90, 90, 1),
                      fontSize: 23,
                      fontWeight: FontWeight.normal,
                    ), ),
                    SizedBox(height: 20,),
                    Text("Difficulty: " + '${widget.goal["difficulty"]}', style: TextStyle(
                      color: Color.fromRGBO(97, 90, 90, 1),
                      fontSize: 23,
                      fontWeight: FontWeight.normal,
                    )),
                    SizedBox(height: 20,),
                    Text("Remind time: " + '${widget.goal["time"]}', style: TextStyle(
                      color: Color.fromRGBO(97, 90, 90, 1),
                      fontSize: 23,
                      fontWeight: FontWeight.normal,
                    )),
                    SizedBox(height: 20,),
                    OutlineButton(
                        child: new Text("Complete"),
                        onPressed: completeButtonAction,
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                    ),
                    OutlineButton(
                        child: new Text("Remove"),
                        onPressed: () {
                          server.deleteSmallGoal(widget.goal["id"]).then((d){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      HomePage(title: 'Home', selectedIndex: 1,),
                                ));
                          }).catchError(
                                  (e) {
                                print('Failed to remove ' + e.toString() +  "/" + "sm" + "/" + "sm-" + widget.goal["id"].toString());
                              }
                          );

                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0))),

                  ],)
                )
              )

            )
          ],
        ),
      );
  }
}
