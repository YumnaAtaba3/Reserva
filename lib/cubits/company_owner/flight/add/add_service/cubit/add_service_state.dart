import 'package:reserva/models/comany_owner/hotel/hotel_home.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

abstract class AddServiceState {}

class AddServiceInitial extends AddServiceState {}

class AddServiceLoading extends AddServiceState {}

class AddServiceSuccess extends AddServiceState {
  final String message;

  AddServiceSuccess({required this.message});
}

class AddServiceFailure extends AddServiceState {
  final String message;
  AddServiceFailure({required this.message});
}

class AddServiceEmpty extends AddServiceState {
  final String message;

  AddServiceEmpty({
    required this.message,
  });
}
