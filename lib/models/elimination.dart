class Elimination {
  final String id;
  final String createdAt;
  final String attackerId;
  final String targetId;
  final bool? targetConfirmation;
  final bool attackerSeen;
  final String gameCode;

  Elimination({
    required this.id,
    required this.createdAt,
    required this.attackerId,
    required this.targetId,
    required this.targetConfirmation,
    required this.attackerSeen,
    required this.gameCode,
  });

  factory Elimination.fromJson(Map<String, dynamic> json) {
    return Elimination(
      id: json['id'] as String,
      createdAt: json['created_at'] as String,
      attackerId: json['attacker_id'] as String,
      targetId: json['target_id'] as String,
      targetConfirmation: json['target_confirmation'] as bool?,
      attackerSeen: json['attacker_seen'] as bool,
      gameCode: json['game_code'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt,
      'attacker_id': attackerId,
      'target_id': targetId,
      'target_confirmation': targetConfirmation,
      'attacker_seen': attackerSeen,
      'game_code': gameCode,
    };
  }

  Elimination copyWith({
    String? id,
    String? createdAt,
    String? attackerId,
    String? targetId,
    bool? targetConfirmation,
    bool? attackerSeen,
    String? gameCode,
  }) {
    return Elimination(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      attackerId: attackerId ?? this.attackerId,
      targetId: targetId ?? this.targetId,
      targetConfirmation: targetConfirmation ?? this.targetConfirmation,
      attackerSeen: attackerSeen ?? this.attackerSeen,
      gameCode: gameCode ?? this.gameCode,
    );
  }
}
