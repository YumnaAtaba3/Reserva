import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:reserva/cubits/company_owner/flight/show/show_service/cubit/show_service_state.dart';

import 'package:reserva/cubits/company_owner/hotel/my_hotel/cubit/my_hotel_state.dart';

import 'package:reserva/helper/api.dart';
import 'package:reserva/models/comany_owner/flight/my_flight.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

class ShowServiceCubit extends Cubit<ShowServiceState> {
  ShowServiceCubit() : super(ShowServiceInitial());

  late List<Service> services;

  void getAllServices() async {
    try {
      emit(ShowServiceLoading());
      String base_url = Api().base_url;
      final data = await Api().get(url: '$base_url/showAllServices');
      if (data.statusCode == 200) {
        final responseData = jsonDecode(data.body);
        List datamap = jsonDecode(data.body)["data"];
        final services =
            List<Service>.from(datamap.map((e) => Service.fromJson(e)));
        this.services = services;

        emit(ShowServiceSuccess(services: services));
      } else {
        emit(ShowServiceFailure(message: jsonDecode(data.body)['message']));
      }
    } on Exception catch (e) {
      emit(ShowServiceFailure(message: "Something went wrong: $e"));
    }
  }
}
