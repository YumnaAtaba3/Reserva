part of 'reservation_cubit.dart';

@immutable
sealed class ReservationState {}

final class ReservationInitial extends ReservationState {}
class ReservationLoadingState extends ReservationState {}

class ReservationLoadedState extends ReservationState {
  final List<ReserveTrip> trips;

 ReservationLoadedState(this.trips);
}

class ReservationEmpty extends ReservationState {
  final String message;

 ReservationEmpty(this.message);
}



class ReservationErrorState extends ReservationState {
  final String errorMessage;

 ReservationErrorState(this.errorMessage);
}