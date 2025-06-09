import 'package:bang_bang/data/constants.dart';
import 'package:bang_bang/main.dart';
import 'package:bang_bang/views/pages/get_ready_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JoinRoomPage extends StatefulWidget {
  const JoinRoomPage({super.key});

  @override
  State<JoinRoomPage> createState() => _JoinRoomPageState();
}

class _JoinRoomPageState extends State<JoinRoomPage> {
  TextEditingController gameCodeController = TextEditingController();
  late final SharedPreferences prefs;

  @override
  void initState() {
    getSharedPrefs();
    super.initState();
  }

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
                  
                  await prefs.setString(
                    KConstants.gameCodeKey,
                    gameCodeController.text,
                  );

                  if (context.mounted) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return GetReadyPage(
                            isCreator: false,
                          );
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

  Future<void> getSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }
}

Future<bool> checkRoomExists(String gameCode) async {
  final roomMatch = await supabase.from('game_rooms').select().match({
    'game_code': gameCode,
  });

  return roomMatch.isEmpty ? false : true;
}
