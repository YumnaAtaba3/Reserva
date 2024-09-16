abstract class EditHotelInfoState {}

class EditHotelInfoInitial extends EditHotelInfoState {}

class EditHotelInfoLoading extends EditHotelInfoState {}

class EditHotelInfoSuccess extends EditHotelInfoState {
  final String message;

  EditHotelInfoSuccess({required this.message});
}

class EditHotelInfoGotFiltersSuccess extends EditHotelInfoState {}

class EditHotelInfoFailure extends EditHotelInfoState {
  final String message;
  EditHotelInfoFailure({required this.message});
}
