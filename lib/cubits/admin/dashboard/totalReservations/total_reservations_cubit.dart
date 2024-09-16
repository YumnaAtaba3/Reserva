import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reserva/helper/api.dart';
import 'package:reserva/models/admin/dashboard_model.dart';

part 'total_reservations_state.dart';

class TotalReservationsCubit extends Cubit<TotalReservationsState> {
  TotalReservationsCubit() : super(TotalReservationsInitial());
  void showtotalReservations() async {
    try {
      emit(TotalReservationsLoading());

      String base_url = Api().base_url;

      final data = await Api().get(url: '$base_url/totalReservations');
   print('data :${data.body}');
      print("................................................");
      if (data.statusCode == 200) {
        final responseData = jsonDecode(data.body);

        final totalReservations = TotalReservations.fromJson(responseData);
        emit(dashboardSuccessTotalReservations(totalReservations: totalReservations));
      } else {
        emit(TotalReservationsFailure(message: 'Error fetching last clients data'));
      }
    } on Exception catch (e) {
      emit(TotalReservationsFailure(message: "Something went wrong: $e"));
    }
  }
}
