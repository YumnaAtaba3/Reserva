import 'package:reserva/models/comany_owner/flight/flight_reserv.dart';

abstract class FlightReservationsState {}

class FlightReservationsInitial extends FlightReservationsState {}

class FlightReservationsLoading extends FlightReservationsState {}

class FlightReservationsSuccess extends FlightReservationsState {
  final List<FlightReservation> reserv;

  FlightReservationsSuccess({
    required this.reserv,
  });
}

class FlightReservationsFailure extends FlightReservationsState {
  final String message;
  FlightReservationsFailure({required this.message});
}

class FlightReservationsEmpty extends FlightReservationsState {
  final String message;

  FlightReservationsEmpty({
    required this.message,
  });
}
