abstract class AddFlightTimeState {}

class AddFlightTimeInitial extends AddFlightTimeState {}

class AddFlightTimeLoading extends AddFlightTimeState {}

class AddFlightTimeSuccess extends AddFlightTimeState {
  final String message;

  AddFlightTimeSuccess({required this.message});
}

class AddFlightTimeFailure extends AddFlightTimeState {
  final String message;
  AddFlightTimeFailure({required this.message});
}

class Selected extends AddFlightTimeState {}

class NotSelected extends AddFlightTimeState {}

class TimeSuccess extends AddFlightTimeState {}
