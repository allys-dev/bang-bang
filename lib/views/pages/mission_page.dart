import 'package:bang_bang/data/constants.dart';
import 'package:bang_bang/main.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MissionPage extends StatefulWidget {
  const MissionPage({super.key, required this.playerName, required this.gameCode});

  final String playerName;
  final String gameCode;

  @override
  State<MissionPage> createState() => _MissionPageState();
}

class _MissionPageState extends State<MissionPage> {
  late final SupabaseStreamBuilder gameStream;
  // final String object = 'loading';
  // final String location = 'loading';
  // final String target = 'loading';

  @override
  void initState() {
    super.initState();

    supabase
        .channel('players')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'players',
          filter: PostgresChangeFilter(type: PostgresChangeFilterType.eq, column: 'game_code', value: value),
          callback: (payload) {
            
          },
        )
        .subscribe();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("TOP SECRET", style: KTextStyle.heading1),
          Text("Mission", style: KTextStyle.heading2),
          SizedBox(height: 20),
          Text("Your Target", style: KTextStyle.heading4),
          Text("Player B", style: KTextStyle.heading3),
          SizedBox(height: 10),
          Text("Object", style: KTextStyle.heading4),
          Text("Bottle", style: KTextStyle.heading3),
          SizedBox(height: 10),
          Text("Location", style: KTextStyle.heading4),
          Text("Office", style: KTextStyle.heading3),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              print("Eliminated");
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
}
