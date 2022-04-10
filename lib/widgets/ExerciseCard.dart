import 'package:flutter/material.dart';
import 'package:mobile_computing/pages/single_workout.dart';
import 'package:mobile_computing/models/temp_active.dart';
import 'package:uuid/uuid.dart';

Widget exerciseCard(Map exe, String front_img, String back_img, context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SingleWorkout(exe, front_img, back_img))),
            trailing: IconButton(
              onPressed: () {

                var uuid = Uuid();

                exe['uuid'] = uuid;

                // CODE FOR ADDING WORKOUT TO ACTIVE WORKOUTS
                active.add(exe);
              },
              icon: Icon(Icons.add),
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