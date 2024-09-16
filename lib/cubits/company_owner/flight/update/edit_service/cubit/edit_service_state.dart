abstract class EditServiceState {}

class EditServiceInitial extends EditServiceState {}

class EditServiceLoading extends EditServiceState {}

class EditServiceSuccess extends EditServiceState {}

class EditServiceFailure extends EditServiceState {
  final String message;
  EditServiceFailure({required this.message});
}
