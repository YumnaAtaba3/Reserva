import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reserva/cubits/company_owner/flight/flight_reservation/cubit/flight_reservations_state.dart';
import 'package:reserva/helper/api.dart';
import 'package:reserva/models/comany_owner/flight/flight_reserv.dart';

class FlightReservationsCubit extends Cubit<FlightReservationsState> {
  FlightReservationsCubit() : super(FlightReservationsInitial());

  void showFlightReserv() async {
    try {
      emit(FlightReservationsLoading());
      String base_url = Api().base_url;
      final data = await Api().get(url: '$base_url/showFlightReservation');
      if (data.statusCode == 200) {
        final responseData = jsonDecode(data.body);
        if (responseData['status'] == 1) {
          if (responseData['data'] is String) {
            // No hotel information available
            emit(FlightReservationsEmpty(message: responseData['message']));
          } else if (responseData['data'] is List) {
            final reservList = (responseData['data'] as List)
                .map((e) => FlightReservation.fromJson(e))
                .toList();
            emit(FlightReservationsSuccess(reserv: reservList));
          } else {
            // Unexpected data format
            emit(FlightReservationsFailure(message: 'Unexpected data format'));
          }
        }
      } else {
        emit(FlightReservationsFailure(message: 'Error fetching admin data'));
      }
    } on Exception catch (e) {
      emit(FlightReservationsFailure(message: "Something went wrong: $e"));
    }
  }
}
