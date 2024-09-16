import 'package:reserva/models/comany_owner/hotel/hotel_home.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

abstract class ShowFacilityState {}

class ShowFacilityInitial extends ShowFacilityState {}

class ShowFacilityLoading extends ShowFacilityState {}

class ShowFacilitySuccess extends ShowFacilityState {
  final List<Facility> facilities;

  ShowFacilitySuccess({
    required this.facilities,
  });
}

class ShowFacilityFailure extends ShowFacilityState {
  final String message;
  ShowFacilityFailure({required this.message});
}

class ShowFacilityEmpty extends ShowFacilityState {
  final String message;

  ShowFacilityEmpty({
    required this.message,
  });
}
