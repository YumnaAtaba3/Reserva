part of 'edit_attraction_cubit.dart';

@immutable
sealed class EditAttractionState {}

final class EditAttractionInitial extends EditAttractionState {}
class EditAttractionLoading extends EditAttractionState {}

class EditAttractionSuccess extends EditAttractionState { 
  final String message ;

  EditAttractionSuccess({required this.message});
    
    
}
class TimeSuccess extends EditAttractionState {
    
}

class EditFiltersSuccess extends EditAttractionState {

}
class EditPhotosSuccess extends EditAttractionState {
  final String message;

  EditPhotosSuccess({required this.message});
}

class EditAttractionFailure extends EditAttractionState {
  final String message;
  EditAttractionFailure({required this.message});
}