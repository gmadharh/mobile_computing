// Abdul Mahmoud
// March 8, 2022
// Swagmasters V2
// Profile Page
// Milestone 2
// CIS*4030 

import 'package:flutter/material.dart';
import 'package:mobile_computing/models/temp_invent.dart';

class ProfilePage extends StatefulWidget{
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  double xp = 35.0; 
  double targetXP = 100.0;
  var level = 3;


  @override
  Widget build (BuildContext context){
    return Scaffold(
    appBar: AppBar(
      title: const Text("Profile"),
    ),
    body: Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [
          
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
      
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(level.toString()),
                  ),
      
                  SizedBox(
                    width: (MediaQuery.of(context).size.width / 4) * 3,
                    height: 20,
                    child: LinearProgressIndicator(
                      value: xp/targetXP,
                      valueColor: const AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 63, 63, 63)),
                      backgroundColor: const Color.fromARGB(255, 196, 196, 196),
                    )
                  ),
      
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text((level + 1).toString()),
                  ),
                ],
              ),
            ),
      
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Inventory", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),
      
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(color: Color.fromARGB(255, 196, 196, 196)),
              height: MediaQuery.of(context).size.height / 2.5,
              width:  MediaQuery.of(context).size.width - 20,
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
                              child: Image(image: AssetImage("lib/images/${items[index]['img']}"),)),
                            Text(items[index]['item'])
                          ],
                        ),
                        trailing: Text("Requirement: " + items[index]['req'], style: const TextStyle(fontSize: 16),),
                        ),
                    );
                  }),
                ),
              ),
            ),
      
      
            const Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text("Stat Points: 0", style: TextStyle(fontSize: 20),),
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ListTile(
                    leading: const Text("DEX: 24", style: TextStyle(fontSize: 30),),
                    trailing: ElevatedButton(
                      onPressed: (){}, 
                      child: const Icon(Icons.add, color: Colors.black,),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 196, 196, 196))
                      ),
                      
                    )
                  ),
                  ListTile(
                    leading: const Text("STR: 9", style: TextStyle(fontSize: 30),),
                    trailing: ElevatedButton(
                      onPressed: (){}, 
                      child: const Icon(Icons.add, color: Colors.black,),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 196, 196, 196))
                      ),
                    )
                  ),
                  ListTile(
                    leading: const Text("INT: 7", style: TextStyle(fontSize: 30),),
                    trailing: ElevatedButton(
                      onPressed: (){}, 
                      child: const Icon(Icons.add, color: Colors.black,),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 196, 196, 196))
                      ),
                    )
                  ),
                ]),
            )
          
          
          ],
        ),
      ),
    ),
  );
  }
}