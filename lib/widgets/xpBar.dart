import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class LevelBar extends StatefulWidget {
  const LevelBar({Key? key}) : super(key: key);

  @override
  _LevelBarState createState() => _LevelBarState();
}

class _LevelBarState extends State<LevelBar> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('userData').snapshots();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
    stream: _usersStream,

    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return Text('Something went wrong');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return Text("Loading");
      }
      return Padding(
        padding: const EdgeInsets.all(9.0),
        child: LinearPercentIndicator(
          width: (MediaQuery.of(context).size.width / 4) * 3,
          percent: (snapshot.data)!.docs.elementAt(0)['CurrentEXP'] / 100,
          animation: true,
          animationDuration: 1500,
          leading:  Text("Lvl " + (snapshot.data)!.docs.elementAt(0)['level'].toString(), style: TextStyle(fontSize: 18)),
          trailing: Text("Lvl " + ((snapshot.data)!.docs.elementAt(0)['level']+1).toString(), style: TextStyle(fontSize: 18)),
          progressColor: Colors.greenAccent,
        ),

      );
    }
    );
  }
}
