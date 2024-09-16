part of 'hotel_admin_cubit.dart';

@immutable
sealed class HotelAdminState {}

final class HotelAdminInitial extends HotelAdminState {}
class HotelAdminLoadingState extends HotelAdminState {}
class AddHotelAdminLoadedState extends HotelAdminState {}

class HotelAdminLoadedState extends HotelAdminState {
  final List<HotelAdmin> hotelAdmin;
    final String message;

  HotelAdminLoadedState(this.hotelAdmin,this.message);
}

class HotelAdminEmpty extends HotelAdminState {
  final String message;

  HotelAdminEmpty(this.message);
}

class HotelAdminErrorState extends HotelAdminState {
  final String errorMessage;

  HotelAdminErrorState(this.errorMessage);
}
