import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reserva/helper/api.dart';
import 'package:reserva/models/admin/hotel_admin.dart';

part 'hotel_admin_state.dart';

class HotelAdminCubit extends Cubit<HotelAdminState> {

  HotelAdminCubit() : super(HotelAdminInitial());

  void getHoteltAdmins() async {
    emit(HotelAdminLoadingState());

    try {
      String base_url = Api().base_url;

      final response = await Api().get(url: '$base_url/showHotelAdmin');
      print('.........................');
      print(response.body);
      if (response.statusCode == 200) {
        
        final jsonResponse = jsonDecode(response.body);
        print('2000000.........................');
        if (jsonResponse['status'] == 1) {
          if(jsonResponse['data'].isEmpty){
            print('empty user');
            emit(HotelAdminEmpty(jsonResponse['message']));
          }
          final adminsData = jsonResponse['data'] as List<dynamic>;
          final hotelAdmin = adminsData
              .map((adminData) => HotelAdmin(
                  id: adminData['id'],
                    name: adminData['name'],
                    email: adminData['email'],
                    companyName: adminData['company_name'],
                  ))
              .toList();
          emit(HotelAdminLoadedState(hotelAdmin,jsonResponse['message']));
        } else {
          emit(HotelAdminErrorState(jsonResponse['message']));
        }
      } else {
        emit(HotelAdminErrorState('Failed to fetch hotel admins'));
      }
    } catch (e) {
      emit(HotelAdminErrorState('An error occurred'));
    }
  }


void addHotelAdmin(String name, String email, String companyName,String password,String password_confirmation) async {
    emit(HotelAdminLoadingState());

    try {
        String base_url = Api().base_url;
      
      final response = await Api().post(  url: '$base_url/addNewHotelAdmin',
      body: {
        'name': name,
        'email': email,
        'company_name': companyName,
        'password':password,
        'password_confirmation':password_confirmation,
      },
    );


      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] == 1) {
          getHoteltAdmins();
        
          emit(AddHotelAdminLoadedState());
        } else {
          emit(HotelAdminErrorState(jsonResponse['message']));
        }
      } else {
        emit(HotelAdminErrorState('Failed to add Hotel admin'));
      }
    } catch (e) {
      emit(HotelAdminErrorState('An error occurred'));
    }
}


void deleteHotelAdmin(int id) async {
  emit(HotelAdminLoadingState());

  try {
    String base_url = Api().base_url;

    final response = await Api().get(
      url: '$base_url/deleteHotelAdmin/$id',
   
    );
 print('delete Hotel admin');
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
          print('delete Hotel admin sucssful');
      if (jsonResponse['status'] == 1) {
          final responseData = json.decode(response.body);
        if (responseData.containsKey('message')) {
          String message = responseData['message'];
          getHoteltAdmins(); 
        emit(HotelAdminLoadedState([],message));
        
          getHoteltAdmins(); 
      }} else {
        emit(HotelAdminErrorState(jsonResponse['message']));
      }
    }else {
        emit(HotelAdminErrorState("there is no admin"));
      }
  } catch (e) {
    emit(HotelAdminErrorState('An error occurred'));
  }
}
// void deleteHotelAdmin(int adminId) async {
//     emit(HotelAdminLoadingState());

//     try {
//       String base_url = Api().base_url;

//       final response = await Api().get(
//         url: '$base_url/deleteHotelAdmin/$adminId',
        
//       );
//       print('Response body: ${response.body}');
//       print('Status code: ${response.statusCode}');
//       print('deleeeeeeeeeeeet');
//       if (response.statusCode == 200) {
//         final jsonResponse = jsonDecode(response.body);
//         if (jsonResponse['status'] == 1) {
//           print('deleeeeeeeeeeeet succesfull');
//             final responseData = json.decode(response.body);
//         if (responseData.containsKey('message')) {
//           String message = responseData['message'];
//           getHoteltAdmins(); 
//         emit(HotelAdminLoadedState([],message));
//         }} else {
//           emit(HotelAdminErrorState(jsonResponse['message']));
//         }
//       } else {
//         emit(HotelAdminEmpty('there is no admin yet'));
//       }
//     } catch (e) {
//       emit(HotelAdminErrorState('An error occurred'));
//     }
//   }

}
