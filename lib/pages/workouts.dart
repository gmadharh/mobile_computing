import 'package:flutter/material.dart';

class WorkoutPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text("Workouts"),
    ),
    body: const Center(child: Text("Workout Page")),
  );
}