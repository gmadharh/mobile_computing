// Abdul Mahmoud
// March 8, 2022
// Swagmasters V2
// Profile Page
// Milestone 2
// CIS*4030

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_computing/models/temp_invent.dart';
import 'package:mobile_computing/widgets/xpBar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart' show rootBundle;
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

  Future<void> updateStat(String stat, int statPoint) async {
    return await users
        //uid
        .doc(widget.uid)
        .update({stat + '_points': statPoint})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text("Loading...");
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(items.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height: 40,
                                        child: Image(
                                          image: AssetImage(
                                              "lib/images/${items[index]['img']}"),
                                        )),
                                    Text(items[index]['item'])
                                  ],
                                ),
                                trailing: Text(
                                  "Requirement: " + items[index]['req'],
                                  style: const TextStyle(fontSize: 16),
                                ),
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
}
