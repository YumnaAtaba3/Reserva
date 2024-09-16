import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reserva/helper/api.dart';
import 'package:reserva/models/admin/reserveTrip_model.dart';

part 'reservation_state.dart';

class ReservationCubit extends Cubit<ReservationState> {
  ReservationCubit() : super(ReservationInitial());

  
void getTrips() async {
  emit(ReservationLoadingState());

  try {
    String baseUrl = Api().base_url;

    final response = await Api().get(url: '$baseUrl/showTripReservation');

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);

      if (jsonResponse.isEmpty) {
        emit(ReservationEmpty('No trips found'));
      } else {
        final List<ReserveTrip> trips = jsonResponse.map((tripData) => ReserveTrip(
          tripName: tripData['trip_name'],
          fromDate: tripData['from_date'],
          toDate: tripData['to_date'],
          userName: tripData['user_name'],
          email: tripData['email'],
          phoneNumber: tripData['phone_number'],
          countOfPassenger: tripData['count_of_passenger'],
        )).toList();
        emit(ReservationLoadedState(trips));
      }
    } else {
      emit(ReservationErrorState('Failed to fetch trips'));
    }
  } catch (e) {
    emit(ReservationErrorState('An error occurred'));
  }
}
}