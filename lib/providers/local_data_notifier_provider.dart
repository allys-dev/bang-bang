import 'package:shared_preferences/shared_preferences.dart';
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

  Map<String, dynamic> toJson() => {
    'gameCode': gameCode,
    'isCreator': isCreator,
    'playerId': playerId,
  };

  factory LocalData.fromJson(Map<String, dynamic> json) {
    return LocalData(
      gameCode: json['gameCode'] as String,
      isCreator: json['isCreator'] as bool,
      playerId: json['playerId'] as String?,
    );
  }
}

@Riverpod(keepAlive: true)
class LocalDataNotifier extends _$LocalDataNotifier {
  SharedPreferences? _prefs;

  @override
  Future<LocalData> build() async {
    _prefs = await SharedPreferences.getInstance();
    return _loadStoredData();
  }

  LocalData _loadStoredData() {
    final storedGameCode = _prefs?.getString('gameCode') ?? '';
    final storedIsCreator = _prefs?.getBool('isCreator') ?? false;
    final storedPlayerId = _prefs?.getString('playerId');
    return LocalData(
      gameCode: storedGameCode,
      isCreator: storedIsCreator,
      playerId: storedPlayerId,
    );
  }

  Future<void> setGameCode(String gameCode) async {
    await _prefs?.setString('gameCode', gameCode);
    state = AsyncValue.data(state.value!.copyWith(gameCode: gameCode));
    print("Game code set to: $gameCode");
  }

  Future<void> setIsCreator(bool isCreator) async {
    await _prefs?.setBool('isCreator', isCreator);
    state = AsyncValue.data(state.value!.copyWith(isCreator: isCreator));
    print("Setting isCreator to $isCreator");
  }

  Future<void> setPlayerId(String? playerId) async {
    if (playerId != null) {
      await _prefs?.setString('playerId', playerId);
    }
    state = AsyncValue.data(state.value!.copyWith(playerId: playerId));
  }

  Future<void> clearData() async {
    await _prefs?.clear();
    state = const AsyncValue.data(LocalData(gameCode: '', isCreator: false));
  }
}
