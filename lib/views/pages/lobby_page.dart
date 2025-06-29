import 'package:bang_bang/data/constants.dart';
import 'package:bang_bang/main.dart';
import 'package:bang_bang/providers/player_provider.dart';
import 'package:bang_bang/views/pages/game_tree.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LobbyPage extends ConsumerStatefulWidget {
  const LobbyPage({super.key});

  @override
  ConsumerState<LobbyPage> createState() => _LobbyPageState();
}

class _LobbyPageState extends ConsumerState<LobbyPage> {
  late final SupabaseStreamBuilder playersStream;
  late final SupabaseStreamBuilder gameStartStream;
  late final int totalPlayers;
  bool playersInitialised = false;

  int joinedPlayers = 0;
  bool isCreator = false;

  @override
  void initState() {
    super.initState();
    isCreator = ref.read(playerNotifierProvider).isCreator;
    print("Is creator in lobby page: $isCreator");
    print(
      "Game code in lobby page: ${ref.read(playerNotifierProvider).gameCode}",
    );
    getTotalPlayers();
    supabase
        .channel('gameStart')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'game_rooms',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'game_code',
            value: ref.read(playerNotifierProvider).gameCode,
          ),
          callback: (payload) {
            print("Postgres Change!!!");
            print(payload);
            if (payload.newRecord['started'] == true) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const GameTree();
                  },
                ),
              );
            }
          },
        )
        .subscribe();
    playersStream = supabase
        .from('players')
        .stream(primaryKey: ['id'])
        .eq('game_code', ref.read(playerNotifierProvider).gameCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("Room Code:", style: KTextStyle.heading3),
          Text(
            ref.read(playerNotifierProvider).gameCode,
            style: KTextStyle.heading1,
          ),
          SizedBox(height: 50),
          isCreator
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
              if (snapshot.hasError) {
                print("Error in playersStream: ${snapshot.error}");
                return const Center(child: Text("An error occurred"));
              }

              if (!snapshot.hasData ||
                  (snapshot.data as List<dynamic>).isEmpty) {
                print("No data in playersStream");
                return const Center(child: CircularProgressIndicator());
              }

              while (!playersInitialised) {
                print("Waiting for players to be initialised");
                return const Center(child: CircularProgressIndicator());
              }

              // Convert JSArray to Dart List and cast to the correct type
              final List<dynamic> table = List<dynamic>.from(
                snapshot.data as List<dynamic>,
              );
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
                      final player =
                          table[index]
                              as Map<String, dynamic>; // Explicitly cast to Map
                      return ListTile(
                        title: Text(player['player_name'].toString()),
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
          ref.read(playerNotifierProvider).isCreator
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
    print("getting total players");
    final data = await supabase
        .from('game_rooms')
        .select('game_code, players')
        .eq('game_code', ref.read(playerNotifierProvider).gameCode);
    totalPlayers = data[0]["players"];
    playersInitialised = true;
    print("Total players: $totalPlayers");
  }

  Future<void> shuffleMissions() async {
    try {
      // Call the shuffle_missions function
      await supabase.rpc(
        'shuffle_missions',
        params: {'game_code_input': ref.read(playerNotifierProvider).gameCode},
      );
    } catch (e) {
      print("Error calling shuffle_missions: $e");
    }
  }

  Future<void> startGame() async {
    final startedData =
        await supabase
            .from('game_rooms')
            .update({'started': true})
            .eq('game_code', ref.read(playerNotifierProvider).gameCode)
            .select();

    print("Set started: $startedData");
  }
}
