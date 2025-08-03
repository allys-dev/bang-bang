import 'package:bang_bang/data/constants.dart';
import 'package:bang_bang/main.dart';
import 'package:bang_bang/providers/local_data_notifier_provider.dart';
import 'package:bang_bang/views/pages/lobby_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetReadyPage extends ConsumerStatefulWidget {
  const GetReadyPage({super.key});

  @override
  ConsumerState<GetReadyPage> createState() => _GetReadyPageState();
}

class _GetReadyPageState extends ConsumerState<GetReadyPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController objectController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("GetReadyPage build called");
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text('Get Ready!', style: KTextStyle.heading1),
            SizedBox(height: 80),
            Text('My Name', style: KTextStyle.heading4),
            Padding(
              padding: const EdgeInsets.fromLTRB(80, 0, 80, 0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'John S',
                  hintStyle: TextStyle(fontSize: 15),
                ),
              ),
            ),
            SizedBox(height: 40),
            Text('Add an Object', style: KTextStyle.heading4),
            Padding(
              padding: const EdgeInsets.fromLTRB(80, 0, 80, 0),
              child: TextField(
                controller: objectController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Bottle',
                  hintStyle: TextStyle(fontSize: 15),
                ),
              ),
            ),
            SizedBox(height: 40),
            Text('Add a Location', style: KTextStyle.heading4),
            Padding(
              padding: const EdgeInsets.fromLTRB(80, 0, 80, 0),
              child: TextField(
                controller: locationController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Kitchen',
                  hintStyle: TextStyle(fontSize: 15),
                ),
              ),
            ),
            SizedBox(height: 40),
            Text(
              'The object and location will be randomised for players in the room',
            ),
            SizedBox(height: 80),
            ElevatedButton(
              onPressed: () {
                createPlayer();

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return LobbyPage();
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

  void createPlayer() async {
    print("before inserting player");
    await supabase.from('players').insert({
      'player_name': nameController.text,
      'target_name': nameController.text,
      'object': objectController.text,
      'location': locationController.text,
      'score': 0,
      'game_code': ref.read(localDataNotifierProvider).gameCode,
      'is_creator': ref.read(localDataNotifierProvider).isCreator,
    });

    //Print name
    print("*** I am player: ${nameController.text}***");

    // Get unique player ID
    final playerData =
        await supabase
            .from('players')
            .select()
            .eq('game_code', ref.read(localDataNotifierProvider).gameCode)
            .eq('player_name', nameController.text)
            .single();

    // Set local player ID
    ref.read(localDataNotifierProvider.notifier).setPlayerId(playerData['id']);
  }
}
