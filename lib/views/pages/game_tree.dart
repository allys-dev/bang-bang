import 'package:bang_bang/data/notifiers.dart';
import 'package:bang_bang/main.dart';
import 'package:bang_bang/models/elimination.dart';
import 'package:bang_bang/providers/elimination_stream_provider.dart';
import 'package:bang_bang/providers/player_notifier_provider.dart';
// import 'package:bang_bang/providers/players_stream_provider.dart';
import 'package:bang_bang/providers/local_data_notifier_provider.dart';
import 'package:bang_bang/providers/players_stream_provider.dart';
import 'package:bang_bang/views/pages/how_to_page.dart';
import 'package:bang_bang/views/pages/mission_page.dart';
import 'package:bang_bang/views/pages/scoreboard_page.dart';
import 'package:bang_bang/widgets/navbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Widget> pages = [MissionPage(), ScoreboardPage(), HowToPage()];

class GameTree extends ConsumerStatefulWidget {
  const GameTree({super.key});
  @override
  ConsumerState<GameTree> createState() => _GameTreeState();
}

class _GameTreeState extends ConsumerState<GameTree> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(
      playerNotifierProvider(ref.read(localDataNotifierProvider).playerId),
    );
    ref.watch(
      eliminationStreamProvider(ref.read(localDataNotifierProvider).gameCode),
    );

    // ref.read(eliminationStreamProvider(ref.read(localDataNotifierProvider).gameCode)
    // );

    ref.listen<
      AsyncValue<List<Elimination>>
    >(eliminationStreamProvider(ref.read(localDataNotifierProvider).gameCode), (
      previous,
      next,
    ) {
      print("Elimination stream has new data");
      next.when(
        data: (currentEliminations) {
          for (final elimination in currentEliminations) {
            if (!elimination.attackerSeen &&
                elimination.attackerId ==
                    ref.read(localDataNotifierProvider).playerId) {
              if (elimination.targetConfirmation == true) {
                // Add a point to the attacker
                ref.read(playerNotifierProvider(
                  elimination.attackerId,
                ).notifier).addPoint();

                // Transfer mission from target to attacker
                ref.read(playersStreamProvider(
                  ref.read(localDataNotifierProvider).gameCode).notifier
                ).transferMission(
                  elimination.attackerId,
                  elimination.targetId,
                );

                // Mark the elimination as seen
                ref
                    .read(
                      eliminationStreamProvider(
                        ref.read(localDataNotifierProvider).gameCode,
                      ).notifier,
                    )
                    .setAttackerSeen(elimination.id);

              } else if (elimination.targetConfirmation == false) {
                _showDeniedDialog(elimination);

                // Mark the elimination as seen
                ref
                    .read(
                      eliminationStreamProvider(
                        ref.read(localDataNotifierProvider).gameCode,
                      ).notifier,
                    )
                    .setAttackerSeen(elimination.id);
              } else {
                print(
                  "Still waiting on confirmation for elimination: ${elimination.id}",
                );
              }
            }

            if (elimination.targetId ==
                    ref.read(localDataNotifierProvider).playerId &&
                elimination.targetConfirmation == null) {
              // Handle the responder's actions if needed
              print(
                "Responder for elimination: ${elimination.id} is the current player",
              );

              WidgetsBinding.instance.addPostFrameCallback((_) {
                print("Showing elimination dialog for: ${elimination.id}");
                _showEliminationDialog(elimination);
              });
            }
          }
        },
        error: (error, stack) {
          print("Elimination stream error: $error");
        },
        loading: () {
          print("Elimination stream loading");
        },
      );
    });

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

  void _showDeniedDialog(Elimination elimination) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Elimination Denied'),
        content: Text(
          'Word is you tried to eliminate ${ref.read(playerNotifierProvider(elimination.targetId)).playerName}, but they denied it.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showEliminationDialog(Elimination elimination) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Bang Bang You\'re Dead!'),
            content: Text(
              'Word is ${ref.read(playerNotifierProvider(elimination.attackerId)).playerName} murdered you, is this true?',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  ref
                      .read(
                        eliminationStreamProvider(
                          ref.read(localDataNotifierProvider).gameCode,
                        ).notifier,
                      )
                      .setTargetConfirmation(elimination.id, true);
                  Navigator.of(context).pop();
                },
                child: Text('YES'),
              ),
              TextButton(
                onPressed: () {
                  ref
                      .read(
                        eliminationStreamProvider(
                          ref.read(localDataNotifierProvider).gameCode,
                        ).notifier,
                      )
                      .setTargetConfirmation(elimination.id, false);
                  Navigator.of(context).pop();
                },
                child: Text('NO'),
              ),
            ],
          ),
    );
  }
}
