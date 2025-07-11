import 'package:bang_bang/models/player.dart';
import 'package:bang_bang/providers/local_data_notifier_provider.dart';
import 'package:bang_bang/providers/players_stream_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:collection/collection.dart';

part 'player_notifier_provider.g.dart';

@riverpod
class PlayerNotifier extends _$PlayerNotifier {
  @override
  Player build(playerId) {
    final gameCode = ref.read(localDataNotifierProvider).gameCode;

    final playerListAsync = ref.watch(playersStreamProvider(gameCode));

    return playerListAsync.when(
      data:
          (players) =>
              players.firstWhereOrNull((p) => p.id == playerId) ??
              Player(
                id: playerId ?? '',
                playerName: "Unknown",
                targetName: "Unknown",
                location: "Unknown",
                object: "Unknown",
                gameCode: gameCode,
                isCreator: false,
              ),
      loading:
          () => Player(
            id: playerId ?? '',
            playerName: "Loading...",
            targetName: "Loading...",
            location: "Loading...",
            object: "Loading...",
            gameCode: gameCode,
            isCreator: false,
          ),
      error: (error, stack) {
        print("Error fetching player: $error");
        print(stack);
        return Player(
          id: playerId ?? '',
          playerName: "Error",
          targetName: "Error",
          location: "Error",
          object: "Error",
          gameCode: gameCode,
          isCreator: false,
        );
      },
    );
  }
}
