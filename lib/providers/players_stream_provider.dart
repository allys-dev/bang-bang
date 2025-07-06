import 'package:bang_bang/main.dart';
import 'package:bang_bang/models/player.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'players_stream_provider.g.dart';

@riverpod
class PlayersStream extends _$PlayersStream {
  @override
  Stream<List<Player>> build(gameCode) async* {
    while (true) {
      try {
        yield* supabase
            .from('players')
            .stream(primaryKey: ['id'])
            .eq('game_code', gameCode)
            .map((data) {
              print("PlayersStream: $data");
              return data.map((json) => Player.fromJson(json)).toList();
            });
        // If the stream ends naturally, break the loop
        break;
      } catch (error) {
        print("Caught error in PlayersStream: $error");
        // Wait before retrying
        await Future.delayed(const Duration(seconds: 1));
        print("Retrying PlayersStream...");
      }
    }
  }

  // Stream<List<Player>> build(gameCode) {
  //   return supabase
  //       .from('players')
  //       .stream(primaryKey: ['id'])
  //       .eq('game_code', gameCode)
  //       .map((data) {
  //         print("PlayersStream: $data");
  //         return data.map((json) => Player.fromJson(json)).toList();
  //       }).handleError((error) {
  //         if (error is RealtimeSubscribeStatus && error == RealtimeSubscribeStatus.channelError) {
  //           print("Error in PlayersStream: $error");
  //           // Optionally, you can handle reconnection logic here
  //         } else {
  //           print("Unhandled error in PlayersStream: $error");
  //         }
  //       });
  // }
}
