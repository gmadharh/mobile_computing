import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text("Settings"),
    ),
    body: const Center(child: Text("Settings Page")),
  );
}