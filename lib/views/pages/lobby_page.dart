import 'package:bang_bang/data/constants.dart';
import 'package:bang_bang/data/hive_repository.dart';
import 'package:bang_bang/main.dart';
import 'package:bang_bang/views/pages/game_tree.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LobbyPage extends ConsumerStatefulWidget {
  const LobbyPage({super.key, required this.isCreator});

  final bool isCreator;

  @override
  ConsumerState<LobbyPage> createState() => _LobbyPageState();
}

class _LobbyPageState extends ConsumerState<LobbyPage> {
  late final SupabaseStreamBuilder playersStream;
  late final int? totalPlayers;
  
  int joinedPlayers = 0;

  @override
  void initState(){
    super.initState();
    getTotalPlayers();
    playersStream = supabase
        .from('players')
        .stream(primaryKey: ['id'])
        .eq('game_code', ref.read(hiveRepositoryProvider).getGameCode());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("Room Code:", style: KTextStyle.heading3),
          Text(ref.read(hiveRepositoryProvider).getGameCode().toString(), style: KTextStyle.heading1),
          SizedBox(height: 50),
          widget.isCreator
              ? Text(
                "Begin game once all\nplayers have joined",
                style: KTextStyle.heading4,
              )
              : Text(
                "Waiting for room\ncreator to begin game",
                style: KTextStyle.heading4,
              ),
          SizedBox(height: 50),
          StreamBuilder(
            stream: playersStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final table = snapshot.data!;
              joinedPlayers = table.length;
              String waitString =
                  "Waiting for Players to Join: ${table.length}/$totalPlayers";

              return Column(
                children: [
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: table.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(table[index]['player_name'].toString()),
                      );
                    },
                  ),
                  Text(waitString),
                ],
              );
            },
          ),
          SizedBox(height: 50),
          Text(
            "Everyone is an assassin\nand everyone is a target.",
            style: KTextStyle.heading4,
          ),
          SizedBox(height: 50),
          widget.isCreator
              ? ElevatedButton(
                onPressed: () {
                  //randomise
                  shuffleMissions();
                  
                  //set gameStarted to true
                  startGame();

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const GameTree();
                      },
                    ),
                  );
                },
                child: Text('BEGIN', style: KTextStyle.heading2),
              )
              : SizedBox(),
        ],
      ),
    );
  }

  Future<void> getTotalPlayers() async {
    final data = await supabase
        .from('game_rooms')
        .select('game_code, players')
        .eq('game_code', ref.read(hiveRepositoryProvider).getGameCode());
    totalPlayers = data[0]["players"];
  }
  
  Future<void> shuffleMissions() async {
    await supabase.rpc('shuffle_missions');
  }
  
  Future<void> startGame() async {
    await supabase.from('game_rooms').update({'started':'true'}).eq('game_code', ref.read(hiveRepositoryProvider).getGameCode);
  }
}
