import 'package:reserva/models/comany_owner/hotel/hotel_home.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

abstract class MyHotelState {}

class MyHotelInitial extends MyHotelState {}

class MyHotelLoading extends MyHotelState {}

class MyHotelSuccessInfo extends MyHotelState {
  final List<HotelInfo> hotelInfo;

  MyHotelSuccessInfo({
    required this.hotelInfo,
  });
}

class MyHotelSuccessReview extends MyHotelState {
  final List<HotelReview> hotelReview;

  MyHotelSuccessReview({
    required this.hotelReview,
  });
}

class MyHotelSuccessFacility extends MyHotelState {
  final List<Facility> facilities;

  MyHotelSuccessFacility({
    required this.facilities,
  });
}

class MyHotelSuccessHotelPhotos extends MyHotelState {
  final List<HotelPhotos> photos;

  MyHotelSuccessHotelPhotos({
    required this.photos,
  });
}

class MyHotelSuccessRoom extends MyHotelState {
  final List<Room> rooms;

  MyHotelSuccessRoom({
    required this.rooms,
  });
}

class MyHotelFailure extends MyHotelState {
  final String message;
  MyHotelFailure({required this.message});
}

class MyHotelGotFiltersSuccess extends MyHotelState {}

class MyHotelEmpty extends MyHotelState {
  final String message;

  MyHotelEmpty({
    required this.message,
  });
}

class MyHotelSuccess extends MyHotelState {
  final List<HotelInfo> hotelInfo;
  final List<HotelReview> hotelReview;
  final List<Facility> facility;
  final List<HotelPhotos> photos;
  final List<Room> rooms;

  MyHotelSuccess({
    required this.hotelInfo,
    required this.hotelReview,
    required this.facility,
    required this.photos,
    required this.rooms,
  });
}
