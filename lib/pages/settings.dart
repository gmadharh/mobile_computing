import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

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
              onPressed: (BuildContext context) {},),
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
            SettingsTile.navigation(
              title: Text('Unit'),
              value: Text('km/miles'),
              leading: Icon(Icons.straighten),
              onPressed: (BuildContext context) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const unitPage())
                );
              },),
            SettingsTile(
              title: Text('Reset'),
              leading: Icon(Icons.rotate_left),
              onPressed: (BuildContext context) {},),
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
                title: Text('Version: v1.0'),
                leading: Icon(Icons.handyman),)
            ])
      ]);
  }
}

class unitPage extends StatelessWidget {
  const unitPage({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unit'),
      ),
      body: Center(child: Text('Selection Page')),
    );
  }
}

class contactPage extends StatelessWidget {
  const contactPage({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
      ),
      body: Center(child: Text('Contact Page')),
    );
  }
}