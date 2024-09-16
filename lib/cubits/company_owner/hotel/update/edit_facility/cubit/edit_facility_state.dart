abstract class EditFacilityState {}

class EditFacilityInitial extends EditFacilityState {}

class EditFacilityLoading extends EditFacilityState {}

class EditFacilitySuccess extends EditFacilityState {}

class EditFacilityFailure extends EditFacilityState {
  final String message;
  EditFacilityFailure({required this.message});
}
