import 'package:bang_bang/data/constants.dart';
// import 'package:bang_bang/main.dart';
// import 'package:bang_bang/models/player.dart';
// import 'package:bang_bang/providers/local_data_notifier_provider.dart';
import 'package:bang_bang/providers/player_notifier_provider.dart';
// import 'package:bang_bang/providers/player_provider.dart';
// import 'package:bang_bang/providers/players_stream_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MissionPage extends ConsumerStatefulWidget {
  const MissionPage({super.key});

  @override
  ConsumerState<MissionPage> createState() => _MissionPageState();
}

class _MissionPageState extends ConsumerState<MissionPage> {
  late final SupabaseStreamBuilder gameStream;
  bool playerUpdated = false;

  @override
  void initState() {
    super.initState();

    // updatePlayer();

    // TODO - should probably be moved to a notifier
    // supabase
    //     .channel('players')
    //     .onPostgresChanges(
    //       event: PostgresChangeEvent.all,
    //       schema: 'public',
    //       table: 'players',
    //       filter: PostgresChangeFilter(
    //         type: PostgresChangeFilterType.eq,
    //         column: 'game_code',
    //         value: ref.read(localDataNotifierProvider).gameCode,
    //       ),
    //       callback: (payload) {
    //         print('Postgres Change! New record: ${payload.newRecord}');
    //       },
    //     )
    //     .subscribe();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          (ref.watch(playerNotifierProvider).playerName == "Error" ||
                  ref.watch(playerNotifierProvider).playerName == "Unknown")
              ? const Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  Text("TOP SECRET", style: KTextStyle.heading1),
                  Text("Mission", style: KTextStyle.heading2),
                  SizedBox(height: 20),
                  Text("Your Target", style: KTextStyle.heading4),
                  Text(
                    ref.watch(playerNotifierProvider).targetName,
                    style: KTextStyle.heading3,
                  ),
                  SizedBox(height: 10),
                  Text("Object", style: KTextStyle.heading4),
                  Text(
                    ref.watch(playerNotifierProvider).object,
                    style: KTextStyle.heading3,
                  ),
                  SizedBox(height: 10),
                  Text("Location", style: KTextStyle.heading4),
                  Text(
                    ref.watch(playerNotifierProvider).location,
                    style: KTextStyle.heading3,
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      print("Eliminate Pressed");
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog.adaptive(
                            title: Text("Confirm Elimination"),
                            content: Text(
                              "Are you sure you want to eliminate ${ref.watch(playerNotifierProvider).targetName}?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("No"),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Logic to eliminate the target
                                  print("Target eliminated!");
                                  Navigator.of(context).pop();
                                },
                                child: Text("Yes"),
                              ),
                            ],
                          );
                        },
                      );
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

  // void updatePlayer() async {
  //   print("Updating player...");
  //   final data = await supabase
  //       .from('players')
  //       .select()
  //       .eq('player_name', ref.read(playerNotifierProvider).playerName)
  //       .eq('game_code', ref.read(playerNotifierProvider).gameCode);

  //   ref
  //       .read(playerNotifierProvider.notifier)
  //       .setPlayerName(data[0]['player_name']);
  //   ref
  //       .read(playerNotifierProvider.notifier)
  //       .setTargetName(data[0]['target_name']);
  //   ref.read(playerNotifierProvider.notifier).setObject(data[0]['object']);
  //   ref.read(playerNotifierProvider.notifier).setLocation(data[0]['location']);

  //   playerUpdated = true;
  //   setState(() {});
  //   print("Player updated!");
  // }
}
