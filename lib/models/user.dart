class User {
  final String id;
  final String email;
  final String username;
  final String name;
  final double? latitude;
  final double? longitude;
  final bool isEmailVerified;
  final DateTime createdAt;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.name,
    this.latitude,
    this.longitude,
    required this.isEmailVerified,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      name: json['name'] as String,
      latitude: json['latitude'] as double?,
      longitude: json['longitude'] as double?,
      isEmailVerified: json['isEmailVerified'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'isEmailVerified': isEmailVerified,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  User copyWith({
    String? id,
    String? email,
    String? username,
    String? name,
    double? latitude,
    double? longitude,
    bool? isEmailVerified,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
