import 'package:flutter/material.dart';
import 'package:mobile_computing/widgets/xpBar.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:mobile_computing/widgets/questsDummyData.dart';

class QuestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            "Quests",
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              LevelBar(),
              CalendarWidget(),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: QuestData(),
              ),
            ],
          ),
        ),
      );
}

// class ExperienceBar extends StatelessWidget {
//   final double percent;
//   const ExperienceBar({
//     required this.percent,
//     Key? key,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return LinearPercentIndicator(
//       percent: percent,
//       backgroundColor: Colors.grey,
//       progressColor: Colors.black,
//     );
//   }
// }

class CalendarWidget extends StatelessWidget {
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

class QuestData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < questData.length; i++)
          QuestCards(
            type: questData[i]["type"],
            quest: questData[i]["quest"],
            reward: questData[i]["reward"],
            isComplete: questData[i]["isComplete"],
          )
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
  Widget build(BuildContext context) {
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
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text("REWARD: "),
                  Text(reward),
                  isComplete
                      ? const Icon(Icons.check_box)
                      : const Icon(Icons.check_box_outline_blank),
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
