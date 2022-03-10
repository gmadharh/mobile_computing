import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mobile_computing/pages/add_workout.dart';

class WorkoutPage extends StatefulWidget {
  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  List workouts = ["3K Jog", "Bench Press", "Dead Lifts", "Sprints", "2K Walk"];
  final _random = Random();

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text("Workouts"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: ((context) => AddWorkoutPage())));
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.center,
                  child:
                      Text("Workout Library", style: TextStyle(fontSize: 30)))),
          SizedBox(
            height: 400,
            child: CupertinoScrollbar(
              child: ListView(
                shrinkWrap: true,
                children: [
                  for (int i = 0; i < 10; i++)
                    workoutCard((3 + _random.nextInt(20 - 3)).toString(),
                        workouts[_random.nextInt(workouts.length)])
                ],
              ),
            ),
          )
        ],
      ));

  Widget workoutCard(String xpAmount, String workout) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.add),
            ),
            leading: CircleAvatar(
              backgroundColor: getColor(),
              child: Text(
                xpAmount + "xp",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            title: Center(child: Text(workout)),
          )
        ],
      ),
    );
  }

  Color getColor() {
    int num = _random.nextInt(3);
    switch (num) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.red;
      case 2:
        return Colors.brown;
      default:
        return Colors.green;
    }
  }
}
