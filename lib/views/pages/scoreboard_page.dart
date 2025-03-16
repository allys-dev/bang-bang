import 'package:bang_bang/data/constants.dart';
import 'package:flutter/material.dart';

class ScoreboardPage extends StatelessWidget {
  const ScoreboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("Scoreboard", style: KTextStyle.heading1),
          SizedBox(height: 50),
          Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(border: Border.all()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("???: 0 kills", style: KTextStyle.heading4),
                Divider(),
                Text("???: 0 kills", style: KTextStyle.heading4),
                Divider(),
                Text("???: 0 kills", style: KTextStyle.heading4),
                Divider(),
                Text("???: 0 kills", style: KTextStyle.heading4),
                Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
