import 'dart:convert';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reserva/constants.dart';
import 'package:reserva/cubits/admin/Attraction/attraction_cubit.dart';
import 'package:reserva/helper/api.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reserva/models/admin/attraction_model.dart';
part 'add_attraction_state.dart';

class AddAttractionCubit extends Cubit<AddAttractionState> {
  AddAttractionCubit() : super(AddAttractionInitial());
  List<AttractionType>? attractionTypes; 
    List<City>? cities;
  File? selectedImage;
  var fileBytes;
      TimeOfDay selectedTime1 = TimeOfDay.now();
  TimeOfDay selectedTime2 = TimeOfDay.now();
  
  void updateSelectedTime1(TimeOfDay time) {
    selectedTime1 = time;
    
      print(".....................time1....................");
    emit(TimeSuccess());
  }

  void updateSelectedTime2(TimeOfDay time) {
    selectedTime2 = time;
    
      print("...................time2......................");
    emit(TimeSuccess());
  }


 

  Future<void> getFilters() async {
    emit(AddAttractionLoading());
    try {
      print("before api request!!");

      final response =
          await Api().get(url: "${Api().base_url}/getAttractionType");
      print("after api request!!");
      print(response.body.toString());
  if (response.statusCode == 200) {
        List attraction_map = jsonDecode(response.body)["data"]["attractions_types"];

        attractionTypes = List<AttractionType>.from(attraction_map .map((e) => AttractionType.fromJson(e)));

        emit(AddFiltersSuccess());
      } else {
        emit(AddAttractionFailure(message: jsonDecode(response.body)["message"]));
      }
    } catch (e) {
      emit(AddAttractionFailure(message: e.toString()));
    }
  }



  Future<void> getFilterscity() async {
    emit(AddAttractionLoading());
    try {
      print(".........................................");

      final response =
          await Api().get(url: "${Api().base_url}/getCities");
      print("after api request!!");
      print(response.body.toString());
  if (response.statusCode == 200) {
        List city_map = jsonDecode(response.body)["data"]["cities"];

        cities = List<City>.from(city_map.map((e) => City.fromJson(e)));

        emit(AddFiltersSuccess());
      } else {
        emit(AddAttractionFailure(message: jsonDecode(response.body)["message"]));
      }
    } catch (e) {
      emit(AddAttractionFailure(message: e.toString()));
    }
  }


  void pickImage() {
    XFile? pickedFile;
    ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
      pickedFile = value;
      if (pickedFile != null) {
        print("selected image success!!!!");
        selectedImage = File(pickedFile!.path);
        emit(AddAttractionSuccess());
      }
    });
  }

  // Helper method to format TimeOfDay object
  String _formatTimeOfDay(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }


  Future<void> AddAttractioninfo({
    required String attractionName,
    required TimeOfDay open_at,
    required TimeOfDay close_at,
    required String about,
    required String cityId,
    required String attractionTypeId,

  }) async {
    emit(AddAttractionLoading());
    try {
       String base_url = "http://127.0.0.1:8000/api";
      // Create a new multipart request
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$base_url/addAttraction'),
      );

      // Add the form fields
      request.fields.addAll({
          'attraction_name': attractionName,
          'open_at': _formatTimeOfDay(open_at),
          'close_at': _formatTimeOfDay(close_at),
          'about': about,
          'city_id': cityId,
          'attraction_type_id': attractionTypeId,
        
        
      });
      
      
      // Add the image file
      request.files.add(http.MultipartFile.fromBytes(
        'photo[]',
        fileBytes,
        filename: 'photo.jpg',
      ));

      // Set the authorization token
     // request.headers['Authorization'] = 'Bearer 19|2CV7j2LAuQ9adbcilfWIZv4RXb1t6TqvalbFIwUI149e73ea';

      // Send the request and wait for the response
      final response = await request.send();
print(response);
print("...........response........................");
      // Read the response body
      final data = await response.stream.bytesToString();

      // Parse the response
      final data_map = jsonDecode(data);

      if (response.statusCode == 200) {
        print('afterrrrrrr');
      AttractionCubit attractionCubit = AttractionCubit();
      attractionCubit.fetchAttractions();
        emit(AddFiltersSuccess());
      }
      
      //  else if (response.statusCode == 422) {
      //   print("got validation error!!");

      //   emit(AddAttractionFailure(message: data_map["message"]));
      // }
        else {
          print("failurrrrrrrrrrrrrrrrrrrrrrrre");
        emit(AddAttractionFailure(message: data_map["message"]));
      }
    } on Exception catch (e) {
      print(e.toString());
          print(' erorr is $e');
      emit(AddAttractionFailure(message: "there is something wrong.."));
    }
  }
}














