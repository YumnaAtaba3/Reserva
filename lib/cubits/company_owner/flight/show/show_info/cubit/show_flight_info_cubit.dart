import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reserva/cubits/company_owner/flight/show/show_info/cubit/show_flight_info_state.dart';
import 'package:reserva/helper/api.dart';
import 'package:reserva/models/comany_owner/flight/my_flight.dart';

class ShowFlightInfoCubit extends Cubit<ShowFlightInfoState> {
  ShowFlightInfoCubit() : super(ShowFlightInfoInitial());
  List<FlightInfo>? flightInfo;
  void showFlightInfo() async {
    try {
      emit(ShowFlightInfoLoading());
      String base_url = Api().base_url;
      final data = await Api().get(url: '$base_url/showAirwayIfo');
      if (data.statusCode == 200) {
        final responseData = jsonDecode(data.body);
        if (responseData['status'] == 1) {
          if (responseData['data'] is String) {
            // No hotel information available
            emit(ShowFlightInfoEmpty(message: responseData['message']));
          } else if (responseData['data'] is List) {
            flightInfo = (responseData['data'] as List)
                .map((e) => FlightInfo.fromJson(e))
                .toList();
            emit(ShowFlightInfoSuccess(flightInfo: flightInfo!));
          } else {
            // Unexpected data format
            emit(ShowFlightInfoFailure(message: 'Unexpected data format'));
          }
        } else {
          emit(ShowFlightInfoFailure(message: responseData['message']));
        }
      } else {
        emit(ShowFlightInfoFailure(message: 'Error fetching admin data'));
      }
    } on Exception catch (e) {
      emit(ShowFlightInfoFailure(message: "Something went wrong: $e"));
    }
  }
}
