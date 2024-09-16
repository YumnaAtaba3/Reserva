import 'package:reserva/models/comany_owner/hotel/hotel_home.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

abstract class AddHotelPhotosState {}

class AddHotelPhotosInitial extends AddHotelPhotosState {}

class AddHotelPhotosLoading extends AddHotelPhotosState {}

class AddHotelPhotosSuccess extends AddHotelPhotosState {
  final String message;

  AddHotelPhotosSuccess({required this.message});
}

class AddHotelPhotosFailure extends AddHotelPhotosState {
  final String message;
  AddHotelPhotosFailure({required this.message});
}

class AddHotelPhotosEmpty extends AddHotelPhotosState {
  final String message;

  AddHotelPhotosEmpty({
    required this.message,
  });
}
