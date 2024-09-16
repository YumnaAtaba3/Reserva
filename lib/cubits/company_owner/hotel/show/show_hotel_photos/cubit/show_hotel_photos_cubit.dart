import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reserva/constants.dart';
import 'package:reserva/cubits/company_owner/hotel/show/show_hotel_photos/cubit/show_hotel_photos_state.dart';
import 'package:reserva/helper/api.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

class ShowHotelPhotosCubit extends Cubit<ShowHotelPhotosState> {
  ShowHotelPhotosCubit() : super(ShowHotelPhotosInitial());
  void showHotelPhotos() async {
    try {
      emit(ShowHotelPhotosLoading());
      String base_url = Api().base_url;
      final data = await Api().get(url: '$base_url/showAllHotelPhotos');
      if (data.statusCode == 200) {
        final responseData = jsonDecode(data.body);
        if (responseData['status'] == 1) {
          if (responseData['data'] is List) {
            final photoList = (responseData['data'] as List)
                .map((e) => HotelPhotos.fromJson(e))
                .toList();
            emit(ShowHotelPhotosSuccess(photos: photoList));
          } else if (responseData['data'] == []) {
            emit(ShowHotelPhotosEmpty(message: responseData['message']));
          } else {
            emit(ShowHotelPhotosEmpty(message: responseData['message']));
          }
        } else {
          emit(ShowHotelPhotosFailure(message: responseData['message']));
        }
      }
    } on Exception catch (e) {
      emit(ShowHotelPhotosFailure(message: "Something went wrong: $e"));
    }
  }

  void deleteAllPhotos() async {
    try {
      emit(ShowHotelPhotosLoading());

      String base_url = Api().base_url;
      final data = await Api().get(
          url: '$base_url/deleteAllHotelPhotos',
          token: prefs!.getString('token'));
      print(data.body.toString());
      if (data.statusCode == 200) {
        showHotelPhotos();
      } else if (data.statusCode == 404) {
        emit(ShowHotelPhotosEmpty(message: 'empty'));
      } else {
        emit(ShowHotelPhotosFailure(message: jsonDecode(data.body)["message"]));
      }
    } on Exception catch (e) {
      emit(ShowHotelPhotosFailure(message: "something is wrong ..."));
    }
  }

  void deletePhoto({String? id}) async {
    try {
      emit(ShowHotelPhotosLoading());

      String base_url = Api().base_url;
      final data = await Api().get(
          url: '$base_url/deleteHotelPhoto/$id',
          token: prefs!.getString('token'));
      print(data.body.toString());
      if (data.statusCode == 200) {
        showHotelPhotos();
      } else if (data.statusCode == 404) {
        emit(ShowHotelPhotosEmpty(message: 'empty'));
      } else {
        emit(ShowHotelPhotosFailure(message: jsonDecode(data.body)["message"]));
      }
    } on Exception catch (e) {
      emit(ShowHotelPhotosFailure(message: "something is wrong ..."));
    }
  }
}
