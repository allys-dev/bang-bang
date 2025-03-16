import 'package:bang_bang/data/notifiers.dart';
import 'package:bang_bang/views/pages/how_to_page.dart';
import 'package:bang_bang/views/pages/mission_page.dart';
import 'package:bang_bang/views/pages/scoreboard_page.dart';
import 'package:bang_bang/widgets/navbar_widget.dart';
import 'package:flutter/material.dart';

List<Widget> pages = [
  MissionPage(),
  ScoreboardPage(),
  HowToPage(),
];

class GameTree extends StatelessWidget {
  const GameTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return pages.elementAt(selectedPage);
        },
      ),
      bottomNavigationBar: NavbarWidget(),
    );
  }
}
