class CityModel {
  final int id;
  final String name;
  CityModel({required this.id, required this.name});
  factory CityModel.fromJson(jsonData) {
    return CityModel(id: jsonData['id'], name: jsonData['name']);
  }
}
