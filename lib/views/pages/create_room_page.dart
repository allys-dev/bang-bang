import 'package:bang_bang/data/constants.dart';
import 'package:bang_bang/main.dart';
import 'package:bang_bang/providers/local_data_notifier_provider.dart';
import 'package:bang_bang/views/pages/get_ready_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateRoomPage extends ConsumerStatefulWidget {
  const CreateRoomPage({super.key});

  @override
  ConsumerState<CreateRoomPage> createState() => _CreateRoomPageState();
}

class _CreateRoomPageState extends ConsumerState<CreateRoomPage> {
  final playerNumOptions = List<int>.generate(27, (i) => i + 4);
  final durationOptions = {
    '12 hours': 12,
    '24 hours': 24,
    '48 hours': 48,
    '3 days': 72,
    '4 days': 96,
    '5 days': 120,
    '6 days': 144,
    '1 week': 168,
    '2 week': 336,
    '3 week': 504,
    '1 month': 2190,
  };
  String selectedDuration = '12 hours';
  int selectedPlayerNum = 4;
  TextEditingController roomNameController = TextEditingController();
  String gameCode = '00000';

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
            Padding(
              padding: const EdgeInsets.fromLTRB(80, 0, 80, 0),
              child: TextField(
                controller: roomNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Our Trip',
                  hintStyle: TextStyle(fontSize: 15),
                ),
              ),
            ),
            SizedBox(height: 40),
            Text('Number of Players', style: KTextStyle.heading4),
            Padding(
              padding: const EdgeInsets.fromLTRB(80, 0, 80, 0),
              child: DropdownButtonFormField(
                decoration: InputDecoration(border: OutlineInputBorder()),
                value: selectedPlayerNum,
                onChanged: (playerNum) {
                  setState(() {
                    selectedPlayerNum = playerNum!;
                  });
                },
                items:
                    playerNumOptions.map<DropdownMenuItem<int>>((
                      int playerNum,
                    ) {
                      return DropdownMenuItem<int>(
                        value: playerNum,
                        child: Text(playerNum.toString()),
                      );
                    }).toList(),
              ),
            ),
            SizedBox(height: 40),
            Text('How long are you playing?', style: KTextStyle.heading4),
            Padding(
              padding: const EdgeInsets.fromLTRB(80, 0, 80, 0),
              child: DropdownButtonFormField(
                decoration: InputDecoration(border: OutlineInputBorder()),
                value: selectedDuration,
                onChanged: (duration) {
                  setState(() {
                    selectedDuration = duration!;
                  });
                },
                items:
                    durationOptions.keys.map<DropdownMenuItem<String>>((
                      String duration,
                    ) {
                      return DropdownMenuItem<String>(
                        value: duration,
                        child: Text(duration),
                      );
                    }).toList(),
              ),
            ),
            SizedBox(height: 80),
            ElevatedButton(
              onPressed: () async {
                ref.read(localDataNotifierProvider.notifier).setIsCreator(true);

                await createGameRoom();

                if (context.mounted) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return GetReadyPage();
                      },
                    ),
                  );
                }
              },
              child: Text('BEGIN', style: KTextStyle.heading1),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> createGameRoom() async {
    gameCode = await supabase.rpc('gen_room_code') as String;

    ref.read(localDataNotifierProvider.notifier).setGameCode(gameCode);
    print("gameCode: $gameCode");
    print(
      "gameCode from provider: ${ref.read(localDataNotifierProvider).gameCode}",
    );

    await supabase.from('game_rooms').insert({
      'game_code': gameCode,
      'room_name': roomNameController.text,
      'players': selectedPlayerNum,
      'duration': durationOptions[selectedDuration],
    });
  }
}
