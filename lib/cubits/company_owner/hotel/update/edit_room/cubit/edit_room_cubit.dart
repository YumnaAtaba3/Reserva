import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reserva/constants.dart';

import 'package:http/http.dart' as http;

import 'package:reserva/cubits/company_owner/hotel/update/edit_room/cubit/edit_room_state.dart';

import 'package:reserva/helper/api.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

class EditRoomCubit extends Cubit<EditRoomState> {
  EditRoomCubit() : super(EditRoomInitial());
  List<RoomType>? roomTypes;
  List<Feature>? features;
  Future<void> getAllRoomTypes() async {
    emit(EditRoomLoading());
    try {
      print("before api request!!");

      final data =
          await Api().get(url: "${Api().base_url}/getAllFliters", token: null);
      print("after api request!!");
      print(data.body.toString());
      if (data.statusCode == 200) {
        List room_map = jsonDecode(data.body)["data"]["room_types"];

        roomTypes =
            List<RoomType>.from(room_map.map((e) => RoomType.fromJson(e)));

        emit(EditRoomGotFiltersSuccess());
      } else {
        emit(EditRoomFailure(message: jsonDecode(data.body)["message"]));
      }
    } catch (e) {
      emit(EditRoomFailure(message: e.toString()));
    }
  }

  void getAllRoomFeatures() async {
    try {
      emit(EditRoomLoading());
      String base_url = Api().base_url;
      final data = await Api().get(url: '$base_url/showAllFeatures');
      if (data.statusCode == 200) {
        final responseData = jsonDecode(data.body);
        if (responseData['status'] == 1) {
          features = (responseData['data'] as List)
              .map((e) => Feature.fromJson(e))
              .toList();
          emit(EditRoomGotFiltersSuccess());
        } else {
          emit(EditRoomFailure(message: responseData['message']));
        }
      }
    } on Exception catch (e) {
      emit(EditRoomFailure(message: "Something went wrong: $e"));
    }
  }

  File? selectedImage;
  var fileBytes;

  Future<void> EditRoom({
    required String room_type_id,
    required String beds,
    required String sleeps,
    required String details,
    required String price_for_night,
    required List<String> features,
    required int id,
    //required Uint8List fileBytes, // Edit this parameter to receive the image data
  }) async {
    emit(EditRoomLoading());
    try {
      // Create a new multipart request
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${Api().base_url}/editHotelRoom/$id'),
      );

      // Edit the form fields
      request.fields.addAll({
        'room_type_id': room_type_id,
        'beds': beds,
        'sleeps': sleeps,
        'details': details,
        'price_for_night': price_for_night,
        //'features': jsonEncode(features),
        // 'features': features.join(','),
        //'features[]': features,
      });
      // for (final feature in features) {
      //   request.fields.EditAll({'features[]': feature});
      // }
      // Edit the features as a list of strings
      // for (final feature in features) {
      //   request.fields['features[]'] = feature;
      // }

      // Edit the features as separate fields
      for (int i = 0; i < features.length; i++) {
        request.fields['features[$i]'] = features[i];
      }

      // Edit the image file
      request.files.add(http.MultipartFile.fromBytes(
        'photo[]',
        fileBytes,
        filename: 'photo.jpg',
      ));

      // Set the authorization token
      request.headers['Authorization'] = 'Bearer ${prefs!.getString("token")}';

      // Send the request and wait for the response
      final response = await request.send();

      // Read the response body
      final data = await response.stream.bytesToString();

      // Parse the response
      final data_map = jsonDecode(data);

      if (response.statusCode == 200) {
        emit(EditRoomSuccess(message: 'success'));
      } else if (response.statusCode == 422) {
        print("got validation error!!");

        emit(EditRoomFailure(message: data_map["message"]));
      } else {
        emit(EditRoomFailure(message: data_map["message"]));
      }
    } on Exception catch (e) {
      print(e.toString());
      emit(EditRoomFailure(message: "there is something wrong.."));
    }
  }

  void pickImage() {
    XFile? pickedFile;
    ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
      pickedFile = value;
      if (pickedFile != null) {
        print("selected image success!!!!");
        selectedImage = File(pickedFile!.path);
        emit(EditRoomGotFiltersSuccess());
      }
    });
  }
}
