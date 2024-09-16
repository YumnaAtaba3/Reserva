class SeatSelection {
  final int id;
  final String name;
  SeatSelection({required this.id, required this.name});
  factory SeatSelection.fromjson(jsonData) {
    return SeatSelection(id: jsonData['id'], name: jsonData['name']);
  }
}
