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

  Future<void> transferMission(String attackerId, String targetId) async {
    print("Transferring mission from $attackerId to $targetId");
    final response = await supabase
        .from('players')
        .select()
        .eq('id', targetId);
    
    await supabase
        .from('players')
        .update({
          'target_name': response[0]['target_name'],
          'object': response[0]['object'],
          'location': response[0]['location'],
        })
        .eq('id', attackerId);

    
  }
}
