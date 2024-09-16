import 'package:reserva/models/comany_owner/hotel/hotel_home.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

abstract class ShowHotelInfoState {}

class ShowHotelInfoInitial extends ShowHotelInfoState {}

class ShowHotelInfoLoading extends ShowHotelInfoState {}

class ShowHotelInfoSuccess extends ShowHotelInfoState {
  final List<HotelInfo> hotelInfo;

  ShowHotelInfoSuccess({
    required this.hotelInfo,
  });
}

class ShowHotelInfoFailure extends ShowHotelInfoState {
  final String message;
  ShowHotelInfoFailure({required this.message});
}

class ShowHotelInfoEmpty extends ShowHotelInfoState {
  final String message;

  ShowHotelInfoEmpty({
    required this.message,
  });
}
