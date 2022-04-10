import 'package:flutter/material.dart';
import 'package:mobile_computing/pages/single_workout.dart';
import 'package:mobile_computing/models/temp_active.dart';
import 'package:mobile_computing/providers/ActiveProvider.dart';

Widget activeCard(Map exe, String front_img, String back_img, context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SingleWorkout(exe, front_img, back_img))),
            trailing: IconButton(
              onPressed: () {
                // CODE FOR COMPLETING WORKOUT TO ACTIVE WORKOUTS
                active.removeWhere((e) => e['uuid']== exe['uuid']);

              },
              icon: Icon(Icons.check),
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
      ),
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