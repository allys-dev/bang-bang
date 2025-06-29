class Player {
  Player({
    required this.playerName,
    required this.gameCode,
    required this.targetName,
    required this.object,
    required this.location,
    this.isCreator = false,
  });

  String playerName = '';
  String gameCode = '';
  String targetName = '';
  String object = '';
  String location = '';
  bool isCreator = false;

  copyWith({
    String? playerName,
    String? gameCode,
    String? targetName,
    String? object,
    String? location,
    bool? isCreator,
  }) {
    return Player(
      playerName: playerName ?? this.playerName,
      gameCode: gameCode ?? this.gameCode,
      targetName: targetName ?? this.targetName,
      object: object ?? this.object,
      location: location ?? this.location,
      isCreator: isCreator ?? this.isCreator,
    );
  }
}
