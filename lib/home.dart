import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Social',
      style: optionStyle,
    ),
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'Account',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
              margin: new EdgeInsets.all(20.0),
              padding: new EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Big Goal',
              style: TextStyle(fontSize: 50.0),
              ),
              alignment: Alignment(0.0, 0.0),
            ),
            Container(
              margin: new EdgeInsets.all(15.0),
              padding: new EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'Small Goal',
                style: TextStyle(fontSize: 30.0),
              ),
              alignment: Alignment(0.0, 0.0),
            ),
            Container(
              margin: new EdgeInsets.all(15.0),
              padding: new EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'Small Goal',
                style: TextStyle(fontSize: 30.0),
              ),
              alignment: Alignment(0.0, 0.0),
            ),
            Container(
              margin: new EdgeInsets.all(15.0),
              padding: new EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'Small Goal',
                style: TextStyle(fontSize: 30.0),
              ),
              alignment: Alignment(0.0, 0.0),
            ),
          ])),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Social'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('Account'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
