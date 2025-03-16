import 'package:bang_bang/data/constants.dart';
import 'package:bang_bang/views/pages/lobby_page.dart';
import 'package:flutter/material.dart';

class CreateRoomPage extends StatelessWidget {
  const CreateRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text('Create Room', style: KTextStyle.heading1),
            SizedBox(height: 80),
            Text('Room Name', style: KTextStyle.heading4),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Our Trip',
                hintStyle: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(height: 40),
            Text('Number of Players', style: KTextStyle.heading4),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '4',
                hintStyle: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(height: 40),
            Text('How long are you playing?', style: KTextStyle.heading4),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '12 hours',
                hintStyle: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(height: 80),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const LobbyPage(isCreator: true);
                    },
                  ),
                );
              },
              child: Text('BEGIN', style: KTextStyle.heading1),
            ),
          ],
        ),
      ),
    );
  }
}
