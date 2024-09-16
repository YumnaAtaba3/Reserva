abstract class AddFlightState {}

class AddFlightInitial extends AddFlightState {}

class AddFlightLoading extends AddFlightState {}

class AddFlightSuccess extends AddFlightState {
  final String message;

  AddFlightSuccess({required this.message});
}

class AddFlightGotFiltersSuccess extends AddFlightState {}

class AddFlightFailure extends AddFlightState {
  final String message;
  AddFlightFailure({required this.message});
}

class Selected extends AddFlightState {}

class NotSelected extends AddFlightState {}

class TimeSuccess extends AddFlightState {}
