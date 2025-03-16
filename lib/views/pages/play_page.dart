import 'package:bang_bang/views/pages/create_room_page.dart';
import 'package:bang_bang/views/pages/join_room_page.dart';
import 'package:flutter/material.dart';

class PlayPage extends StatelessWidget {
  const PlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Let\'s Play!', style: TextStyle(fontSize: 30)),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const CreateRoomPage();
                    },
                  ),
                );
              },
              child: Text('CREATE'),
            ),
            Text('Create a new game\nInvite your friends to play'),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const JoinRoomPage();
                    },
                  ),
                );
              },
              child: Text('JOIN'),
            ),
            Text('Join a friend\'s existing game\nInsert secret room code'),
          ],
        ),
      ),
    );
  }
}
