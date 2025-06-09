import 'package:bang_bang/data/constants.dart';
import 'package:notified_preferences/notified_preferences.dart';

class GameValues with NotifiedPreferences {
  late final PreferenceNotifier<String> gameCode =
    createSetting(key: KConstants.gameCodeKey, initialValue: '');

  late final PreferenceNotifier<String> playerName =
    createSetting(key: KConstants.playerNameKey, initialValue: '');

  late final PreferenceNotifier<String> object =
    createSetting(key: KConstants.objectKey, initialValue: '');
    
  late final PreferenceNotifier<String> location =
    createSetting(key: KConstants.locationKey, initialValue: '');
    
  late final PreferenceNotifier<String> target =
    createSetting(key: KConstants.targetKey, initialValue: '');
    
  late final PreferenceNotifier<String> gameStarted =
    createSetting(key: KConstants.gameCodeKey, initialValue: '');

}