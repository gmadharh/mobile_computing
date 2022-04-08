import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mobile_computing/widgets/xpBar.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:mobile_computing/widgets/questsData.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestPage extends StatefulWidget {
  final String uid;
  const QuestPage({Key? key, required this.uid}) : super(key: key);
  @override
  _QuestPageState createState() => _QuestPageState();
}

class _QuestPageState extends State<QuestPage> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('userData').snapshots();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> updateUser(int statPoints) {
    return users
      .doc(widget.uid)
      .update({"stat_points": statPoints+3})
      .then((value) => print("User Updated"))
      .catchError((error) => print("Failed to update user: $error"));
  }
  
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            "Quests",
          ),
          automaticallyImplyLeading: false,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,

          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  LevelBar(),
                  const Text(
                      "Receive 3 stat points per level up!",
                      style: TextStyle(
                        fontSize:26,
                      ),
                      textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 25,),
                  const Text(
                    "DEX Quest Remaining",
                    style: TextStyle(
                        fontSize:20,
                    ),
                  ),
                  Container(
                    color: Colors.blue[100],
                    height: MediaQuery.of(context).size.height / 3.5,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            for (int i = 0; i < questDataDex.length; i++)
                              QuestCards(
                                type: questDataDex[i]["type"],
                                quest: questDataDex[i]["quest"],
                                reward: questDataDex[i]["reward"],
                                isComplete: (snapshot.data)!.docs.elementAt(0)['items.${i}'],
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25,),
                  const Text(
                    "STR Quest Remaining",
                    style: TextStyle(
                        fontSize:20,
                    ),
                  ),
                  Container(
                    color: Colors.red[100],
                    height: MediaQuery.of(context).size.height / 3.5,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            for (int i = 0; i < questDataInt.length; i++)
                              QuestCards(
                                type: questDataInt[i]["type"],
                                quest: questDataInt[i]["quest"],
                                reward: questDataInt[i]["reward"],
                                isComplete: (snapshot.data)!.docs.elementAt(0)['items.${i+4}'],
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25,),
                  const Text(
                    "INT Quest Remaining",
                    style: TextStyle(
                        fontSize:20,
                    ),
                  ),
                  Container(
                    color: Colors.green[100],
                    height: MediaQuery.of(context).size.height / 3.5,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            for (int i = 0; i < questDataDex.length; i++)
                              QuestCards(
                                type: questDataStr[i]["type"],
                                quest: questDataStr[i]["quest"],
                                reward: questDataStr[i]["reward"],
                                isComplete: (snapshot.data)!.docs.elementAt(0)['items.${i + 8}'],
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        )
      );
}


class QuestCards extends StatelessWidget {
  final String type;
  final String quest;
  final String reward;
  final bool isComplete;
  const QuestCards({
    required this.type,
    required this.quest,
    required this.reward,
    required this.isComplete,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(type + ": "),
                  Text(quest),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text("REWARD: "),
                  Text(reward),
                  isComplete
                      ? const Icon(Icons.check_box)
                      : const Icon(Icons.check_box_outline_blank),
                ],
              ),
            ],
          ),
        ),
      ),
      color: Colors.grey,
    );
  }
}
