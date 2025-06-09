import 'package:bang_bang/data/constants.dart';
import 'package:bang_bang/main.dart';
import 'package:bang_bang/views/pages/lobby_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetReadyPage extends StatefulWidget {
  const GetReadyPage({
    super.key,
    required this.isCreator,
  });

  final bool isCreator;

  @override
  State<GetReadyPage> createState() => _GetReadyPageState();
}

class _GetReadyPageState extends State<GetReadyPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController objectController = TextEditingController();
  TextEditingController locationController = TextEditingController();
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
                      return LobbyPage(
                        isCreator: widget.isCreator,
                      );
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
    await supabase.from('players').insert({
      'player_name': nameController.text,
      'object': objectController.text,
      'location': locationController.text,
      'game_code': prefs.getString(KConstants.gameCodeKey),
    });

    prefs.setString(KConstants.playerNameKey, nameController.text);
    prefs.setString(KConstants.objectKey, objectController.text);
    prefs.setString(KConstants.locationKey, locationController.text);
  }
  
  Future<void> getSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }
}
