import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:reserva/constants.dart';
import 'package:reserva/cubits/company_owner/flight/add/add_info/cubit/add_flight_info_state.dart';
import 'package:reserva/cubits/company_owner/hotel/add/add_info/cubit/add_hotel_info_state.dart';

import 'package:reserva/helper/api.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

class AddFlightInfoCubit extends Cubit<AddFlightInfoState> {
  AddFlightInfoCubit() : super(AddFlightInfoInitial());
  List<City>? cities;
  Future<void> getFilters() async {
    emit(AddFlightInfoLoading());
    try {
      print("before api request!!");

      final data =
          await Api().get(url: "${Api().base_url}/getAllFliters", token: null);
      print("after api request!!");
      print(data.body.toString());
      if (data.statusCode == 200) {
        List city_map = jsonDecode(data.body)["data"]["cities"];

        cities = List<City>.from(city_map.map((e) => City.fromJson(e)));

        emit(AddFlightInfoGotFiltersSuccess());
      } else {
        emit(AddFlightInfoFailure(message: jsonDecode(data.body)["message"]));
      }
    } catch (e) {
      emit(AddFlightInfoFailure(message: e.toString()));
    }
  }

  Future<void> AddFlightInfo({
    required String airway_name,
    required String city_id,
  }) async {
    emit(AddFlightInfoLoading());
    try {
      print("before api request!!");

      String base_url = Api().base_url;
      final data = await Api().post(
          url: "$base_url/addAirway",
          body: {
            'airway_name': airway_name,
            'city_id': city_id,
          },
          // content: 'application/json',
          token: prefs!.getString("token"));
      print("token");
      inspect(data);
      print("after api request!!");
      print(data.body.toString());

      if (data.statusCode == 200) {
        emit(AddFlightInfoSuccess(message: jsonDecode(data.body)["message"]));
      } else if (data.statusCode == 422) {
        emit(AddFlightInfoFailure(message: jsonDecode(data.body)["message"]));
      } else {
        emit(AddFlightInfoFailure(message: jsonDecode(data.body)["message"]));
      }
    } on Exception catch (e) {
      print(e.toString());
      emit(AddFlightInfoFailure(message: "there is something wrong.."));
    }
  }
}
