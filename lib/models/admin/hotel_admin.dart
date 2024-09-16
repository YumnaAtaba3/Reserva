class HotelAdmin {
  final int id;
  final String name;
  final String email;
  final String companyName;

  HotelAdmin({
    required this.id,
    required this.name,
    required this.email,
    required this.companyName,
  });

  factory HotelAdmin.fromJson(Map<String, dynamic> json) {
    return HotelAdmin(
      id:json['id'],
      name: json['name'],
      email: json['email'],
      companyName: json['company_name'],
    );
  }
}
