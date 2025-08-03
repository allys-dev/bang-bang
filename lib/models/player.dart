class Player {
  String id;
  String playerName;
  String targetName;
  String object;
  String location;
  int score;
  String gameCode;
  bool isCreator;

  Player({
    required this.id,
    required this.playerName,
    required this.targetName,
    required this.object,
    required this.location,
    this.score = 0,
    required this.gameCode,
    this.isCreator = false,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'] as String,
      playerName: json['player_name'] as String,
      targetName: json['target_name'] as String,
      object: json['object'] as String,
      location: json['location'] as String,
      score: json['score'] as int? ?? 0,
      gameCode: json['game_code'] as String,
      isCreator: json['is_creator'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'player_name': playerName,
      'target_name': targetName,
      'object': object,
      'location': location,
      'score': score,
      'game_code': gameCode,
      'is_creator': isCreator,
    };
  }

  copyWith({
    String? id,
    String? playerName,
    String? targetName,
    String? object,
    String? location,
    int? score,
    String? gameCode,
    bool? isCreator,
  }) {
    return Player(
      id: id ?? this.id,
      playerName: playerName ?? this.playerName,
      targetName: targetName ?? this.targetName,
      object: object ?? this.object,
      location: location ?? this.location,
      score: score ?? this.score,
      gameCode: gameCode ?? this.gameCode,
      isCreator: isCreator ?? this.isCreator,
    );
  }
}
