import 'package:reserva/models/comany_owner/flight/my_flight.dart';
import 'package:reserva/models/comany_owner/hotel/hotel_home.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

abstract class ShowFlightState {}

class ShowFlightInitial extends ShowFlightState {}

class ShowFlightLoading extends ShowFlightState {}

class ShowFlightSuccess extends ShowFlightState {
  final List<Flight> flights;

  ShowFlightSuccess({
    required this.flights,
  });
}

class ShowFlightFailure extends ShowFlightState {
  final String message;
  ShowFlightFailure({required this.message});
}

class ShowFlightEmpty extends ShowFlightState {
  final String message;

  ShowFlightEmpty({
    required this.message,
  });
}
