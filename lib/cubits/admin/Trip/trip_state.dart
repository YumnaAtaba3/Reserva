part of 'trip_cubit.dart';

@immutable
sealed class TripState {}



final class TripInitial extends TripState {}

class TripLoadingState extends TripState {}

class TripLoadedState extends TripState {
  final List <Trip> Tripdata;
  final String message;

  TripLoadedState(this.Tripdata,this.message);
}

class TripDeletedState extends TripState {
    final String message;
    TripDeletedState(this.message);
}


class TripErrorState extends TripState {
  final String errorMessage;

  TripErrorState(this.errorMessage);
}