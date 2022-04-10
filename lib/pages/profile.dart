// Abdul Mahmoud
// March 8, 2022
// Swagmasters V2
// Profile Page
// Milestone 2
// CIS*4030

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_computing/models/temp_invent.dart';
import 'package:mobile_computing/pages/home.dart';
import 'package:mobile_computing/widgets/xpBar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:rflutter_alert/rflutter_alert.dart';
import '../user_json.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  const ProfilePage({Key? key, required this.uid}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double xp = 35.0;
  double targetXP = 100.0;
  var level = 3;
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('userData').snapshots();

  CollectionReference users = FirebaseFirestore.instance.collection('userData');

  Future<void> updateUser(int xp, int lvl, int stat) {
    return users
      .doc(widget.uid)
      .update({"CurrentEXP": xp, "level": lvl, "stat_points": stat})
      .then((value) => print("User Updated"))
      .catchError((error) => print("Failed to update user: $error"));
    }

  Future<void> updateItems(int index, bool value) async {

    return await users
        //uid
        .doc(widget.uid)
        .update({"items.${index}": value})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> updateEquip(String item) async {
    return await users
        //uid
        .doc(widget.uid)
        .update({"Equip": item})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> updateStat(String stat, int statPoint) async {
    return await users
        //uid
        .doc(widget.uid)
        .update({stat + '_points': statPoint})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
  attempEquip(int index, bool value) {
    return false;
  }

  showAlertDialog(BuildContext context, String message) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(message),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
      
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    LevelBar(),
                    Text((snapshot.data!).docs.elementAt(0)['username']),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Inventory",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 196, 196, 196),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0))),
                      height: MediaQuery.of(context).size.height / 2.5,
                      width: MediaQuery.of(context).size.width - 20,
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(items.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          height: 40,
                                          child: Image(
                                            image: NetworkImage(
                                                "${items[index]['img']}"),
                                          )),
                                      const Spacer(),
                                      Container(
                                        height: 30.0,
                                        child: RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              side: const BorderSide(
                                                  color: Color.fromRGBO(
                                                      0, 160, 227, 1))),
                                          onPressed: () {
                                            if (items[index]["DEXreq"] >
                                                ((snapshot.data!)
                                                    .docs
                                                    .elementAt(
                                                        0)['dex_points'])) {
                                              showAlertDialog(
                                                  context,
                                                  "Requires " +
                                                      "${items[index]['DEXreq']}" +
                                                      " DEX points");
                                            } else if (items[index]["STRreq"] >
                                                ((snapshot.data!)
                                                    .docs
                                                    .elementAt(
                                                        0)['str_points'])) {
                                              showAlertDialog(
                                                  context,
                                                  "Requires " +
                                                      "${items[index]['STRreq']}" +
                                                      " STR points");
                                            } else if (items[index]["INTreq"] >
                                                ((snapshot.data!)
                                                    .docs
                                                    .elementAt(
                                                        0)['int_points'])) {
                                              showAlertDialog(
                                                  context,
                                                  "Requires " +
                                                      "${items[index]['INTreq']}" +
                                                      " INT points");
                                            } else {
                                              showAlertDialog(
                                                  context, "Equip Successful");
                                              updateEquip(items[index]["item"]);
                                              HomePage();
                                            }
                                          },
                                          padding: EdgeInsets.all(5.0),
                                          color: Color.fromRGBO(0, 160, 227, 1),
                                          textColor: Colors.white,
                                          child: Text("Equip",
                                              style: TextStyle(fontSize: 10)),
                                        ),
                                      )
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(items[index]['item']),
                                  )
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Stat Points: " +
                            ((snapshot.data!).docs.elementAt(0)['stat_points'])
                                .toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ListTile(
                                leading: Text(
                                  "DEX: " +
                                      ((snapshot.data!)
                                              .docs
                                              .elementAt(0)['dex_points'])
                                          .toString(),
                                  style: TextStyle(fontSize: 30),
                                ),
                                trailing: ElevatedButton(
                                  onPressed: () {
                                    if (((snapshot.data!)
                                            .docs
                                            .elementAt(0)['stat_points']) ==
                                        0) {
                                      return;
                                    }

                                    int dex = (snapshot.data)!
                                            .docs
                                            .elementAt(0)['dex_points'] +
                                        1;
                                    updateStat('dex', dex);

                                    if ((snapshot.data)!
                                            .docs
                                            .elementAt(0)['dex_points'] >=
                                        20) {
                                      increment(snapshot);
                                      updateItems(0, true);
                                      
                                    } else {
                                      updateItems(0, false);
                                    }
                                    if ((snapshot.data)!
                                            .docs
                                            .elementAt(0)['dex_points'] >=
                                        41) {
                                      increment(snapshot);
                                      updateItems(1, true);
                                    } else {
                                      updateItems(1, false);
                                    }

                                    int s = (snapshot.data)!
                                            .docs
                                            .elementAt(0)['stat_points'] -
                                        1;
                                    updateStat('stat', s);
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color.fromARGB(
                                                  255, 196, 196, 196))),
                                )),
                            ListTile(
                                leading: Text(
                                  "STR: " +
                                      ((snapshot.data!)
                                              .docs
                                              .elementAt(0)['str_points'])
                                          .toString(),
                                  style: TextStyle(fontSize: 30),
                                ),
                                trailing: ElevatedButton(
                                  onPressed: () {
                                    if (((snapshot.data!)
                                            .docs
                                            .elementAt(0)['stat_points']) ==
                                        0) {
                                      return;
                                    }

                                    int str = (snapshot.data)!
                                            .docs
                                            .elementAt(0)['str_points'] +
                                        1;
                                    updateStat('str', str);
                                    if ((snapshot.data)!
                                            .docs
                                            .elementAt(0)['str_points'] >=
                                        20) {
                                      increment(snapshot);
                                      updateItems(4, true);
                                    } else {
                                      updateItems(4, false);
                                    }
                                    if ((snapshot.data)!
                                            .docs
                                            .elementAt(0)['str_points'] >=
                                        41) {
                                      increment(snapshot);
                                      updateItems(5, true);
                                    } else {
                                      updateItems(5, false);
                                    }
                                   

                                    int s = (snapshot.data)!
                                            .docs
                                            .elementAt(0)['stat_points'] -
                                        1;
                                    updateStat('stat', s);
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color.fromARGB(
                                                  255, 196, 196, 196))),
                                )),
                            ListTile(
                                leading: Text(
                                  "INT: " +
                                      ((snapshot.data!)
                                              .docs
                                              .elementAt(0)['int_points'])
                                          .toString(),
                                  style: TextStyle(fontSize: 30),
                                ),
                                trailing: ElevatedButton(
                                  onPressed: () {
                                    // if stat points are zero and the try to increment points
                                    if (((snapshot.data!)
                                            .docs
                                            .elementAt(0)['stat_points']) ==
                                        0) {
                                      return;
                                    }

                                    int p = (snapshot.data)!
                                            .docs
                                            .elementAt(0)['int_points'] +
                                        1;
                                    updateStat('int', p);
                                    if ((snapshot.data)!
                                            .docs
                                            .elementAt(0)['int_points'] >=
                                        20) {
                                      increment(snapshot);
                                      updateItems(8, true);
                                      
                                    } else {
                                      updateItems(8, false);
                                    }
                                    if ((snapshot.data)!
                                            .docs
                                            .elementAt(0)['int_points'] >=
                                        41) {
                                      increment(snapshot);
                                      updateItems(9, true);
                                    } else {
                                      updateItems(9, false);
                                    }

                                    int s = (snapshot.data)!
                                            .docs
                                            .elementAt(0)['stat_points'] -
                                        1;
                                    updateStat('stat', s);
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color.fromARGB(
                                                  255, 196, 196, 196))),
                                )),
                          ]),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
  void increment(snapshot){
    int xp = (snapshot.data)!.docs.elementAt(0)['CurrentEXP'] + 20;
    int level = (snapshot.data)!.docs.elementAt(0)['level'];
    int stat = (snapshot.data)!.docs.elementAt(0)['stat_points'];
    if(xp > 100){
      level++;
      xp = xp - 100;
      stat = stat + 3;
    }
    updateUser(xp, level, stat);
  }
}
