import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:reserva/cubits/admin/Trip/trip_cubit.dart';
import 'package:reserva/helper/api.dart';
import 'package:reserva/models/admin/service.dart';

part 'add_trip_state.dart';

class AddTripCubit extends Cubit<AddTripState> {
  AddTripCubit() : super(AddTripInitial());
  List<Service>? services;
    Future<void> getServices() async {
    emit(AddTripLoading());
    try {
      print("before api request!!");

      final response =
          await Api().get(url: "${Api().base_url}/getServices");
      print("after api request!!");
      print(response.body);
      print(response.body.toString());
  if (response.statusCode == 200) {
        List service_map = jsonDecode(response.body)["data"]["services"];

        services = List<Service>.from(service_map.map((e) => Service.fromJson(e)));
    print("Services Loaded: ${services!.length}"); 
        emit(AddFiltersSuccess());
      } else {
        emit(AddTripFailure(message: jsonDecode(response.body)["message"]));
      }
    } catch (e) {
      emit(AddTripFailure(message: e.toString()));
    }
  }

  File? selectedImage;
  var fileBytes;
      TimeOfDay selectedTime1 = TimeOfDay.now();
  TimeOfDay selectedTime2 = TimeOfDay.now();
  
  void updateSelectedTime1(TimeOfDay time) {
    selectedTime1 = time;
    
      print(".....................time1 Trip....................");
    emit(TimeSuccess());
  }

  void updateSelectedTime2(TimeOfDay time) {
    selectedTime2 = time;
    
      print("...................time2  trip......................");
    emit(TimeSuccess());
  }



  void pickImage() {
    XFile? pickedFile;
    ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
      pickedFile = value;
      if (pickedFile != null) {
        print("selected image success!!!!");
        selectedImage = File(pickedFile!.path);
        emit(AddTripSuccess());
      }
    });
  }

  // Helper method to format TimeOfDay object
  String _formatTimeOfDay(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }




    
    Future<void> AddTripinfo({
    required String tripName,
    required String price,
    required String destination,
    required String required_age,
    required int number_of_days,
    required int max_number_of_people,
    required String trip_details,
    required String trip_programme,
    required String departure_day,
    required List<String> service,
    

  }) async {
    emit(AddTripLoading());
    try {
        String base_url = "http://127.0.0.1:8000/api";
      // Create a new multipart request
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$base_url/addTrip'),
      );

      // Add the form fields
      request.fields.addAll({
        'trip_name': tripName,
        'price':  price,
        'destination': destination,
        'required_age': required_age,
        'number_of_days': number_of_days.toString(),
        'max_number_of_people': max_number_of_people.toString(),
        'trip_details': trip_details,
        'trip_programme': trip_programme,
          "from_date": departure_day,
        
      });
  for (int i = 0; i < service.length; i++) {
        request.fields['services[$i]'] = service[i];
      }
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
TripCubit tripCubit = TripCubit();
tripCubit.showAllTrip;
        emit(AddFiltersSuccess());
      }
      
        else {
          print("failurrrrrrrrrrrrrrrrrrrrrrrre");
        emit(AddTripFailure(message: data_map["message"]));
      }
    } on Exception catch (e) {
      print(e.toString());
          print(' erorr is $e');
      emit(AddTripFailure(message: "there is something wrong.."));
    }
  }
}


