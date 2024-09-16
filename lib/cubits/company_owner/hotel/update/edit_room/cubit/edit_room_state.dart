abstract class EditRoomState {}

class EditRoomInitial extends EditRoomState {}

class EditRoomLoading extends EditRoomState {}

class EditRoomSuccess extends EditRoomState {
  final String message;

  EditRoomSuccess({required this.message});
}

class EditRoomGotFiltersSuccess extends EditRoomState {}

class EditRoomFailure extends EditRoomState {
  final String message;
  EditRoomFailure({required this.message});
}
