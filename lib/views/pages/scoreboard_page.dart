import 'package:flutter/material.dart';

class ScoreboardPage extends StatelessWidget {
  const ScoreboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("Scoreboard"),
          Text("???: 0 kills"),
          Divider(),
          Text("???: 0 kills"),
          Divider(),
          Text("???: 0 kills"),
          Divider(),
          Text("???: 0 kills"),
          Divider(),
        ],
      ),
    );
  }
}
