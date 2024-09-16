import 'package:reserva/models/comany_owner/flight/flight_reserv.dart';
import 'package:reserva/models/comany_owner/hotel/hotel_reserv.dart';

abstract class HotelReservationsState {}

class HotelReservationsInitial extends HotelReservationsState {}

class HotelReservationsLoading extends HotelReservationsState {}

class HotelReservationsSuccess extends HotelReservationsState {
  final List<HotelReservation> reserv;

  HotelReservationsSuccess({
    required this.reserv,
  });
}

class HotelReservationsFailure extends HotelReservationsState {
  final String message;
  HotelReservationsFailure({required this.message});
}

class HotelReservationsEmpty extends HotelReservationsState {
  final String message;

  HotelReservationsEmpty({
    required this.message,
  });
}
