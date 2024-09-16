abstract class EditFlightInfoState {}

class EditFlightInfoInitial extends EditFlightInfoState {}

class EditFlightInfoLoading extends EditFlightInfoState {}

class EditFlightInfoSuccess extends EditFlightInfoState {
  final String message;

  EditFlightInfoSuccess({required this.message});
}

class EditFlightInfoGotFiltersSuccess extends EditFlightInfoState {}

class EditFlightInfoFailure extends EditFlightInfoState {
  final String message;
  EditFlightInfoFailure({required this.message});
}
