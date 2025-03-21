import 'package:bang_bang/data/constants.dart';
import 'package:bang_bang/views/pages/game_tree.dart';
import 'package:flutter/material.dart';

class LobbyPage extends StatelessWidget {
  const LobbyPage({super.key, required this.isCreator, required this.roomCode});

  final bool isCreator;
  final String roomCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("Room Code:", style: KTextStyle.heading3),
          Text(roomCode, style: KTextStyle.heading1),
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
          // createPlayerList(),
          Text("Player A", style: KTextStyle.heading4),
          Divider(),
          Text("Waiting for Player", style: KTextStyle.heading4),
          Divider(),
          Text("Waiting for Player", style: KTextStyle.heading4),
          Divider(),
          Text("Waiting for Player", style: KTextStyle.heading4),
          Divider(),
          SizedBox(height: 50),
          Text(
            "Everyone is an assassin\nand everyone is a target.",
            style: KTextStyle.heading4,
          ),
          SizedBox(height: 50),
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
                child: Text('BEGIN', style: KTextStyle.heading2),
              )
              : SizedBox(),
        ],
      ),
    );

  }
  
  // createPlayerList() {
  //   return ListView(
  //     children: [
  //       for (var i = 0; i < getPlayerNums(); i++) Text('Waiting for Player'),
  //     ],
  //   );
  // }
}

