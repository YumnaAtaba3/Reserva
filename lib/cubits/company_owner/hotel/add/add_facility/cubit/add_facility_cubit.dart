import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:reserva/constants.dart';
import 'package:reserva/cubits/company_owner/hotel/add/add_facility/cubit/add_facility_state.dart';
import 'package:reserva/helper/api.dart';

class AddFacilityCubit extends Cubit<AddFacilityState> {
  AddFacilityCubit() : super(AddFacilityInitial());
  Future<void> AddFacility({
    required String facility_name,
  }) async {
    emit(AddFacilityLoading());
    try {
      print("before api request!!");

      String base_url = Api().base_url;
      final data = await Api().post(
          url: "$base_url/addNewFacility",
          body: {
            'facility_name': facility_name,
          },
          // content: 'application/json',
          token: prefs!.getString("token"));
      print("token");
      inspect(data);
      print("after api request!!");
      print(data.body.toString());

      if (data.statusCode == 200) {
        emit(AddFacilitySuccess(message: jsonDecode(data.body)["message"]));
      } else if (data.statusCode == 422) {
        emit(AddFacilityFailure(message: jsonDecode(data.body)["message"]));
      } else {
        emit(AddFacilityFailure(message: jsonDecode(data.body)["message"]));
      }
    } on Exception catch (e) {
      print(e.toString());
      emit(AddFacilityFailure(message: "there is something wrong.."));
    }
  }
}
