import 'package:bang_bang/data/constants.dart';
import 'package:bang_bang/main.dart';
import 'package:bang_bang/providers/local_data_notifier_provider.dart';
import 'package:bang_bang/providers/player_notifier_provider.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          (ref
                          .watch(
                            playerNotifierProvider(
                              ref.read(localDataNotifierProvider).playerId,
                            ),
                          )
                          .playerName ==
                      "Error" ||
                  ref
                          .watch(
                            playerNotifierProvider(
                              ref.read(localDataNotifierProvider).playerId,
                            ),
                          )
                          .playerName ==
                      "Unknown")
              ? const Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  Text("TOP SECRET", style: KTextStyle.heading1),
                  Text("Mission", style: KTextStyle.heading2),
                  SizedBox(height: 20),
                  Text("Your Target", style: KTextStyle.heading4),
                  Text(
                    ref
                        .watch(
                          playerNotifierProvider(
                            ref.read(localDataNotifierProvider).playerId,
                          ),
                        )
                        .targetName,
                    style: KTextStyle.heading3,
                  ),
                  SizedBox(height: 10),
                  Text("Object", style: KTextStyle.heading4),
                  Text(
                    ref
                        .watch(
                          playerNotifierProvider(
                            ref.read(localDataNotifierProvider).playerId,
                          ),
                        )
                        .object,
                    style: KTextStyle.heading3,
                  ),
                  SizedBox(height: 10),
                  Text("Location", style: KTextStyle.heading4),
                  Text(
                    ref
                        .watch(
                          playerNotifierProvider(
                            ref.read(localDataNotifierProvider).playerId,
                          ),
                        )
                        .location,
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
                              "Are you sure you want to eliminate ${ref.watch(playerNotifierProvider(ref.read(localDataNotifierProvider).playerId)).targetName}?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  print("Elimination Cancelled");
                                  Navigator.of(context).pop();
                                },
                                child: Text("NO"),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Logic to eliminate the target
                                  requestElimination();
                                  print("Elimination Requested");
                                  Navigator.of(context).pop();
                                },
                                child: Text("YES"),
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

  void requestElimination() async {
    // Get target ID
    final targetData =
        await supabase
            .from('players')
            .select()
            .eq('game_code', ref.read(localDataNotifierProvider).gameCode)
            .eq(
              'player_name',
              ref
                  .read(
                    playerNotifierProvider(
                      ref.read(localDataNotifierProvider).playerId,
                    ),
                  )
                  .targetName,
            )
            .single();

    await supabase.from('eliminations').insert({
      'requestor_id': ref.read(localDataNotifierProvider).playerId,
      'responder_id': targetData['id'],
      'game_code': ref.read(localDataNotifierProvider).gameCode,
    });
  }
}
