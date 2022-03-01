import 'package:flutter/material.dart';
import 'package:mobile_computing/pages/home.dart';
import 'package:mobile_computing/pages/quests.dart';
import 'package:mobile_computing/pages/settings.dart';
import 'package:mobile_computing/pages/workouts.dart';
import 'package:mobile_computing/pages/profile.dart';

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
  static final List<Widget> _pageOptions = <Widget> [
    ProfilePage(),
    QuestPage(),
    HomePage(),
    WorkoutPage(),
    SettingsPage()
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
    );
  }
}