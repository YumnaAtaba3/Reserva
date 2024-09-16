import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reserva/helper/api.dart';
import 'package:reserva/models/admin/flight_admin.dart';
import 'package:reserva/models/admin/hotel_admin.dart';

part 'flight_admin_state.dart';

class FlightAdminCubit extends Cubit<FlightAdminState> {
  FlightAdminCubit() : super(FlightAdminInitial());

  
  void getFlightAdmins() async {
    emit(FlightAdminLoadingState());

    try {
      String base_url = Api().base_url;

      final response = await Api().get(url: '$base_url/showFlightAdmin');
      print('.........................');
      print(response.body);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print('2000000.........................');
        if (jsonResponse['status'] == 1) {
          if(jsonResponse['data'].isEmpty){
            print('empty user');
            emit(FlightAdminEmpty(jsonResponse['message']));
          }
          final adminsData = jsonResponse['data'] as List<dynamic>;
          final flightAdmin = adminsData
              .map((adminData) => AdminFlight(
                id: adminData['id'],
                    name: adminData['name'],
                    email: adminData['email'],
                    companyName: adminData['company_name'],
                  ))
              .toList();
          emit(FlightAdminLoadedState(flightAdmin,jsonResponse['message']));
        }
          else {
          emit(FlightAdminErrorState(jsonResponse['message']));
        }
      } else {
        emit(FlightAdminErrorState('No Admin Flight'));
      }
    } catch (e) {
        print('Error occurred: $e');
    
      emit(FlightAdminErrorState('An error occurred'));
    }
  }


    void addFlightAdmin(String name, String email, String companyName,String password,String password_confirmation) async {
    emit(FlightAdminLoadingState());

    try {
        String base_url = Api().base_url;
      
      final response = await Api().post(  url: '$base_url/addNewFlightAdmin',
      body: {
        'name': name,
        'email': email,
        'company_name': companyName,
        'password':password,
        'password_confirmation':password_confirmation,
      },
    );
    
    print('add flight admin');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] == 1) {
          getFlightAdmins();
        //  print('add flight admin sucssfuliy');
          emit(addFlightAdminLoadedState());
        } else {
          emit(FlightAdminErrorState(jsonResponse['message']));
        }
      } else {
        emit(FlightAdminErrorState('Failed to add flight admin'));
      }
    } catch (e) {
      emit(FlightAdminErrorState('An error occurred'));
    }
  }

  void deleteFlightAdmin(int adminId) async {
    emit(FlightAdminLoadingState());

    try {
      String base_url = Api().base_url;

      final response = await Api().get(
        url: '$base_url/deleteFlightAdmin/$adminId',
        
      );
      print('Response body: ${response.body}');
      print('Status code: ${response.statusCode}');
      print('deleeeeeeeeeeeet');
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] == 1) {
          print('deleeeeeeeeeeeet succesfull');
            final responseData = json.decode(response.body);
        if (responseData.containsKey('message')) {
          String message = responseData['message'];
          getFlightAdmins(); 
        emit(FlightAdminLoadedState([],message));
        }} else {
          emit(FlightAdminErrorState(jsonResponse['message']));
        }
      } else {
        emit(FlightAdminErrorState(' there is no admin'));
      }
    } catch (e) {
      emit(FlightAdminErrorState('An error occurred'));
    }
  }

}



