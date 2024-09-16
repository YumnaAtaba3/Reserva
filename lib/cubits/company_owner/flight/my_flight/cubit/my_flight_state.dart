import 'package:reserva/models/comany_owner/hotel/hotel_home.dart';
import 'package:reserva/models/comany_owner/flight/my_flight.dart';

abstract class MyFlightState {}

class MyFlightInitial extends MyFlightState {}

class MyFlightLoading extends MyFlightState {}

class MyFlightSuccessInfo extends MyFlightState {
  final List<FlightInfo> flightInfo;

  MyFlightSuccessInfo({
    required this.flightInfo,
  });
}

class MyFlightSuccessReview extends MyFlightState {
  final List<FlightReview> flightReview;

  MyFlightSuccessReview({
    required this.flightReview,
  });
}

class MyFlightSuccessService extends MyFlightState {
  final List<Service> service;

  MyFlightSuccessService({
    required this.service,
  });
}

class MyFlightSuccessFlightWithTime extends MyFlightState {
  final List<Flight> flights;

  MyFlightSuccessFlightWithTime({
    required this.flights,
  });
}

class MyFlightFailure extends MyFlightState {
  final String message;
  MyFlightFailure({required this.message});
}

class MyFlightGotFiltersSuccess extends MyFlightState {}

class MyFlightEmpty extends MyFlightState {
  final String message;

  MyFlightEmpty({
    required this.message,
  });
}

class MyFlightSuccess extends MyFlightState {
  final List<FlightInfo> flightInfo;
  final List<FlightReview> flightReview;
  final List<Service> service;

  final List<Flight> flights;

  MyFlightSuccess({
    required this.flightInfo,
    required this.flightReview,
    required this.service,
    required this.flights,
  });
}
