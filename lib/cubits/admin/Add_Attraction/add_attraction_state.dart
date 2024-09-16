part of 'add_attraction_cubit.dart';

@immutable
sealed class AddAttractionState {}

final class AddAttractionInitial extends AddAttractionState {}
class AddAttractionLoading extends AddAttractionState {}

class AddAttractionSuccess extends AddAttractionState {
    
    
}
class TimeSuccess extends AddAttractionState {
    
}

class AddFiltersSuccess extends AddAttractionState {

}
class AddPhotosSuccess extends AddAttractionState {
  final String message;

  AddPhotosSuccess({required this.message});
}

class AddAttractionFailure extends AddAttractionState {
  final String message;
  AddAttractionFailure({required this.message});
}