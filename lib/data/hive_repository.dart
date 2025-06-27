import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hive_repository.g.dart';

class HiveRepository {
  final box = Hive.box("gameData");

  // gameCode
  void setGameCode(gameCode) {
    box.put("gameCode", gameCode);
    print("gameCode saved: ${box.get("gameCode")}");
  }

  String getGameCode() {
    return box.get("gameCode", defaultValue: "");
  }

  // playerName
  void setPlayerName(playerName) {
    box.put("playerName", playerName);
    print("playerName saved: ${box.get("playerName")}");
  }

  String getPlayerName() {
    return box.get("playerName", defaultValue: "");
  }

  // targetName
  void setTargetName(targetName) {
    box.put("targetName", targetName);
    print("targetName saved: ${box.get("targetName")}");
  }

  String getTargetName() {
    return box.get("targetName", defaultValue: "");
  }

  // object
  void setObject(object) {
    box.put("object", object);
    print("object saved: ${box.get("object")}");
  }

  String getObject() {
    return box.get("object", defaultValue: "");
  }

  // location
  void setLocation(location) {
    box.put("location", location);
    print("location saved: ${box.get("location")}");
  }

  String getLocation() {
    return box.get("location", defaultValue: "");
  }
}

@Riverpod(keepAlive: true)
HiveRepository hiveRepository(HiveRepositoryRef ref) {
  return HiveRepository();
}
