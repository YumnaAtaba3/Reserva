class RoomFeatures {
  final int id;
  final String name;
  RoomFeatures({required this.id, required this.name});
  factory RoomFeatures.fromjson(jsonData) {
    return RoomFeatures(id: jsonData['id'], name: jsonData['name']);
  }
}
