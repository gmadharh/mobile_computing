import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BottomNavigation(),
    );
  }
}

class BottomNavigation extends StatefulWidget {

  @override
  State<BottomNavigation> createState() => _BottomNavigation();
}

class _BottomNavigation extends State<BottomNavigation> {
  int _page = 2;
  static List<Widget> _pageOptions = <Widget> [
    Text(
      "Profile",
    ),
    Text(
      "Quests",
    ),
    Text(
      "Home",
    ),
    Text(
      "Workouts",
    ),
    Text(
      "Settings",
    ),
  ];

  void _onButtonClicked(int index) {
    setState(() {
      _page = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
        Center(
          child: _pageOptions.elementAt(_page),
        ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
              ),
              label: "Profile",),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.explore_rounded,
              ),
              label: "Quests",
              ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_rounded,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.fitness_center_rounded,
              ),
              label: "Workouts"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
              ),
              label: "Settings"),
          ],
          currentIndex: _page,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          onTap: _onButtonClicked,
        ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '',
        ),
      ),
    );
  }
}