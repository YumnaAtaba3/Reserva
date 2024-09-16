abstract class AddHotelInfoState {}

class AddHotelInfoInitial extends AddHotelInfoState {}

class AddHotelInfoLoading extends AddHotelInfoState {}

class AddHotelInfoSuccess extends AddHotelInfoState {
  final String message;

  AddHotelInfoSuccess({required this.message});
}

class AddHotelInfoGotFiltersSuccess extends AddHotelInfoState {}

class AddHotelInfoFailure extends AddHotelInfoState {
  final String message;
  AddHotelInfoFailure({required this.message});
}
