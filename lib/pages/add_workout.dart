import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/workout_model.dart';

class AddWorkoutPage extends StatefulWidget {
  const AddWorkoutPage({Key? key}) : super(key: key);

  @override
  State<AddWorkoutPage> createState() => _AddWorkoutPageState();
}

class _AddWorkoutPageState extends State<AddWorkoutPage> {
  final _formKey = GlobalKey<FormState>();
  Map workoutAdded = workout;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Add Workout"),
          actions: [
            IconButton(
                icon: const Icon(Icons.info),
                onPressed: (() {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                              "This is the page for inputting your own workout! It will get added to the list of workouts.\n\n The following fields are required:\n- Name\n- Description\n- XP Amount \n\n Other fields are optional. To add multiple equipment, seperate them by a space.",
                              style: TextStyle(
                                fontFamily: "Anybody",
                                fontSize: 16,
                              )),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("OK"))
                          ],
                        );
                      });
                }))
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Name:",
                        style: TextStyle(fontFamily: "Anybody", fontSize: 35),
                      ),
                    )),
                TextFormField(
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    workoutAdded['name'] = value;
                    return null;
                  },
                ),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Description:",
                        style: TextStyle(fontFamily: "Anybody", fontSize: 35),
                      ),
                    )),
                TextFormField(
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    workoutAdded['desc'] = value;
                    return null;
                  },
                ),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "XP Amount:",
                        style: TextStyle(fontFamily: "Anybody", fontSize: 35),
                      ),
                    )),
                TextFormField(
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    } else if (int.tryParse(value) is! int) {
                      return 'Please enter an integer';
                    } else if (int.parse(value) > 15 || int.parse(value) < 4) {
                      return 'XP Amount must be between 4-15';
                    }
                    workoutAdded['weight'] = value;
                    return null;
                  },
                ),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Equipment:",
                        style: TextStyle(fontFamily: "Anybody", fontSize: 35),
                      ),
                    )),
                TextFormField(
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return null;
                    }
                    workoutAdded['equipment'] = value;
                  },
                ),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Muscle Groups:",
                        style: TextStyle(fontFamily: "Anybody", fontSize: 35),
                      ),
                    )),
                TextFormField(
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Added Workout')),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      );
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}
