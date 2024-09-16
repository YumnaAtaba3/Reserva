import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

class FlightReservation {
  final String userName;
  final String email;
  final String phoneNumber;
  final City fromCity;
  final City toCity;
  final String departDay;
  final int adultsNum;
  final int childNum;

  FlightReservation({
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.fromCity,
    required this.toCity,
    required this.departDay,
    required this.adultsNum,
    required this.childNum,
  });

  factory FlightReservation.fromJson(Map<String, dynamic> json) {
    return FlightReservation(
      userName: json['user_name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      fromCity: City.fromJson(json['from_city']),
      toCity: City.fromJson(json['to_city']),
      departDay: json['depart_day'],
      adultsNum: json['adults_num'],
      childNum: json['child_num'],
    );
  }
}
