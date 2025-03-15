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
            Text('Join Room', style: TextStyle(fontSize: 30)),
            Text('Do you know the secret code?'),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '000000',
                hintStyle: TextStyle(
                  fontSize: 30,
                  ),
              ),
              onEditingComplete: () {
                roomCode = controller.text;
              },
            ),
            Text('Join a friend\'s existing game with a room code'),
            ElevatedButton(
              onPressed: () {
                print('join button pressed');
              },
              child: Text('JOIN'),
            ),
          ],
        ),
      ),
    );
  }
}