import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:reserva/constants.dart';

import 'package:reserva/cubits/company_owner/flight/update/edit_flight_time/cubit/edit_flight_time_state.dart';

import 'package:reserva/helper/api.dart';

class EditFlightTimeCubit extends Cubit<EditFlightTimeState> {
  EditFlightTimeCubit() : super(EditFlightTimeInitial());
  TimeOfDay selectedTime1 = TimeOfDay.now();
  TimeOfDay selectedTime2 = TimeOfDay.now();
  void updateSelectedTime1(TimeOfDay time) {
    selectedTime1 = time;
    emit(TimeSuccess());
  }

  void updateSelectedTime2(TimeOfDay time) {
    selectedTime2 = time;
    emit(TimeSuccess());
  }

  void EditFlightTime({
    required int id,
    required TimeOfDay from_hour,
    required TimeOfDay to_hour,
    required String departure_day,
    required String children_price,
    required String adult_price,
  }) async {
    emit(EditFlightTimeLoading());
    try {
      String base_url = Api().base_url;

      // final requestBody = {
      //   "from_hour": _formatTimeOfDay(from_hour),
      //   "to_hour": _formatTimeOfDay(to_hour),
      //   "departure_day": departure_day,
      //   "children_price": children_price,
      //   "adult_price": adult_price
      // };
      // final request = {requestBody};
      // Make the API request
      final data = await Api().post(
          url: '$base_url/editFlightTime/$id',
          body: {
            "from_hour": _formatTimeOfDay(from_hour),
            "to_hour": _formatTimeOfDay(to_hour),
            "departure_day": departure_day,
            "children_price": children_price,
            "adult_price": adult_price
          },
          // content: 'application/json',
          token: prefs!.getString("token"));
      print(data.body.toString());
      if (data.statusCode == 200) {
        print('222222220');

        print('afterrrrrrr');
        emit(EditFlightTimeSuccess(message: 'sucess'));
      } else {
        print('failureee');
        emit(EditFlightTimeFailure(message: jsonDecode(data.body)["message"]));
      }
    } on Exception catch (e) {
      print('exception');
      emit(EditFlightTimeFailure(message: "something is wrong ..."));
    }
  }

  String _formatTimeOfDay(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
