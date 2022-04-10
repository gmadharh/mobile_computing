import 'package:flutter/material.dart';
import 'package:mobile_computing/pages/single_workout.dart';
import 'package:mobile_computing/models/temp_active.dart';
import 'package:mobile_computing/providers/ActiveProvider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

Widget exerciseCard(Map exe, String front_img, String back_img, context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SingleWorkout(exe, front_img, back_img, context))),
            trailing: Consumer<ActiveProvider>( builder: ((ctx, value, child) {
            return IconButton(
                onPressed: () {
                  value.addWorkout(exe);
                  Navigator.pop(context);
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