import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mobile_computing/models/add_workouts.dart';
import 'package:mobile_computing/pages/add_workout.dart';
import 'package:mobile_computing/widgets/ExerciseCard.dart';
import 'package:mobile_computing/widgets/ActiveCard.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_computing/models/temp_active.dart';
import 'package:mobile_computing/models/add_workouts.dart';


class WorkoutPage extends StatefulWidget {
  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}


class _WorkoutPageState extends State<WorkoutPage> {
  List workouts = ["3K Jog", "Bench Press", "Dead Lifts", "Sprints", "2K Walk"];
  final _random = Random();

  bool loading = true;

  Map<dynamic, dynamic>? exercises;

  late final dbRef = FirebaseDatabase.instance.reference();
  late DatabaseReference databaseReference;

  List exe = [];
  String front_img = "";
  String back_img = "";

  @override
  void initState(){
    super.initState();
    _activateListeners();
  }

  final Stream<QuerySnapshot> users = FirebaseFirestore.instance.collection('userData').snapshots();
  
  void _activateListeners(){
    dbRef.child('exercises').onValue.listen((event) {
      final List tmp = (event.snapshot.value as List);
      setState(() {
        print(tmp);
        // exe = tmp;
        for (var e in tmp){
          exe.add(e);
        }
        loading = false;
      });
    });

    for (var e in added_workouts){
      exe.add(e);
      print(e);
    }

    dbRef.child('back_img').onValue.listen((event) {
      final String tmp = (event.snapshot.value as String);
      setState(() {
        print(tmp);
        back_img = tmp;
      });
    });

    dbRef.child('front_img').onValue.listen((event) {
      final String tmp = (event.snapshot.value as String);
      setState(() {
        print(tmp);
        front_img = tmp;
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    
    if (loading){
      return CircularProgressIndicator();
    }

    return Scaffold(

    
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context, 
                delegate: CustomSearchDelegate(exe, front_img, back_img));
                print('FROM SEARCH DELEGATE');
                print(exe[exe.length-1]);
              }, 
            icon: const Icon(Icons.search),
          )
        ],
        title: const Text("Workouts"),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: ((context) => AddWorkoutPage())));
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.center,
                  child:
                      Text(
                        "Active Workouts", 
                        style: TextStyle(
                          fontSize: 30, 
                          fontWeight: FontWeight.bold
                        )
                      )
                    )
                ),

                if(active.isEmpty) const Text("No Workouts Currently Active :(")

                else Center(child: SizedBox(height: MediaQuery.of(context).size.height * 0.7,child: SingleChildScrollView(child: Column(children: getActive()))))

                // else 
          // SizedBox(
          //   height: 400,
          //   child: CupertinoScrollbar(
          //     child: ListView(
          //       shrinkWrap: true,
          //       children: [
          //         for (int i = 0; i < exe.length; i++)
          //           exerciseCard(exe[i], front_img, back_img, context)
          //       ],
          //     ),
          //   ),
          // ),

          // StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('userData').snapshots(), builder: (
          //     BuildContext context, 
          //     AsyncSnapshot<QuerySnapshot> snapshot
          //   ){
          //     if(snapshot.hasData){
          //       return Text("Loading...");
          //     }

          //     if(snapshot.connectionState == ConnectionState.waiting){
          //       return CircularProgressIndicator();
          //     }

          //     final data = snapshot.data;

          //     return Text(data.toString());

          //     // return ListView.builder(
          //     //   itemCount: data.size,
          //     //   itemBuilder: (context, index){
          //     //     return Text(data.docs['active_workouts']['name']);
          //     //   }
          //     // );
          // })

        ],
      ));
  }
 List<Widget> getActive(){

  List<Widget> tmp = [];

  List.generate(active.length, (index) {
    tmp.add(activeCard(active[index], front_img, back_img, context));
  });

  return tmp;
} 
}

class CustomSearchDelegate extends SearchDelegate {

  final List exe; 
  final String front_img;
  final String back_img;

  CustomSearchDelegate(this.exe, this.front_img, this.back_img);

  @override
  List<Widget>? buildActions(BuildContext context) {

    IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () {
        query = '';
      },
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {

    return IconButton(
      onPressed: () {
        close(context, null);
        },
      icon: const Icon (Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    // bool loading = true;
    List matchQuery = [];


    for (var tmp in exe){
      if(tmp['name'].toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(tmp);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index){
        var result = matchQuery[index];
        return exerciseCard(result, front_img, back_img, context);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List matchQuery = [];

    for (var tmp in exe){
      if(tmp['name'].toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(tmp);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index){
        var result = matchQuery[index];
        return exerciseCard(result, front_img, back_img, context);
      },
    );
  }

}
