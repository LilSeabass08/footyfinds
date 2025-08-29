class Park {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String? imageUrl;
  double? distanceFromUser;

  Park({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.imageUrl,
    this.distanceFromUser,
  });

  factory Park.fromJson(Map<String, dynamic> json) {
    return Park(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      imageUrl: json['imageUrl'] as String?,
      distanceFromUser: json['distanceFromUser'] as double?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'imageUrl': imageUrl,
      'distanceFromUser': distanceFromUser,
    };
  }

  Park copyWith({
    String? id,
    String? name,
    String? address,
    double? latitude,
    double? longitude,
    String? imageUrl,
    double? distanceFromUser,
  }) {
    return Park(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      imageUrl: imageUrl ?? this.imageUrl,
      distanceFromUser: distanceFromUser ?? this.distanceFromUser,
    );
  }
}
