import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

import 'package:reserva/cubits/company_owner/hotel/my_hotel/cubit/my_hotel_state.dart';
import 'package:reserva/cubits/company_owner/hotel/show/show_facility/cubit/show_facility_state.dart';
import 'package:reserva/cubits/company_owner/hotel/show/show_info/cubit/show_hotel_info_state.dart';
import 'package:reserva/helper/api.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

class ShowHotelInfoCubit extends Cubit<ShowHotelInfoState> {
  ShowHotelInfoCubit() : super(ShowHotelInfoInitial());
  List<HotelInfo>? hotelInfo;
  void showHotelInfo() async {
    try {
      emit(ShowHotelInfoLoading());
      String base_url = Api().base_url;
      final data = await Api().get(url: '$base_url/showHotelIfo');
      if (data.statusCode == 200) {
        final responseData = jsonDecode(data.body);
        if (responseData['status'] == 1) {
          if (responseData['data'] is String) {
            // No hotel information available
            emit(ShowHotelInfoEmpty(message: responseData['message']));
          } else if (responseData['data'] is List) {
            hotelInfo = (responseData['data'] as List)
                .map((e) => HotelInfo.fromJson(e))
                .toList();
            emit(ShowHotelInfoSuccess(hotelInfo: hotelInfo!));
          } else {
            // Unexpected data format
            emit(ShowHotelInfoFailure(message: 'Unexpected data format'));
          }
        } else {
          emit(ShowHotelInfoFailure(message: responseData['message']));
        }
      } else {
        emit(ShowHotelInfoFailure(message: 'Error fetching admin data'));
      }
    } on Exception catch (e) {
      emit(ShowHotelInfoFailure(message: "Something went wrong: $e"));
    }
  }
}
