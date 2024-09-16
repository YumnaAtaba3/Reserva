abstract class AddRoomState {}

class AddRoomInitial extends AddRoomState {}

class AddRoomLoading extends AddRoomState {}

class AddRoomSuccess extends AddRoomState {
  final String message;

  AddRoomSuccess({required this.message});
}

class AddRoomGotFiltersSuccess extends AddRoomState {}

class AddRoomFailure extends AddRoomState {
  final String message;
  AddRoomFailure({required this.message});
}
