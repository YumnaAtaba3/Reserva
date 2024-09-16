abstract class AddFlightInfoState {}

class AddFlightInfoInitial extends AddFlightInfoState {}

class AddFlightInfoLoading extends AddFlightInfoState {}

class AddFlightInfoSuccess extends AddFlightInfoState {
  final String message;

  AddFlightInfoSuccess({required this.message});
}

class AddFlightInfoGotFiltersSuccess extends AddFlightInfoState {}

class AddFlightInfoFailure extends AddFlightInfoState {
  final String message;
  AddFlightInfoFailure({required this.message});
}
