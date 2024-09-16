import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reserva/cubits/company_owner/flight/flight_reservation/cubit/flight_reservations_state.dart';
import 'package:reserva/cubits/company_owner/hotel/hotel_reservation/cubit/hotel_reservations_state.dart';
import 'package:reserva/helper/api.dart';
import 'package:reserva/models/comany_owner/flight/flight_reserv.dart';
import 'package:reserva/models/comany_owner/hotel/hotel_reserv.dart';

class HotelReservationsCubit extends Cubit<HotelReservationsState> {
  HotelReservationsCubit() : super(HotelReservationsInitial());

  void showHotelReserv() async {
    try {
      emit(HotelReservationsLoading());
      String base_url = Api().base_url;
      final data = await Api().get(url: '$base_url/showHotelReservation');
      if (data.statusCode == 200) {
        final responseData = jsonDecode(data.body);
        if (responseData['status'] == 1) {
          if (responseData['data'] is String) {
            // No hotel information available
            emit(HotelReservationsEmpty(message: responseData['message']));
          } else if (responseData['data'] is List) {
            final reservList = (responseData['data'] as List)
                .map((e) => HotelReservation.fromJson(e))
                .toList();
            emit(HotelReservationsSuccess(reserv: reservList));
          } else {
            // Unexpected data format
            emit(HotelReservationsFailure(message: 'Unexpected data format'));
          }
        }
      } else {
        emit(HotelReservationsFailure(message: 'Error fetching admin data'));
      }
    } on Exception catch (e) {
      emit(HotelReservationsFailure(message: "Something went wrong: $e"));
    }
  }
}
