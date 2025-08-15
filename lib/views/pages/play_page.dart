import 'package:bang_bang/data/constants.dart';
import 'package:bang_bang/routes/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            Text('Let\'s Play!', style: KTextStyle.heading1),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () => context.pushNamed(RouteConstants.createRoompage),
              child: Text('CREATE', style: KTextStyle.heading3),
            ),
            SizedBox(height: 20),
            Text(
              'Create a new game\nInvite your friends to play',
              style: KTextStyle.heading4,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () => context.pushNamed(RouteConstants.joinRoomPage),
              child: Text('JOIN', style: KTextStyle.heading3),
            ),
            SizedBox(height: 20),
            Text(
              'Join a friend\'s existing game\nInsert secret room code',
              style: KTextStyle.heading4,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
