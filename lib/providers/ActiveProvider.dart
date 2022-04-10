import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ActiveProvider with ChangeNotifier {
  final List active = [];

  List get myList => active;

  void addWorkout(var e) {
    active.add(e); 
    notifyListeners();
  }

  void removeWorkout(var exe){
    active.removeWhere((e) => e['name']== exe['name']);
    notifyListeners();
  }
}