import 'package:bang_bang/views/pages/game_tree.dart';
import 'package:bang_bang/views/pages/mission_page.dart';
import 'package:flutter/material.dart';

class LobbyPage extends StatelessWidget {
  const LobbyPage({super.key, required this.isCreator});

  final bool isCreator;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("Room Code:"),
          Text("00000"),
          isCreator
              ? Text("Begin game once all players have joined")
              : Text("Waiting for room creator to begin game"),
          Text("Player A"),
          Divider(),
          Text("Waiting for Player"),
          Divider(),
          Text("Waiting for Player"),
          Divider(),
          Text("Waiting for Player"),
          Divider(),
          Text("Everyone is an assassin and everyone is a target."),
          isCreator
              ? ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const GameTree();
                        },
                      ),
                    );
                  },
                  child: Text('BEGIN'),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
