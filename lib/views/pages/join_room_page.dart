import 'package:bang_bang/data/constants.dart';
import 'package:bang_bang/views/pages/lobby_page.dart';
import 'package:flutter/material.dart';

class JoinRoomPage extends StatefulWidget {
  const JoinRoomPage({super.key});

  @override
  State<JoinRoomPage> createState() => _JoinRoomPageState();
}

class _JoinRoomPageState extends State<JoinRoomPage> {
  TextEditingController controller = TextEditingController();

  String roomCode = "00000";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Join Room', style: KTextStyle.heading1),
            SizedBox(height: 50),
            Text('Do you know the secret code?', style: KTextStyle.heading4),
            SizedBox(height: 50),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '000000',
                hintStyle: KTextStyle.heading1,
              ),
              onEditingComplete: () {
                roomCode = controller.text;
              },
            ),
            SizedBox(height: 50),
            Text(
              'Join a friend\'s existing\ngame with a room code',
              style: KTextStyle.heading4,
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const LobbyPage(isCreator: false);
                    },
                  ),
                );
              },
              child: Text('JOIN', style: KTextStyle.heading2),
            ),
          ],
        ),
      ),
    );
  }
}
