part of 'add_trip_cubit.dart';

@immutable
sealed class AddTripState {}

final class AddTripInitial extends AddTripState {}
class AddTripLoading extends AddTripState {

}
class AddTripSuccess extends AddTripState {
    AddTripSuccess();
}
class TimeSuccess extends AddTripState {
    
}

class AddFiltersSuccess extends AddTripState {

}

class AddTripFailure extends AddTripState {
  final String message;
  AddTripFailure({required this.message});
}