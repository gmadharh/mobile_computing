import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text("Profile"),
    ),
    body: const Center(child: Text("Profile Page")),
  );
}