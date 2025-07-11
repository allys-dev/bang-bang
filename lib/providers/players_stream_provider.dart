import 'package:bang_bang/main.dart';
import 'package:bang_bang/models/player.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
}
