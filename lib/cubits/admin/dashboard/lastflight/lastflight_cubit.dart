import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reserva/helper/api.dart';
import 'package:reserva/models/admin/dashboard_model.dart';

part 'lastflight_state.dart';

class LastflightCubit extends Cubit<LastflightState> {
  LastflightCubit() : super(LastflightInitial());
      void showlastFlights() async {
    try {
      emit(Lastflightloading());

      String base_url = Api().base_url;

      final data = await Api().get(url: '$base_url/lastFlights');
       print('data :${data.body}');
      print("................................................");
    if (data.statusCode == 200) {
      final lastflightResponseData = jsonDecode(data.body);

      if (lastflightResponseData != null && lastflightResponseData is List) {
        final List<LastFlight> lastflight = lastflightResponseData.map((e) => LastFlight.fromJson(e)).toList();
        emit(dashboardSuccessLastFlight(Flight:   lastflight));
      } else {
        emit(EmptyLastFlight(message:lastflightResponseData['message']));
      }
    } else {
      emit(LastflightFailure(message: 'Error fetching last flight data'));
    }
  } catch (e) {
    emit(LastflightFailure(message: "Something went wrong: $e"));
  }
}
}
