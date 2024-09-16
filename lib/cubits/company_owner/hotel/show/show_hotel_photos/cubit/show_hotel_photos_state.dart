import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

abstract class ShowHotelPhotosState {}

class ShowHotelPhotosInitial extends ShowHotelPhotosState {}

class ShowHotelPhotosLoading extends ShowHotelPhotosState {}

class ShowHotelPhotosSuccess extends ShowHotelPhotosState {
  final List<HotelPhotos> photos;

  ShowHotelPhotosSuccess({
    required this.photos,
  });
}

class ShowHotelPhotosFailure extends ShowHotelPhotosState {
  final String message;
  ShowHotelPhotosFailure({required this.message});
}

class ShowHotelPhotosEmpty extends ShowHotelPhotosState {
  final String message;

  ShowHotelPhotosEmpty({
    required this.message,
  });
}
