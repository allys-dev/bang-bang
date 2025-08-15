import 'dart:async';

import 'package:bang_bang/data/constants.dart';
import 'package:bang_bang/main.dart';
import 'package:bang_bang/providers/game_stream_provider.dart';
import 'package:bang_bang/providers/local_data_notifier_provider.dart';
import 'package:bang_bang/routes/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
  bool roomCreated = false;

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
                try {
                  final generatedGameCode =
                      await supabase.rpc('gen_room_code') as String;

                  if (!mounted) return;

                  // Navigate IMMEDIATELY - don't wait for anything
                  if (context.mounted) {
                    final result = context.pushNamed(
                      RouteConstants.getReadyPage,
                    );

                    // Handle state updates in background
                    _updateStateInBackground(generatedGameCode);

                    // Optionally await the navigation if you need to
                    // await result;
                  }
                } catch (error) {
                  print('Error creating room: $error');
                }

                // print('Button pressed, mounted: $mounted');

                // // Generate game code before async calls
                // final generatedGameCode =
                //     await supabase.rpc('gen_room_code') as String;

                // // Navigate FIRST, then update providers
                // if (context.mounted) {
                //   context.pushNamed(RouteConstants.getReadyPage);

                //   // Update providers after navigation starts
                //   WidgetsBinding.instance.addPostFrameCallback((_) async {
                //     if (mounted) {
                //       print('Caching providers, mounted: $mounted');
                //       final localNotifier = ref.read(
                //         localDataNotifierProvider.notifier,
                //       );
                //       final gameStreamNotifier = ref.read(
                //         gameStreamProvider.notifier,
                //       );

                //       print('Setting creator, mounted: $mounted');

                //       await localNotifier.setIsCreator(true);

                //       print('Setting game code, mounted: $mounted');
                //       await localNotifier.setGameCode(generatedGameCode);

                //       print('Creating room, mounted: $mounted');
                //       await gameStreamNotifier.createGameRoom(
                //         generatedGameCode,
                //         roomNameController.text,
                //         selectedPlayerNum,
                //         durationOptions[selectedDuration]!,
                //       );

                //       print('Finished creating room, mounted: $mounted');
                //     } else {
                //       // Handle the case where the widget is no longer mounted
                //       print(
                //         'Widget is no longer mounted, cannot update providers.',
                //       );
                //     }
                //   });
                // } else {
                //   // Handle the case where the widget is no longer mounted
                //   print('Widget is no longer mounted, cannot navigate.');
                // }

                // // print('Caching providers, mounted: $mounted');

                // // // Cache providers before awaiting
                // // final localNotifier = ref.read(
                // //   localDataNotifierProvider.notifier,
                // // );
                // // final gameStreamNotifier = ref.read(
                // //   gameStreamProvider.notifier,
                // // );

                // // print('Setting creator, mounted: $mounted');

                // // await localNotifier.setIsCreator(true);

                // // print('Setting game code, mounted: $mounted');
                // // await localNotifier.setGameCode(generatedGameCode);

                // // print('Creating room, mounted: $mounted');
                // // await gameStreamNotifier.createGameRoom(
                // //   generatedGameCode,
                // //   roomNameController.text,
                // //   selectedPlayerNum,
                // //   durationOptions[selectedDuration]!,
                // // );

                // // print('About to navigate, mounted: $mounted');
                // // if (mounted) {
                // //   context.pushNamed(RouteConstants.getReadyPage);
                // // } else {
                // //   // Handle the case where the widget is no longer mounted
                // //   print('Widget is no longer mounted, cannot navigate.');
                // // }
              },
              child: Text('BEGIN', style: KTextStyle.heading1),
            ),
          ],
        ),
      ),
    );
  }

  // Separate method for background updates
  void _updateStateInBackground(String generatedGameCode) {
    // Use a timer to delay the state updates
    Timer(Duration(milliseconds: 500), () async {
      try {
        print('Caching providers, mounted: $mounted');
        final localNotifier = ref.read(localDataNotifierProvider.notifier);
        final gameStreamNotifier = ref.read(gameStreamProvider.notifier);

        print('Setting creator, mounted: $mounted');
        await localNotifier.setIsCreator(true);

        print('Setting game code, mounted: $mounted');
        await localNotifier.setGameCode(generatedGameCode);

        print('Creating room, mounted: $mounted');
        await gameStreamNotifier.createGameRoom(
          generatedGameCode,
          roomNameController.text,
          selectedPlayerNum,
          durationOptions[selectedDuration]!,
        );

        print('Finished creating room, mounted: $mounted');
      } catch (error) {
        print('Background state update error: $error');
      }
    });
  }
}
