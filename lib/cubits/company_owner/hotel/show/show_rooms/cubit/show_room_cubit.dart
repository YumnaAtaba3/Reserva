import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:reserva/constants.dart';

import 'package:reserva/cubits/company_owner/hotel/my_hotel/cubit/my_hotel_state.dart';
import 'package:reserva/cubits/company_owner/hotel/show/show_facility/cubit/show_facility_state.dart';
import 'package:reserva/cubits/company_owner/hotel/show/show_rooms/cubit/show_room_state.dart';
import 'package:reserva/helper/api.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

class ShowRoomCubit extends Cubit<ShowRoomState> {
  ShowRoomCubit() : super(ShowRoomInitial());

  void showHotelRooms() async {
    try {
      emit(ShowRoomLoading());
      String base_url = Api().base_url;
      final data =
          await Api().get(url: '$base_url/showAllHotelWithItPhotosAndRooms');
      if (data.statusCode == 200) {
        final responseData = json.decode(data.body);
        print('responseData: $responseData');

        if (responseData['status'] == 1) {
          if (responseData['data'].isEmpty) {
            print('emptyyyyyy room');
            emit(ShowRoomEmpty(message: responseData['message']));
          } else {
            List datamap = jsonDecode(data.body)["data"]["rooms"];

            final roomList =
                List<Room>.from(datamap.map((e) => Room.fromJson(e)));
            emit(ShowRoomSuccess(rooms: roomList));
          }
        }
      } else {
        emit(ShowRoomFailure(message: 'Error fetching admin data'));
      }
    } on Exception catch (e) {
      emit(ShowRoomFailure(message: "Something went wrong: $e"));
    }
  }

  void deleteAllRooms() async {
    try {
      emit(ShowRoomLoading());

      String base_url = Api().base_url;
      final data = await Api().get(
          url: '$base_url/deleteAllRoom', token: prefs!.getString('token'));
      print(data.body.toString());
      if (data.statusCode == 200) {
        showHotelRooms();
      } else if (data.statusCode == 404) {
        emit(ShowRoomEmpty(message: 'empty'));
      } else {
        emit(ShowRoomFailure(message: jsonDecode(data.body)["message"]));
      }
    } on Exception catch (e) {
      emit(ShowRoomFailure(message: "something is wrong ..."));
    }
  }

  void deleteRoom({String? id}) async {
    try {
      emit(ShowRoomLoading());

      String base_url = Api().base_url;
      final data = await Api().get(
          url: '$base_url/deleteRoom/$id', token: prefs!.getString('token'));
      print(data.body.toString());
      if (data.statusCode == 200) {
        showHotelRooms();
      } else if (data.statusCode == 404) {
        emit(ShowRoomEmpty(message: 'empty'));
      } else {
        emit(ShowRoomFailure(message: jsonDecode(data.body)["message"]));
      }
    } on Exception catch (e) {
      emit(ShowRoomFailure(message: "something is wrong ..."));
    }
  }
}
