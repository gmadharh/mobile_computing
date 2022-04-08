import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mobile_computing/models/temp_invent.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:settings_ui/settings_ui.dart';
import 'dart:async'; 
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:firebase_core/firebase_core.dart';

class SettingsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text("Settings"),
    ),
    body: settingPage(),
  );
}

class settingPage extends StatefulWidget {
  @override
  State<settingPage> createState() => _settingPageState();
}

class _settingPageState extends State<settingPage> {
  bool isSwitched = false;
  bool notif = true;
  bool sound = true;
  String selectedVal = "km";
  List<DropdownMenuItem<String>> get dropItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("km"), value: "km",),
      DropdownMenuItem(child: Text("miles"), value: "miles",),
    ];
    return menuItems;
  }
  CollectionReference userSettings = FirebaseFirestore.instance.collection('userSettings');
  
  @override
  Widget build (BuildContext context) {
    return SettingsList(
      sections: [
        SettingsSection(
          title: Text('General'),
          tiles: [
            SettingsTile(
              title: Text('Change name'),
              leading: Icon(Icons.edit),
              onPressed: (BuildContext context) {
                Alert(
                    context: context,
                    title: "Enter new name",
                    content: Column(
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.edit),
                            labelText: 'New name',
                          ),
                        ),
                      ],
                    ),
                    buttons: [
                      DialogButton(
                        onPressed: () { //button to confirmed name change
                          Navigator.pop(context);
                          final confimration = SnackBar(content: Text('Name Changed!')); 
                          ScaffoldMessenger.of(context).showSnackBar(confimration);},
                        child: Text(
                          "Confirm",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )
                    ]).show();

              },),
            SettingsTile.switchTile(
              initialValue: isSwitched, 
              onToggle: (value) {
                setState(() {
                  isSwitched = value;
                });
              }, 
              title: Text('Dark mode'),
              leading: Icon(Icons.dark_mode),),
            SettingsTile.switchTile(
              initialValue: notif,
              onToggle: (value) {
                setState(() {
                  notif = value;
                },);
              },
              title: Text('Notifications'),
              leading: Icon(Icons.notifications),),
              SettingsTile.switchTile(
              initialValue: sound,
              onToggle: (value) {
                setState(() {
                  sound = value;
                });
              },
              title: Text('SFX'),
              leading: Icon(Icons.volume_up),
            ),
            SettingsTile(
              title: Text('Unit'),
              value: Text('km/miles'),
              leading: Icon(Icons.straighten),
              trailing: DropdownButton(
                value: selectedVal,
                onChanged: (String? newVal) {
                  setState(() {
                    selectedVal = newVal!;
                    userSettings.add({'units': selectedVal});
                  });
                },
                items: dropItems
                ),
              // onPressed: (BuildContext context) {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => const unitPage())
              //   );
              // },
              ),
            SettingsTile(
              title: Text('Reset'),
              leading: Icon(Icons.rotate_left),
              onPressed: (BuildContext context) {
                //action when reset is pressed
              },),
          ]),
          SettingsSection(
            title: Text('About/Support'),
            tiles: [
              SettingsTile.navigation(
                title: Text('Help/Contact'),
                leading: Icon(Icons.contact_support),
                onPressed: (BuildContext context) {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const contactPage())
                );
                },),
              SettingsTile(
                title: Text('Version: v2.0'),
                leading: Icon(Icons.handyman),)
            ])
      ]);
  }
}

class unitPage extends StatefulWidget {
  const unitPage({Key? key}) : super(key:key);

  @override
  _unitPageState createState() => _unitPageState();
}

class _unitPageState extends State<unitPage> {
  final database = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    CollectionReference userSettings = FirebaseFirestore.instance.collection('userSettings');

    return Scaffold(
      appBar: AppBar(
        title: Text('Unit'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () async {
                  userSettings.add({'units': "km"}); //adding to database
                  Navigator.pop(context);
                },
                child: Text("km")),),
                Padding(padding: EdgeInsets.all(8),
                child: ElevatedButton(
                onPressed: () async {
                  userSettings.add({'units': "miles"}); //adding to database
                  Navigator.pop(context);
                },
                child: Text("miles")),)],
            )
          ),
    );
  }
}

class contactPage extends StatefulWidget {
  const contactPage({Key? key}) : super(key:key);

  @override
  _contactPageState createState() => _contactPageState();
}

class _contactPageState extends State<contactPage> {
  final myController = TextEditingController();
  @override
  void dispose(){
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference message = FirebaseFirestore.instance.collection('userMessages');
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
      ),
      body: Center(child: Padding(padding: EdgeInsets.all(20),child: Column(children: [
        Text("Gevin Madharha", style: TextStyle(fontSize: 20),),
        Padding(padding: EdgeInsets.all(8)),
        Text("Kartik Patel ", style: TextStyle(fontSize: 20),),
        Padding(padding: EdgeInsets.all(8)),
        Text("Abdul Mahmoud ", style: TextStyle(fontSize: 20),),
        Padding(padding: EdgeInsets.all(8)),
        Text("Jason Phung", style: TextStyle(fontSize: 20),),
        Padding(padding: EdgeInsets.all(8)),
        Text("Jong Bum Kim", style: TextStyle(fontSize: 20),),
        Padding(padding: EdgeInsets.all(50)),
        ElevatedButton( // contact button
          onPressed: () {
            Alert(
                    context: context,
                    title: "Contact Us: ",
                    content: Column(
                      children: <Widget>[
                        TextField(
                          controller: myController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.contact_support),
                            labelText: 'Message',
                          ),
                        ),
                      ],
                    ),
                    buttons: [
                      DialogButton(
                        onPressed: () { //button to confirmed message has been sent
                          message.add({'message': myController.text}); //add the users message to the database, is not linked with an account yet
                          Navigator.pop(context);
                          final confimration = SnackBar(content: Text('Message Sent!')); 
                          ScaffoldMessenger.of(context).showSnackBar(confimration);},
                          child: Text(
                          "Send",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )
                    ]).show();
          }, 
          child: Text('Contact'))
      ]),)
    ));
  }
}