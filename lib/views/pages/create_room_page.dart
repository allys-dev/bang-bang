import 'package:flutter/material.dart';

class CreateRoomPage extends StatelessWidget {
  const CreateRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Create Room', style: TextStyle(fontSize: 30)),
            Text('Room Name'),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Our Trip',
                hintStyle: TextStyle(
                  fontSize: 15,
                  ),
              ),
            ),
            Text('Number of Players'),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '4',
                hintStyle: TextStyle(
                  fontSize: 15,
                  ),
              ),
            ),
            Text('How long are you playing'),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '12 hours',
                hintStyle: TextStyle(
                  fontSize: 15,
                  ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                print('begin button pressed');
              },
              child: Text('BEGIN'),
            ),
          ],
        ),
      ),
    );
  }
}