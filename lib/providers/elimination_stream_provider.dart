import 'package:bang_bang/main.dart';
import 'package:bang_bang/models/elimination.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'elimination_stream_provider.g.dart';

@riverpod
class EliminationStream extends _$EliminationStream {
  @override
  Stream<List<Elimination>> build(gameCode) {
    return supabase
        .from('game_rooms')
        .stream(primaryKey: ['id'])
        .eq('game_code', gameCode)
        .order('created_at', ascending: false)
        .map((data) => data.map((json) => Elimination.fromJson(json)).toList());
  }
}
