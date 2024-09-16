import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

import 'package:reserva/cubits/company_owner/hotel/my_hotel/cubit/my_hotel_state.dart';

import 'package:reserva/cubits/company_owner/hotel/show/show_facility/cubit/show_facility_state.dart';
import 'package:reserva/helper/api.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

class ShowFacilityCubit extends Cubit<ShowFacilityState> {
  ShowFacilityCubit() : super(ShowFacilityInitial());

  late List<Facility> facilities;

  void getAllFacilities() async {
    try {
      emit(ShowFacilityLoading());
      String base_url = Api().base_url;
      final data = await Api().get(url: '$base_url/showAllFacilites');
      if (data.statusCode == 200) {
        final responseData = jsonDecode(data.body);
        List datamap = jsonDecode(data.body)["data"];
        final facilities =
            List<Facility>.from(datamap.map((e) => Facility.fromJson(e)));
        this.facilities = facilities;
        // final facilities = (responseData['data'] as List)
        //     .map((e) => Facility.fromJson(e))
        //     .toList();
        // // this.facilities = facilities;
        emit(ShowFacilitySuccess(facilities: facilities));
      } else {
        emit(ShowFacilityFailure(message: jsonDecode(data.body)['message']));
      }
    } on Exception catch (e) {
      emit(ShowFacilityFailure(message: "Something went wrong: $e"));
    }
  }
}
