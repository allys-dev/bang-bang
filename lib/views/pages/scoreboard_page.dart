import 'package:bang_bang/data/constants.dart';
import 'package:bang_bang/providers/local_data_notifier_provider.dart';
import 'package:bang_bang/providers/players_stream_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScoreboardPage extends ConsumerStatefulWidget {
  const ScoreboardPage({super.key});

  @override
  ConsumerState<ScoreboardPage> createState() => _ScoreboardPageState();
}

class _ScoreboardPageState extends ConsumerState<ScoreboardPage> {
  @override
  Widget build(BuildContext context) {


    final playersAsyncValue = ref.watch(playersStreamProvider(ref.read(localDataNotifierProvider).gameCode));
    
    return Center(
      child: Column(
        children: [
          Text("Scoreboard", style: KTextStyle.heading1),
          SizedBox(height: 50),
          playersAsyncValue.when(
            data: (players) {
              // Sort players by kills in descending order
              final sortedPlayers = [...players]..sort((a, b) => b.score.compareTo(a.score));
              return Container(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(border: Border.all()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final player in sortedPlayers) ...[
                      Text("???: ${player.score} kills", style: KTextStyle.heading4),
                      Divider(),
                    ],
                  ],
                ),
              );
            },
            loading: () => CircularProgressIndicator(),
            error: (err, stack) => Text('Error: $err'),
          ),
        ],
      ),
    );
  }
}
