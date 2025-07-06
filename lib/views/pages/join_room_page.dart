import 'package:bang_bang/data/constants.dart';
import 'package:bang_bang/main.dart';
import 'package:bang_bang/providers/local_data_notifier_provider.dart';
import 'package:bang_bang/views/pages/get_ready_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JoinRoomPage extends ConsumerStatefulWidget {
  const JoinRoomPage({super.key});

  @override
  ConsumerState<JoinRoomPage> createState() => _JoinRoomPageState();
}

class _JoinRoomPageState extends ConsumerState<JoinRoomPage> {
  TextEditingController gameCodeController = TextEditingController();

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
              controller: gameCodeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '000000',
                hintStyle: KTextStyle.heading1,
              ),
              onSubmitted: (value) {},
            ),
            SizedBox(height: 50),
            Text(
              'Join a friend\'s existing\ngame with a room code',
              style: KTextStyle.heading4,
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                if (await checkRoomExists(gameCodeController.text)) {
                  ref
                      .read(localDataNotifierProvider.notifier)
                      .setGameCode(gameCodeController.text);

                  if (context.mounted) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return GetReadyPage();
                        },
                      ),
                    );
                  }
                } else {
                  if (context.mounted) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(
                            'Room Code doesn\'t match an existing room. Check the code and try again. ',
                          ),
                        );
                      },
                    );
                  }
                }
              },
              child: Text('JOIN', style: KTextStyle.heading2),
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool> checkRoomExists(String gameCode) async {
  final result = await supabase.from('game_rooms').select().match({
    'game_code': gameCode,
  });

  final List<Map<String, dynamic>> roomMatch = List<Map<String, dynamic>>.from(
    result,
  );

  return roomMatch.isNotEmpty;
}
