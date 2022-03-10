import 'package:flutter/material.dart';

class UserModel{

  late int total_xp;
  final user_name;
  final avartar;
  var stats = {
      "dex": 1,

      "str": 1,

      "int": 1,
  };

  late var inventory;

  // default constructor
  // UserModel(this.user_name, this.avartar){
  //   total_xp = 0;
  //   inventory = {};
  // }

  // customizable constructor
  UserModel(this.user_name, this.avartar, this.stats, this.inventory);

}