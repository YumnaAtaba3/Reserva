import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:reserva/constants.dart';
import 'package:reserva/cubits/company_owner/flight/update/edit_flight/cubit/edit_flight_state.dart';

import 'package:reserva/helper/api.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

class EditFlightCubit extends Cubit<EditFlightState> {
  EditFlightCubit() : super(EditFlightInitial());
  List<City>? cities;

  bool checkboxValue = false;
  TimeOfDay selectedTime1 = TimeOfDay.now();
  bool handboxValue = false;
  TimeOfDay selectedTime2 = TimeOfDay.now();
  void toggleCheckedbox() {
    checkboxValue = !checkboxValue;
    if (checkboxValue) {
      emit(Selected());
    } else {
      emit(NotSelected());
    }
  }

  void toggleHandbox() {
    handboxValue = !handboxValue;
    if (handboxValue) {
      emit(Selected());
    } else {
      emit(NotSelected());
    }
  }

  void updateSelectedTime1(TimeOfDay time) {
    selectedTime1 = time;
    emit(TimeSuccess());
  }

  void updateSelectedTime2(TimeOfDay time) {
    selectedTime2 = time;
    emit(TimeSuccess());
  }

  Future<void> getFilters() async {
    emit(EditFlightLoading());
    try {
      print("before api request!!");

      final data =
          await Api().get(url: "${Api().base_url}/getAllFliters", token: null);
      print("after api request!!");
      print(data.body.toString());
      if (data.statusCode == 200) {
        List city_map = jsonDecode(data.body)["data"]["cities"];

        cities = List<City>.from(city_map.map((e) => City.fromJson(e)));

        emit(EditFlightGotFiltersSuccess());
      } else {
        emit(EditFlightFailure(message: jsonDecode(data.body)["message"]));
      }
    } catch (e) {
      emit(EditFlightFailure(message: e.toString()));
    }
  }

  void EditFlight(
      {required String from_city_id,
      required String to_city_id,
      required String seat_selection1,
      required String seat_selection2,
      required String seat_selection3,
      required String seats_num,
      // required TimeOfDay from_hour,
      // required TimeOfDay to_hour,
      // required String departure_day,
      // required String children_price,
      // required String adult_price,
      required bool checked_bag,
      required bool hand_bag,
      required int id
      //  required context
      }) async {
    emit(EditFlightLoading());
    try {
      String base_url = Api().base_url;

      final requestBody = {
        "from_city_id": from_city_id,
        "to_city_id": to_city_id,
        "classes": {
          "economy": {"flight_class_id": 1, "seat_selection": seat_selection1},
          "first": {"flight_class_id": 2, "seat_selection": seat_selection2},
          "business": {"flight_class_id": 3, "seat_selection": seat_selection3}
        },
        "seats_num": seats_num,
        "checked_bag": checked_bag,
        "hand_bag": hand_bag,
        // "from_hour": _formatTimeOfDay(from_hour),
        // "to_hour": _formatTimeOfDay(to_hour),
        // "departure_day": departure_day,
        // "children_price": children_price,
        // "adult_price": adult_price
      };
      // final request = {requestBody};
      // Make the API request
      final data = await Api().post(
          url: '$base_url/editFlight/$id',
          body: jsonEncode(requestBody),
          content: 'application/json',
          token: prefs!.getString("token"));
      print(data.body.toString());
      if (data.statusCode == 200) {
        print('222222220');
        //  BlocProvider.of<ShowServiceCubit>(context)
        //          .services
        //          .firstWhere((element) => element.id == id)
        //          .enabled !=
        //      enabled;
        print('afterrrrrrr');
        emit(EditFlightSuccess(message: 'sucess'));
      } else {
        print('failureee');
        emit(EditFlightFailure(message: jsonDecode(data.body)["message"]));
      }
    } on Exception catch (e) {
      print('exception');
      emit(EditFlightFailure(message: "something is wrong ..."));
    }
  }

  String _formatTimeOfDay(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
