import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:reserva/constants.dart';
import 'package:reserva/cubits/company_owner/hotel/add/add_info/cubit/add_hotel_info_state.dart';

import 'package:reserva/helper/api.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';
import 'package:reserva/widgets/company_owner/hotels/add_hotel_info.dart';

class AddHotelInfoCubit extends Cubit<AddHotelInfoState> {
  AddHotelInfoCubit() : super(AddHotelInfoInitial());
  List<City>? cities;
  Future<void> getFilters() async {
    emit(AddHotelInfoLoading());
    try {
      print("before api request!!");

      final data =
          await Api().get(url: "${Api().base_url}/getAllFliters", token: null);
      print("after api request!!");
      print(data.body.toString());
      if (data.statusCode == 200) {
        List city_map = jsonDecode(data.body)["data"]["cities"];

        cities = List<City>.from(city_map.map((e) => City.fromJson(e)));

        emit(AddHotelInfoGotFiltersSuccess());
      } else {
        emit(AddHotelInfoFailure(message: jsonDecode(data.body)["message"]));
      }
    } catch (e) {
      emit(AddHotelInfoFailure(message: e.toString()));
    }
  }

  Future<void> AddHotelInfo({
    required String hotel_name,
    required String location,
    required String description,
    required String city_id,
    required String stars,
  }) async {
    emit(AddHotelInfoLoading());
    try {
      print("before api request!!");

      String base_url = Api().base_url;
      final requestBody = {
        'hotel_name': hotel_name,
        'location': location,
        'description': description,
        'city_id': city_id,
        'stars': stars
      };
      final data = await Api().post(
          url: "$base_url/addHotel",
          body: jsonEncode(requestBody),
          content: 'application/json',
          token: prefs!.getString("token"));
      print("token");
      inspect(data);
      print("after api request!!");
      print(data.body.toString());

      if (data.statusCode == 200) {
        emit(AddHotelInfoSuccess(message: jsonDecode(data.body)["message"]));
      } else if (data.statusCode == 422) {
        emit(AddHotelInfoFailure(message: jsonDecode(data.body)["message"]));
      } else {
        emit(AddHotelInfoFailure(message: jsonDecode(data.body)["message"]));
      }
    } on Exception catch (e) {
      print(e.toString());
      emit(AddHotelInfoFailure(message: "there is something wrong.."));
    }
  }
}
