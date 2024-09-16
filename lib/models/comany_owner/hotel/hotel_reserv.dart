import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

class HotelReservation {
  final String userName;
  // final String email;
  final String phoneNumber;
  final RoomType roomType;
  final String fromDay;
  final String toDay;

  HotelReservation({
    required this.userName,
    //required this.email,
    required this.phoneNumber,
    required this.roomType,
    required this.fromDay,
    required this.toDay,
  });

  factory HotelReservation.fromJson(Map<String, dynamic> json) {
    return HotelReservation(
      userName: json['user_name'],
      // email: json['email'],
      phoneNumber: json['phone_number'],
      roomType: RoomType.fromJson(json['room_type']),
      fromDay: json['from_day'],
      toDay: json['to_day'],
    );
  }
}
