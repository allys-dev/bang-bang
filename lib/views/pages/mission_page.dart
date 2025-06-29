import 'package:bang_bang/data/constants.dart';
import 'package:bang_bang/data/hive_repository.dart';
import 'package:bang_bang/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MissionPage extends ConsumerStatefulWidget {
  const MissionPage({super.key});

  // final String playerName;
  // final String gameCode;

  @override
  ConsumerState<MissionPage> createState() => _MissionPageState();
}

class _MissionPageState extends ConsumerState<MissionPage> {
  late final SupabaseStreamBuilder gameStream;
  bool playerUpdated = false;

  @override
  void initState() {
    super.initState();

    updatePlayer();

    supabase
        .channel('players')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'players',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'game_code',
            value: ref.read(hiveRepositoryProvider).getGameCode(),
          ),
          callback: (payload) {
            print('Postgres Change! New record: ${payload.newRecord}');
            // ref
            //     .read(hiveRepositoryProvider)
            //     .setTargetName(payload.newRecord['target_name']);
            // ref
            //     .read(hiveRepositoryProvider)
            //     .setObject(payload.newRecord['object']);
            // ref
            //     .read(hiveRepositoryProvider)
            //     .setLocation(payload.newRecord['location']);
          },
        )
        .subscribe();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          !playerUpdated
              ? const Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  Text("TOP SECRET", style: KTextStyle.heading1),
                  Text("Mission", style: KTextStyle.heading2),
                  SizedBox(height: 20),
                  Text("Your Target", style: KTextStyle.heading4),
                  Text(
                    ref.read(hiveRepositoryProvider).getTargetName(),
                    style: KTextStyle.heading3,
                  ),
                  SizedBox(height: 10),
                  Text("Object", style: KTextStyle.heading4),
                  Text(
                    ref.read(hiveRepositoryProvider).getObject(),
                    style: KTextStyle.heading3,
                  ),
                  SizedBox(height: 10),
                  Text("Location", style: KTextStyle.heading4),
                  Text(
                    ref.read(hiveRepositoryProvider).getLocation(),
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
                              "Are you sure you want to eliminate ${ref.read(hiveRepositoryProvider).getTargetName()}?",
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

  void updatePlayer() async {
    print("Updating player...");
    final data = await supabase
        .from('players')
        .select()
        .eq('player_name', ref.read(hiveRepositoryProvider).getPlayerName())
        .eq('game_code', ref.read(hiveRepositoryProvider).getGameCode());

    ref.read(hiveRepositoryProvider).setPlayerName(data[0]['player_name']);
    ref.read(hiveRepositoryProvider).setTargetName(data[0]['target_name']);
    ref.read(hiveRepositoryProvider).setObject(data[0]['object']);
    ref.read(hiveRepositoryProvider).setLocation(data[0]['location']);

    playerUpdated = true;
    setState(() {});
    print("Player updated!");
  }
}
