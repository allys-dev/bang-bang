import 'package:bang_bang/data/notifiers.dart';
import 'package:bang_bang/providers/elimination_stream_provider.dart';
import 'package:bang_bang/providers/player_notifier_provider.dart';
// import 'package:bang_bang/providers/players_stream_provider.dart';
import 'package:bang_bang/providers/local_data_notifier_provider.dart';
import 'package:bang_bang/views/pages/how_to_page.dart';
import 'package:bang_bang/views/pages/mission_page.dart';
import 'package:bang_bang/views/pages/scoreboard_page.dart';
import 'package:bang_bang/widgets/navbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Widget> pages = [MissionPage(), ScoreboardPage(), HowToPage()];

class GameTree extends ConsumerWidget {
  const GameTree({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch(
    //   playersStreamProvider(ref.read(localDataNotifierProvider).gameCode),
    // );
    ref.watch(playerNotifierProvider);
    ref.watch(
      eliminationStreamProvider(ref.read(localDataNotifierProvider).gameCode),
    );
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
