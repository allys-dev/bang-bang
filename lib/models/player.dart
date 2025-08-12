class Player {
  String id;
  String playerName;
  String targetName;
  String object;
  String location;
  int score;
  String gameCode;
  bool isCreator;
  bool eliminated;
  bool waiting;

  Player({
    required this.id,
    required this.playerName,
    required this.targetName,
    required this.object,
    required this.location,
    this.score = 0,
    required this.gameCode,
    this.isCreator = false,
    this.eliminated = false,
    this.waiting = false,
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
      eliminated: json['eliminated'] as bool? ?? false,
      waiting: json['waiting'] as bool? ?? false,
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
      'eliminated': eliminated,
      'waiting': waiting,
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
    bool? eliminated,
    bool? waiting,
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
      eliminated: eliminated ?? this.eliminated,
      waiting: waiting ?? this.waiting,
    );
  }
}
