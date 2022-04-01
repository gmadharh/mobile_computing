import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;

class User {
  String? username;
  int? level;
  int? basePercentage;
  int? xpAmount;
  int? statPoints;
  int? statDex;
  int? statStr;
  int? statInt;
  bool? notificationToggle;
  bool? darkmodeToggle;
  bool? sFXToggle;
  List<String>? units;

  User(
      {this.username,
      this.level,
      this.basePercentage,
      this.xpAmount,
      this.statPoints,
      this.statDex,
      this.statStr,
      this.statInt,
      this.notificationToggle,
      this.darkmodeToggle,
      this.sFXToggle,
      this.units});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    level = json['level'];
    basePercentage = json['basePercentage'];
    xpAmount = json['xpAmount'];
    statPoints = json['statPoints'];
    statDex = json['statDex'];
    statStr = json['statStr'];
    statInt = json['statInt'];
    notificationToggle = json['notificationToggle'];
    darkmodeToggle = json['darkmodeToggle'];
    sFXToggle = json['SFXToggle'];
    units = json['units'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['level'] = this.level;
    data['basePercentage'] = this.basePercentage;
    data['xpAmount'] = this.xpAmount;
    data['statPoints'] = this.statPoints;
    data['statDex'] = this.statDex;
    data['statStr'] = this.statStr;
    data['statInt'] = this.statInt;
    data['notificationToggle'] = this.notificationToggle;
    data['darkmodeToggle'] = this.darkmodeToggle;
    data['SFXToggle'] = this.sFXToggle;
    data['units'] = this.units;
    return data;
  }
}
