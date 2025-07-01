class Game {
  final String gameCode;
  final String roomName;
  final int players;
  final int duration;
  final String createdAt;
  final bool started;

  Game({
    required this.gameCode,
    required this.roomName,
    required this.players,
    required this.duration,
    required this.createdAt,
    required this.started,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      gameCode: json['game_code'] as String,
      roomName: json['room_name'] as String,
      players: json['players'] as int,
      duration: json['duration'] as int,
      createdAt: json['created_at'] as String,
      started: json['started'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'game_code': gameCode,
      'room_name': roomName,
      'players': players,
      'duration': duration,
      'created_at': createdAt,
      'started': started,
    };
  }

  Game copyWith({
    String? gameCode,
    String? roomName,
    int? players,
    int? duration,
    String? createdAt,
    bool? started,
  }) {
    return Game(
      gameCode: gameCode ?? this.gameCode,
      roomName: roomName ?? this.roomName,
      players: players ?? this.players,
      duration: duration ?? this.duration,
      createdAt: createdAt ?? this.createdAt,
      started: started ?? this.started,
    );
  }
}
