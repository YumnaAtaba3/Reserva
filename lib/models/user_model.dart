class User {
  final String name;
  final String email;
  final String password;
  final String phone_number;
  final bool is_admin;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.phone_number,
    required this.is_admin,
  });

  factory User.fromjson(jsonData) {
    return User(
      name: jsonData['name'],
      email: jsonData['email'],
      password: jsonData['password'],
      phone_number: jsonData['phone_number'],
      is_admin: jsonData['is_admin'],
    );
  }
}
