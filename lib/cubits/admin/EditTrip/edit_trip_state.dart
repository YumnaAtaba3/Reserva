part of 'edit_trip_cubit.dart';

@immutable
sealed class EditTripState {}

final class EditTripInitial extends EditTripState {}
class EditTripLoading extends EditTripState {

}
class EditTripSuccess extends EditTripState {
    EditTripSuccess();
}
class TimeSuccess extends EditTripState {
    
}

class EditFiltersSuccess extends EditTripState {

}

class EditTripFailure extends EditTripState {
  final String message;
  EditTripFailure({required this.message});
}