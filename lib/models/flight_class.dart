class FlightClass {
  final int id;
  final String name;
  FlightClass({required this.id, required this.name});
  factory FlightClass.fromjson(jsonData) {
    return FlightClass(id: jsonData['id'], name: jsonData['name']);
  }
}
