import 'package:bang_bang/main.dart';
import 'package:bang_bang/models/elimination.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'elimination_stream_provider.g.dart';

@riverpod
class EliminationStream extends _$EliminationStream {
  @override
  Stream<List<Elimination>> build(gameCode) {
    return supabase
        .from('eliminations')
        .stream(primaryKey: ['id'])
        .eq('game_code', gameCode)
        .order('created_at', ascending: false)
        .map((data) => data.map((json) => Elimination.fromJson(json)).toList());
  }

  Future<void> setAttackerSeen(String id) async {
    await supabase
        .from('eliminations')
        .update({'attacker_seen': true})
        .eq('id', id);
  }

    Future<void> setTargetConfirmation(String id, bool confirmation) async {
    await supabase
        .from('eliminations')
        .update({'target_confirmation': confirmation})
        .eq('id', id);
  }
  
}
