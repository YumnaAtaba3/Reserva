import 'package:reserva/models/comany_owner/flight/my_flight.dart';
import 'package:reserva/models/comany_owner/hotel/hotel_home.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

abstract class ShowFlightInfoState {}

class ShowFlightInfoInitial extends ShowFlightInfoState {}

class ShowFlightInfoLoading extends ShowFlightInfoState {}

class ShowFlightInfoSuccess extends ShowFlightInfoState {
  final List<FlightInfo> flightInfo;

  ShowFlightInfoSuccess({
    required this.flightInfo,
  });
}

class ShowFlightInfoFailure extends ShowFlightInfoState {
  final String message;
  ShowFlightInfoFailure({required this.message});
}

class ShowFlightInfoEmpty extends ShowFlightInfoState {
  final String message;

  ShowFlightInfoEmpty({
    required this.message,
  });
}
