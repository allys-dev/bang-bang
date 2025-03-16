import 'package:bang_bang/data/notifiers.dart';
import 'package:flutter/material.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        return NavigationBar(
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.assignment),
              label: "Mission",
            ),
            NavigationDestination(
              icon: Icon(Icons.emoji_events),
              label: "Scoreboard",
            ),
            NavigationDestination(
              icon: Icon(Icons.help_outline),
              label: "Help",
            ),
          ],
          onDestinationSelected: (int value) {
            selectedPageNotifier.value = value;
          },
          selectedIndex: selectedPage,
        );
      },
    );
  }
}
