class ReserveTrip {
  final String tripName;
  final String fromDate;
  final String toDate;
  final String userName;
  final String email;
  final String phoneNumber;
  final int countOfPassenger;

 ReserveTrip({
    required this.tripName,
    required this.fromDate,
    required this.toDate,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.countOfPassenger,
  });

  factory ReserveTrip.fromJson(Map<String, dynamic> json) {
    return ReserveTrip(
      tripName: json['trip_name'],
      fromDate: json['from_date'],
      toDate: json['to_date'],
      userName: json['user_name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      countOfPassenger: json['count_of_passenger'],
    );
  }
}