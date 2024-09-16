abstract class EditFlightState {}

class EditFlightInitial extends EditFlightState {}

class EditFlightLoading extends EditFlightState {}

class EditFlightSuccess extends EditFlightState {
  final String message;

  EditFlightSuccess({required this.message});
}

class EditFlightGotFiltersSuccess extends EditFlightState {}

class EditFlightFailure extends EditFlightState {
  final String message;
  EditFlightFailure({required this.message});
}

class Selected extends EditFlightState {}

class NotSelected extends EditFlightState {}

class TimeSuccess extends EditFlightState {}
