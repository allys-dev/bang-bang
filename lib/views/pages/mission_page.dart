import 'package:flutter/material.dart';
import 'package:bang_bang/widgets/navbar_widget.dart';

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
            Text("TOP SECRET"),
            Text("Mission"),
            Text("Your Target"),
            Text("Player B"),
            Text("Object"),
            Text("Bottle"),
            Text("Location"),
            Text("Office"),
            ElevatedButton(
              onPressed: () {
                print("Eliminated");
              },
              child: Text("ELIMINATE"),
            ),
            ElevatedButton(
              onPressed: () {
                print("Overhead");
              },
              child: Text("OVERHEAD A KILL"),
            ),
          ],
        ),
      );
  }
}
