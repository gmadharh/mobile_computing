import 'package:flutter/material.dart';
import 'package:mobile_computing/pages/single_workout.dart';
import 'package:mobile_computing/models/temp_active.dart';
import 'package:mobile_computing/providers/ActiveProvider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



Widget activeCard(Map exe, String front_img, String back_img, context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('userData').snapshots();
    CollectionReference users = FirebaseFirestore.instance.collection('userData');
    String uid = ("RYG4MP8lFwXYPZU5cnIc");

    Future<void> updateUser(int xp, int lvl, int stat) {
    return users
      .doc(uid)
      .update({"CurrentEXP": xp, "level": lvl, "stat_points": stat})
      .then((value) => print("User Updated"))
      .catchError((error) => print("Failed to update user: $error"));
    }
    
    return StreamBuilder<QuerySnapshot>(
    stream: _usersStream,

    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return Text('Something went wrong');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return Text("Loading");
      }
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            onTap: () {},
            trailing: Consumer<ActiveProvider>( builder: ((ctx, value, child) {
            return IconButton(
                onPressed: () {
                  value.removeWorkout(exe);
                  // Add XP to user reference by using 'exe['weight']'
                  int x = (snapshot.data)!.docs.elementAt(0)['CurrentEXP'] + exe['weight'];
                  int l = (snapshot.data)!.docs.elementAt(0)['level'];
                  int s = (snapshot.data)!.docs.elementAt(0)['stat_points'];
                  if(x > 100){
                    l++;
                    x = x - 100;
                    s = s + 3;
                  }
                  updateUser(x, l, s);
                },
                icon: Icon(Icons.check),
              );
          })
          ),
            leading: CircleAvatar(
              backgroundColor: getColor(exe['weight']),
              child: Text(
                exe['weight'].toString() + "xp",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            title: Center(child: Text(exe['name'])),
          )
        ],
      ),);

    } 
    );
  }


Color getColor(weight){

  // var w = int.parse(weight);

  if(weight > 10){
    return (Color.fromARGB(255, 238, 97, 97) as Color);
  }else if (weight > 7){
    return (Colors.blue[400] as Color);
  }else{
    return (Colors.green[400] as Color);
  }

}