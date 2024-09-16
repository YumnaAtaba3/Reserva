part of 'flight_admin_cubit.dart';

@immutable
sealed class FlightAdminState {}

final class FlightAdminInitial extends FlightAdminState {}

class FlightAdminLoadingState extends FlightAdminState {}
class addFlightAdminLoadedState extends FlightAdminState {
  
}

class FlightAdminLoadedState extends FlightAdminState {
  final List<AdminFlight> flightAdmin;
   final String message;

  FlightAdminLoadedState(this.flightAdmin,this.message);
}

class FlightAdminEmpty extends FlightAdminState {
  final String message;

  FlightAdminEmpty(this.message);
}

class FlightAdminErrorState extends FlightAdminState {
  final String errorMessage;

  FlightAdminErrorState(this.errorMessage);
}