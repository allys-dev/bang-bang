class Elimination {
  final int id;
  final String createdAt;
  final String requestorId;
  final String responderId;
  final bool confirmation;
  final bool requestor_seen;
  final String gameCode;

  Elimination({
    required this.id,
    required this.createdAt,
    required this.requestorId,
    required this.responderId,
    required this.confirmation,
    required this.requestor_seen,
    required this.gameCode,
  });

  factory Elimination.fromJson(Map<String, dynamic> json) {
    return Elimination(
      id: json['id'] as int,
      createdAt: json['created_at'] as String,
      requestorId: json['requestor_id'] as String,
      responderId: json['responder_id'] as String,
      confirmation: json['confirmation'] as bool,
      requestor_seen: json['requestor_seen'] as bool,
      gameCode: json['game_code'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt,
      'requestor_id': requestorId,
      'responder_id': responderId,
      'confirmation': confirmation,
      'requestor_seen': requestor_seen,
      'game_code': gameCode,
    };
  }

  Elimination copyWith({
    int? id,
    String? createdAt,
    String? requestorId,
    String? responderId,
    bool? confirmation,
    bool? requestor_seen,
    String? gameCode,
  }) {
    return Elimination(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      requestorId: requestorId ?? this.requestorId,
      responderId: responderId ?? this.responderId,
      confirmation: confirmation ?? this.confirmation,
      requestor_seen: requestor_seen ?? this.confirmation,
      gameCode: gameCode ?? this.gameCode,
    );
  }
}
