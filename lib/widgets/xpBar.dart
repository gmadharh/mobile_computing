import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class LevelBar extends StatefulWidget {
  const LevelBar({Key? key}) : super(key: key);

  @override
  _LevelBarState createState() => _LevelBarState();
}

class _LevelBarState extends State<LevelBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: LinearPercentIndicator(
        width: (MediaQuery.of(context).size.width / 4) * 3,
        percent: 60 / 100,
        animation: true,
        animationDuration: 1500,
        leading: const Text("Lvl 3", style: TextStyle(fontSize: 18)),
        trailing: const Text("Lvl 4", style: TextStyle(fontSize: 18)),
        progressColor: Colors.greenAccent,
      ),
    );
  }
}
