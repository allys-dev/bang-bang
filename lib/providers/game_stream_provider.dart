import 'package:bang_bang/main.dart';
import 'package:bang_bang/models/game.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_stream_provider.g.dart';

@riverpod
class GameStream extends _$GameStream {
  @override
  Stream<List<Game>> build() {
    return supabase
        .from('game_rooms')
        .stream(primaryKey: ['game_code'])
        .order('created_at', ascending: false)
        .map((data) => data.map((json) => Game.fromJson(json)).toList());
  }

  Future<void> startGame(String gameCode) async {
    await supabase
        .from('game_rooms')
        .update({'started': true})
        .eq('game_code', gameCode);
  }

  Future<void> createGameRoom(String gameCode, String roomName, int players, int duration) async {
    await supabase.from('game_rooms').insert({
      'game_code': gameCode,
      'room_name': roomName,
      'players': players,
      'duration': duration,
    });
  }
}
