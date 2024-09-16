class RoomType {
  final int id;
  final String name;
  RoomType({required this.id, required this.name});
  factory RoomType.fromjson(jsonData) {
    return RoomType(id: jsonData['id'], name: jsonData['name']);
  }
}
