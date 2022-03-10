import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:mobile_computing/widgets/questsDummyData.dart';

class QuestPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: const Text(
        "Quests",
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.grey,
    ),
    body: 
    SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: ExperienceBar(percent: questData[0]["percent"]),
          ),
          CalendarWidget(),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: QuestData(),
          ),
        ],
      ),
    ),
      backgroundColor: Color.fromARGB(255, 208, 224, 194),
  );
}

class ExperienceBar extends StatelessWidget{
  final double percent;
  const ExperienceBar({
    required this.percent,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RoundedProgressBar(
      childLeft: Text(
        "$percent%",
        style: const TextStyle(color: Colors.white),
      ),
      percent: percent,
      style: RoundedProgressBarStyle(
        colorBorder: Colors.grey,
        colorProgress: Colors.black,
        colorProgressDark: Colors.black,
        backgroundProgress: Colors.grey
      ),
      
    );
  }

}

class CalendarWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: SfCalendar(
          view: CalendarView.month,
          backgroundColor: Colors.white,
          todayHighlightColor: Colors.grey,
        ),
      ),
    );
  }

}

class QuestData extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for(int i = 0; i < questData.length; i++)
        QuestCards(type: questData[i]["type"], quest: questData[i]["quest"], reward: questData[i]["reward"], isComplete: questData[i]["isComplete"],)
      ],
    );
  }

}

class QuestCards extends StatelessWidget {
  final String type;
  final String quest;
  final String reward;
  final bool isComplete;
  const QuestCards({
    required this.type,
    required this.quest,
    required this.reward,
    required this.isComplete,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context){
    return Card(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(type + ": "),
                  Text(quest),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  const Text("REWARD: "),
                  Text(reward),
                  isComplete ? const Icon(Icons.check_box) : const Icon(Icons.check_box_outline_blank),
                ],
              ),
            ],
          ),
        ),
      ),
      color: Colors.grey,
    );
  }
}