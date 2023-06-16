class PopulateMapResponse {
  final String id;
  final double latitude;
  final double longitude;
  final String userId;

  PopulateMapResponse({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.userId,
  });

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'userId': userId,
    };
  }

  factory PopulateMapResponse.fromJSON(Map<String, dynamic> json) {
    return PopulateMapResponse(
      id: json['id'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      userId: json['user_id'] as String,
    );
  }

  @override
  String toString() {
    return 'PopulateMapResponse{id: $id, latitude: $latitude, longitude: $longitude, userId: $userId}';
  }
}
