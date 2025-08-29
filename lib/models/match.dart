class Match {
  final String id;
  final String parkId;
  final String parkName;
  final String parkAddress;
  final double parkLatitude;
  final double parkLongitude;
  final DateTime dateTime;
  final int totalPlayers;
  final int signedUpPlayers;
  final String createdBy;
  final List<String> signedUpUserIds;
  double? distanceFromUser;

  Match({
    required this.id,
    required this.parkId,
    required this.parkName,
    required this.parkAddress,
    required this.parkLatitude,
    required this.parkLongitude,
    required this.dateTime,
    required this.totalPlayers,
    required this.signedUpPlayers,
    required this.createdBy,
    required this.signedUpUserIds,
    this.distanceFromUser,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['id'] as String,
      parkId: json['parkId'] as String,
      parkName: json['parkName'] as String,
      parkAddress: json['parkAddress'] as String,
      parkLatitude: json['parkLatitude'] as double,
      parkLongitude: json['parkLongitude'] as double,
      dateTime: DateTime.parse(json['dateTime'] as String),
      totalPlayers: json['totalPlayers'] as int,
      signedUpPlayers: json['signedUpPlayers'] as int,
      createdBy: json['createdBy'] as String,
      signedUpUserIds: List<String>.from(json['signedUpUserIds'] as List),
      distanceFromUser: json['distanceFromUser'] as double?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parkId': parkId,
      'parkName': parkName,
      'parkAddress': parkAddress,
      'parkLatitude': parkLatitude,
      'parkLongitude': parkLongitude,
      'dateTime': dateTime.toIso8601String(),
      'totalPlayers': totalPlayers,
      'signedUpPlayers': signedUpPlayers,
      'createdBy': createdBy,
      'signedUpUserIds': signedUpUserIds,
      'distanceFromUser': distanceFromUser,
    };
  }

  Match copyWith({
    String? id,
    String? parkId,
    String? parkName,
    String? parkAddress,
    double? parkLatitude,
    double? parkLongitude,
    DateTime? dateTime,
    int? totalPlayers,
    int? signedUpPlayers,
    String? createdBy,
    List<String>? signedUpUserIds,
    double? distanceFromUser,
  }) {
    return Match(
      id: id ?? this.id,
      parkId: parkId ?? this.parkId,
      parkName: parkName ?? this.parkName,
      parkAddress: parkAddress ?? this.parkAddress,
      parkLatitude: parkLatitude ?? this.parkLatitude,
      parkLongitude: parkLongitude ?? this.parkLongitude,
      dateTime: dateTime ?? this.dateTime,
      totalPlayers: totalPlayers ?? this.totalPlayers,
      signedUpPlayers: signedUpPlayers ?? this.signedUpPlayers,
      createdBy: createdBy ?? this.createdBy,
      signedUpUserIds: signedUpUserIds ?? this.signedUpUserIds,
      distanceFromUser: distanceFromUser ?? this.distanceFromUser,
    );
  }

  int get playersNeeded => totalPlayers - signedUpPlayers;
  bool get isFull => signedUpPlayers >= totalPlayers;
}
