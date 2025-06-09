// import 'dart:convert';
import 'package:bang_bang/data/constants.dart';
import 'package:bang_bang/data/globals.dart' as globals;
import 'package:bang_bang/main.dart';
import 'package:bang_bang/views/pages/game_tree.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LobbyPage extends StatefulWidget {
  const LobbyPage({super.key, required this.isCreator});

  final bool isCreator;
  // final String roomCode;

  @override
  State<LobbyPage> createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {
  late final SupabaseStreamBuilder playersStream;
  late final int? totalPlayers;
  late final SharedPreferences prefs;
  
  int joinedPlayers = 0;

  @override
  void initState(){
    super.initState();
    getSharedPrefs();
    playersStream = supabase
        .from('players')
        .stream(primaryKey: ['id'])
        // .eq('game_code', widget.roomCode);
        .eq('game_code', globals.gameCode);
    getTotalPlayers();
  }

  Future<void> getSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("Room Code:", style: KTextStyle.heading3),
          Text(widget.roomCode, style: KTextStyle.heading1),
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
        .eq('game_code', widget.roomCode);
    totalPlayers = data[0]["players"];
  }
  
  Future<void> shuffleMissions() async {
    await supabase.rpc('shuffle_missions');
  }
  
  Future<void> startGame() async {
    await supabase.from('game_rooms').update({'started':'true'}).eq('game_code', widget.roomCode);
  }
}
