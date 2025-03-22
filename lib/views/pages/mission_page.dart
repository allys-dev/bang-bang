import 'package:bang_bang/data/constants.dart';
import 'package:flutter/material.dart';

class MissionPage extends StatefulWidget {
  const MissionPage({super.key});

  @override
  State<MissionPage> createState() => _MissionPageState();
}

class _MissionPageState extends State<MissionPage> {
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("TOP SECRET", style: KTextStyle.heading1),
          Text("Mission", style: KTextStyle.heading2),
          SizedBox(height: 20),
          Text("Your Target", style: KTextStyle.heading4),
          Text("Player B", style: KTextStyle.heading3),
          SizedBox(height: 10),
          Text("Object", style: KTextStyle.heading4),
          Text("Bottle", style: KTextStyle.heading3),
          SizedBox(height: 10),
          Text("Location", style: KTextStyle.heading4),
          Text("Office", style: KTextStyle.heading3),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              print("Eliminated");
            },
            child: Text("ELIMINATE", style: KTextStyle.heading2),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              print("Overhead");
            },
            child: Text("OVERHEAD A KILL", style: KTextStyle.heading4),
          ),
        ],
      ),
    );
  }
}
