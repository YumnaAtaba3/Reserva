import 'package:reserva/models/comany_owner/hotel/hotel_home.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

abstract class AddFacilityState {}

class AddFacilityInitial extends AddFacilityState {}

class AddFacilityLoading extends AddFacilityState {}

class AddFacilitySuccess extends AddFacilityState {
  final String message;

  AddFacilitySuccess({required this.message});
}

class AddFacilityFailure extends AddFacilityState {
  final String message;
  AddFacilityFailure({required this.message});
}

class AddFacilityEmpty extends AddFacilityState {
  final String message;

  AddFacilityEmpty({
    required this.message,
  });
}
