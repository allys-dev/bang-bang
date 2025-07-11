import 'package:bang_bang/data/notifiers.dart';
import 'package:bang_bang/main.dart';
import 'package:bang_bang/models/elimination.dart';
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

class GameTree extends ConsumerStatefulWidget {
  const GameTree({super.key});
  @override
  ConsumerState<GameTree> createState() => _GameTreeState();
}

class _GameTreeState extends ConsumerState<GameTree> {
  List<Elimination>? _previousEliminations;

  @override
  Widget build(BuildContext context) {
    ref.watch(
      playerNotifierProvider(ref.read(localDataNotifierProvider).playerId),
    );
    ref.watch(
      eliminationStreamProvider(ref.read(localDataNotifierProvider).gameCode),
    );

    ref.listen<
      AsyncValue<List<Elimination>>
    >(eliminationStreamProvider(ref.read(localDataNotifierProvider).gameCode), (
      previous,
      next,
    ) {
      next.whenData((currentEliminations) {
        print("elimination stream new data");
        // Check previous eliminations for progress
        for (final elimination in currentEliminations) {
          if (!elimination.requestor_seen &&
              elimination.requestorId ==
                  ref.read(localDataNotifierProvider).playerId) {
            if (elimination.confirmation) {
              // Elimination confirmed
              print("Elimination confirmed");
            } else if (!elimination.confirmation) {
              // Elimination cancelled
              print("Elimination cancelled");
            } else {
              print(
                "Still waiting on confirmation for elimination: ${elimination.id}",
              );
            }
          }
        }

        //Check for new eliminations
        List<Elimination> newEliminations;
        if (_previousEliminations != null &&
            _previousEliminations!.isNotEmpty) {
          // Check for new eliminations
          if (currentEliminations.length > _previousEliminations!.length) {
            newEliminations =
                currentEliminations
                    .where(
                      (elimination) =>
                          !_previousEliminations!.any(
                            (prev) => prev.id == elimination.id,
                          ),
                    )
                    .toList();
          } else {
            newEliminations = currentEliminations;
          }
        } else {
          newEliminations = currentEliminations;
        }

        if (newEliminations.isNotEmpty) {
          for (final elimination in newEliminations) {
            // Check responder
            if (elimination.responderId ==
                ref.read(localDataNotifierProvider).playerId) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _showEliminationDialog(elimination);
              });
            }
          }
        }

        _previousEliminations = currentEliminations;
      });
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

  void _showEliminationDialog(Elimination elimination) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Bang Bang You\'re Dead!'),
            content: Text(
              'World is ${ref.read(playerNotifierProvider(elimination.requestorId)).playerName} murdered you, is this true?',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  eliminationResponse(elimination, true);
                  Navigator.of(context).pop();
                },
                child: Text('YES'),
              ),
              TextButton(
                onPressed: () {
                  eliminationResponse(elimination, false);
                  Navigator.of(context).pop();
                },
                child: Text('NO'),
              ),
            ],
          ),
    );
  }

  Future<void> eliminationResponse(
    Elimination elimination,
    bool response,
  ) async {
    await supabase
        .from('eliminations')
        .update({'confirmation': response})
        .eq('id', elimination.id);
  }

  Future<void> eliminationSeen(Elimination elimination, bool response) async {
    await supabase
        .from('eliminations')
        .update({'confirmation': response})
        .eq('id', elimination.id);
  }
}
