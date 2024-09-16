import 'package:reserva/models/comany_owner/flight/my_flight.dart';
import 'package:reserva/models/comany_owner/hotel/hotel_home.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

abstract class ShowServiceState {}

class ShowServiceInitial extends ShowServiceState {}

class ShowServiceLoading extends ShowServiceState {}

class ShowServiceSuccess extends ShowServiceState {
  final List<Service> services;

  ShowServiceSuccess({
    required this.services,
  });
}

class ShowServiceFailure extends ShowServiceState {
  final String message;
  ShowServiceFailure({required this.message});
}

class ShowServiceEmpty extends ShowServiceState {
  final String message;

  ShowServiceEmpty({
    required this.message,
  });
}
