import 'dart:math';

import 'package:flutter/material.dart';

class AddWorkoutPage extends StatefulWidget {
  const AddWorkoutPage({Key? key}) : super(key: key);

  @override
  State<AddWorkoutPage> createState() => _AddWorkoutPageState();
}

class _AddWorkoutPageState extends State<AddWorkoutPage> {
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Add Workout"),
        ),
        body: Center(child: Text("Add Workout")),
      );
}
