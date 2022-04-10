import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/xpBar.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:mobile_computing/models/Image_inventory.dart';

List exercises = [
  {"name": "2KM Jog", "exp": "8"},
  {"name": "10 Push Ups", "exp": "6"},
  {"name": "8 Pull Ups", "exp": "10"},
  {"name": "20 Minute Walk", "exp": "7"},
  {"name": "Rock Climbing Session", "exp": "14"}
];

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          automaticallyImplyLeading: false,
        ),
        body: const ExerciseColumn(),
      );
}

class ExerciseColumn extends StatefulWidget {
  
  const ExerciseColumn({Key? key,}) : super(key: key);

  @override
  State<ExerciseColumn> createState() => _ExerciseColumnState();
}

class _ExerciseColumnState extends State<ExerciseColumn> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('userData').snapshots();

  CollectionReference users = FirebaseFirestore.instance.collection('userData');
  String uid = ("RYG4MP8lFwXYPZU5cnIc");
  
  Future<void> updateItems(int index, bool value) async {

    return await users
        //uid
        .doc(uid)
        .update({"items.${index}": value})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(child: Text("Loading..."));
          }
          int level = ((snapshot.data!).docs.elementAt(0)['level']);
          String race = "Angel";
          String equip = ((snapshot.data!).docs.elementAt(0)['Equip']);
          String image_url = "placeholder";

          if (level >= 10) {
            race = "Golem3";
            updateItems(11, true);
          } else if (level >= 8) {
            race = "Golem2";
            updateItems(7, true);
          } else if (level >= 6) {
            race = "Golem";
            updateItems(3, true);
          } else if (level >= 4) {
            race = "Angel3";
            updateItems(10, true);
          } else if (level >= 2) {
            race = "Angel2";
            updateItems(6, true);
          } else if (level >= 0) {
            race = "Angel";
            updateItems(2, true);
          }

          for (var i = 0; i < images.length; i++) {
            if (images[i]["race"] == race && images[i]["item"] == equip) {
              image_url = images[i]["img"];
            }
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Text(
                "Welcome to FitnessScape",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(image_url),
              ),
              const SizedBox(height: 10),
              const LevelBar(),
              const SizedBox(height: 40),
              Text(
                "Challenge yourself everyday." ,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
               Text(
                "Lets get it, Kartik!" ,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              /*Expanded(
                  child: ListView.builder(
                shrinkWrap: true,
                itemCount: exercises.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Container(
                      child: Column(children: [
                    const SizedBox(height: 8),
                    Container(
                        height: 65.0,
                        width: (MediaQuery.of(context).size.width / 2) * 3,
                        color: Colors.transparent,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0))),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(width: 10),
                                  ClipOval(
                                      child: Container(
                                    color: Colors.lightBlue,
                                    height: 50.0,
                                    width: 50.0,
                                    child: Center(
                                        child: Text(
                                            "xp " + exercises[index]["exp"],
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                            textAlign: TextAlign.center)),
                                  )),
                                  const SizedBox(width: 20),
                                  Text(exercises[index]["name"],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
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
                                      onPressed: () {},
                                      padding: EdgeInsets.all(5.0),
                                      color: Color.fromRGBO(0, 160, 227, 1),
                                      textColor: Colors.white,
                                      child: Text("Done",
                                          style: TextStyle(fontSize: 10)),
                                    ),
                                  ),
                                ])))
                                
                  ]));
                },
              ))*/
            ],
          );
        });
  }
}




// class LevelBar extends StatefulWidget {
//   const LevelBar({Key? key}) : super(key: key);

//   @override
//   _LevelBarState createState() => _LevelBarState();
// }

// class _LevelBarState extends State<LevelBar> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: LinearPercentIndicator(
//         width: (MediaQuery.of(context).size.width / 4) * 3,
//         percent: 60 / 100,
//         animation: true,
//         animationDuration: 1500,
//         leading: const Text("Lvl 3", style: TextStyle(fontSize: 20)),
//         trailing: const Text("Lvl 4", style: TextStyle(fontSize: 20)),
//         progressColor: Colors.greenAccent,
//       ),
//     );
//   }
// }
