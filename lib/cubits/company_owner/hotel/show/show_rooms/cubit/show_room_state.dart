import 'package:reserva/models/comany_owner/hotel/hotel_home.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

abstract class ShowRoomState {}

class ShowRoomInitial extends ShowRoomState {}

class ShowRoomLoading extends ShowRoomState {}

class ShowRoomSuccess extends ShowRoomState {
  final List<Room> rooms;

  ShowRoomSuccess({
    required this.rooms,
  });
}

class ShowRoomFailure extends ShowRoomState {
  final String message;
  ShowRoomFailure({required this.message});
}

class ShowRoomEmpty extends ShowRoomState {
  final String message;

  ShowRoomEmpty({
    required this.message,
  });
}
