import 'package:bang_bang/models/player.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'player_provider.g.dart';

@riverpod
class PlayerNotifier extends _$PlayerNotifier {
  // initial value
  @override
  Player build() {
    return Player(
      playerName: '',
      gameCode: '',
      targetName: '',
      object: '',
      location: '',
      isCreator: false,
    );
  }

  //methods to update player data
  void setPlayerName(String playerName) {
    state = state.copyWith(playerName: playerName);
  }

  void setGameCode(String gameCode) {
    state = state.copyWith(gameCode: gameCode);
  }

  void setTargetName(String targetName) {
    state = state.copyWith(targetName: targetName);
  }

  void setObject(String object) {
    state = state.copyWith(object: object);
  }

  void setLocation(String location) {
    state = state.copyWith(location: location);
  }

  void setIsCreator(bool isCreator) {
    print("Setting isCreator to $isCreator");
    state = state.copyWith(isCreator: isCreator);
  }
}
