import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_computing/models/temp_active.dart';

class SingleWorkout extends StatefulWidget {
  
  final exe;
  final front_img;
  final back_img;

  SingleWorkout(this.exe, this.front_img, this.back_img);

  @override
  _SingleWorkoutState createState() => _SingleWorkoutState(exe, front_img, back_img);

}

class _SingleWorkoutState extends State<SingleWorkout> {

  final exe;
  final front_img;
  final back_img;

  _SingleWorkoutState(this.exe, this.front_img, this.back_img);

  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(exe['name']),
        actions: [
          IconButton(
            onPressed: () {
              active.add(exe);
            }, 
            icon: const Icon(Icons.add), 
            splashColor: Colors.blue[800],
          )
        ],
      ),

      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Description',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                  ),
                ),
              ),

              // if(exe['desc'] == "") exe['desc'] = ("No Description :("),

              Padding(
                padding: const EdgeInsets.only(left:12.0, right: 12, top: 5, bottom: 20),
                child: Text(
                  exe['desc'] == "" ? 'No Description :(' : exe['desc'],
                  style: const TextStyle(fontSize: 17),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'XP Return: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                      ),

                    ),

                    Text(exe['weight'].toString(), style: const TextStyle(fontSize: 30),)
                  ],
                ),
              ),

              if(exe['equipment'][0]['id'] != -1) const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Equipment',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                  ),
                ),
              ),

              if(exe['equipment'][0]['id'] != -1) Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  getEquip(),
                  style: const TextStyle(fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ),

              if(exe['muscles'][0]['id'] != -1) const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Main Muscle(s)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                  ),
                ),
              ),

              if(exe['muscles'][0]['id'] != -1) Stack(
                children: getMainMuscles()
              ),

              if(exe['muscles_secondary'][0]['id'] != -1) const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Secondary Muscle(s)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                  ),
                ),
              ),

              if(exe['muscles_secondary'][0]['id'] != -1) Stack(
                children: getSecMuscles()
              )

            ],
          ),
        ),
      ),
    );
  }

  String getEquip (){
    String equip = "";
    List.generate((exe['equipment'] as List).length, (index) {
      equip += exe['equipment'][index]['name'];
      if(index != (exe['equipment'] as List).length-1){
        equip += ", ";
      }
      // return Text(exe['equipment'][index]['name']);
    });

    return equip;
  }

  List<Widget> getMainMuscles(){

    List<Widget> tmp = [];

    if(exe['muscles'][0]['is_front']){
      tmp.add(SvgPicture.network(
            front_img,
            placeholderBuilder: (context) => CircularProgressIndicator(),
            height: 128.0,
          ),);
    }else{
      tmp.add(SvgPicture.network(
            back_img,
            placeholderBuilder: (context) => CircularProgressIndicator(),
            height: 128.0,
          ),);
    }

    List.generate(exe['muscles'].length, (index) {
      tmp.add(SvgPicture.network(
            exe['muscles'][index]['image_url_main'],
            placeholderBuilder: (context) => CircularProgressIndicator(),
            height: 128.0,
          ),);
    });

    return tmp;
  }


    List<Widget> getSecMuscles(){

    List<Widget> tmp = [];

    if(exe['muscles_secondary'][0]['is_front']){
      tmp.add(SvgPicture.network(
            front_img,
            placeholderBuilder: (context) => CircularProgressIndicator(),
            height: 128.0,
          ),);
    }else{
      tmp.add(SvgPicture.network(
            back_img,
            placeholderBuilder: (context) => CircularProgressIndicator(),
            height: 128.0,
          ),);
    }

    List.generate(exe['muscles_secondary'].length, (index) {
      tmp.add(SvgPicture.network(
            exe['muscles_secondary'][index]['image_url_secondary'],
            placeholderBuilder: (context) => CircularProgressIndicator(),
            height: 128.0,
          ),);
    });

    return tmp;
  }
}