import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_data_notifier_provider.g.dart';

class LocalData {
  final String gameCode;
  final bool isCreator;
  final String? playerId;

  const LocalData({
    required this.gameCode,
    required this.isCreator,
    this.playerId,
  });

  LocalData copyWith({String? gameCode, bool? isCreator, String? playerId}) {
    return LocalData(
      gameCode: gameCode ?? this.gameCode,
      isCreator: isCreator ?? this.isCreator,
      playerId: playerId ?? this.playerId,
    );
  }
}

@riverpod
class LocalDataNotifier extends _$LocalDataNotifier {
  // initial value
  @override
  LocalData build() {
    return LocalData(gameCode: '', isCreator: false);
  }

  void setGameCode(String gameCode) {
    state = state.copyWith(gameCode: gameCode);
  }

  void setIsCreator(bool isCreator) {
    print("Setting isCreator to $isCreator");
    state = state.copyWith(isCreator: isCreator);
  }

  void setPlayerId(String? playerId) {
    state = state.copyWith(playerId: playerId);
  }
}
