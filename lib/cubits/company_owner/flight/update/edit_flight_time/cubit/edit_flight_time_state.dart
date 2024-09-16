abstract class EditFlightTimeState {}

class EditFlightTimeInitial extends EditFlightTimeState {}

class EditFlightTimeLoading extends EditFlightTimeState {}

class EditFlightTimeSuccess extends EditFlightTimeState {
  final String message;

  EditFlightTimeSuccess({required this.message});
}

class EditFlightTimeFailure extends EditFlightTimeState {
  final String message;
  EditFlightTimeFailure({required this.message});
}

class Selected extends EditFlightTimeState {}

class NotSelected extends EditFlightTimeState {}

class TimeSuccess extends EditFlightTimeState {}
