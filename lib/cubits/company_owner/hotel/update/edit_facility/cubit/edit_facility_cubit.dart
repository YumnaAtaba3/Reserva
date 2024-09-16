import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/constants.dart';
import 'package:reserva/cubits/company_owner/hotel/my_hotel/cubit/my_hotel_cubit.dart';
import 'package:reserva/cubits/company_owner/hotel/show/show_facility/cubit/show_facility_cubit.dart';

import 'package:reserva/cubits/company_owner/hotel/update/edit_facility/cubit/edit_facility_state.dart';

import 'package:reserva/helper/api.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

class EditFacilityCubit extends Cubit<EditFacilityState> {
  EditFacilityCubit() : super(EditFacilityInitial());
  void ChangeFacility(
      {required int id,
      required String facility_name,
      required bool enabled,
      required context}) async {
    emit(EditFacilityLoading());
    try {
      String base_url = Api().base_url;
      // Prepare the request body
      // List<Map<String, dynamic>> facilities = [
      //   {
      //     "facility_id": id,
      //     "facility_name": facility_name,
      //     "enabled": enabled,
      //   },
      // ];
      // final requestBody = {
      //   "facilities": facilities,
      // };
      // final requestBody = {
      //   "facilities": [
      //     {
      //       "facility_id": id,
      //       "facility_name": facility_name,
      //       "enabled": enabled,
      //     },
      //   ],
      // };
      // final requestBody = [
      //   {
      //     "facility_id": id,
      //     "facility_name": facility_name,
      //     "enabled": enabled,
      //   },
      // ];
      // final request = {"facilities": requestBody};
      final requestBody = {
        "facilities": [
          {
            "facility_id": id,
            "facility_name": facility_name,
            "enabled": enabled,
          },
        ],
      };
      // final request = {requestBody};
      // Make the API request
      final data = await Api().post(
          url: '$base_url/editFacility',
          body: jsonEncode(requestBody),
          content: 'application/json',
          token: prefs!.getString("token"));
      print(data.body.toString());
      if (data.statusCode == 200) {
        print('222222220');
        BlocProvider.of<ShowFacilityCubit>(context)
                .facilities
                .firstWhere((element) => element.id == id)
                .enabled !=
            enabled;
        print('afterrrrrrr');
        emit(EditFacilitySuccess());
      } else {
        print('failureee');
        emit(EditFacilityFailure(message: jsonDecode(data.body)["message"]));
      }
    } on Exception catch (e) {
      print('exception');
      emit(EditFacilityFailure(message: "something is wrong ..."));
    }
  }
}
// class EditFacilityCubit extends Cubit<EditFacilityState> {
//   final List<Facility> facilities;
//   EditFacilityCubit({required this.facilities})
//       : super(EditFacilityInitial(facilities: facilities));
//   void changeFacility({
//     required int id,
//     required String facility_name,
//     required bool enabled,
//     required BuildContext context,
//   }) async {
//     emit(EditFacilityLoading(facilities: facilities));

//     try {
//       String base_url = Api().base_url;
//       final requestBody = {
//         "facilities": [
//           {
//             "facility_id": id,
//             "facility_name": facility_name,
//             "enabled": enabled,
//           },
//         ],
//       };

//       final data = await Api().post(
//         url: '$base_url/editFacility',
//         body: jsonEncode(requestBody),
//         token: prefs!.getString("token"),
//       );

//       if (data.statusCode == 200) {
//         // Update the facility in the list
//         // Update the facility in the list
//         final updatedFacilities = facilities.map((f) {
//           if (f.id == id) {
//             return Facility(
//               id: f.id,
//               facilityName: f.facilityName,
//               enabled: enabled,
//             );
//           }
//           return f;
//         }).toList();

//         emit(EditFacilitySuccess(facilities: updatedFacilities));
//       } else {
//         emit(EditFacilityFailure(
//           facilities: facilities,
//           errorMessage: jsonDecode(data.body)["message"],
//         ));
//       }
//     } on Exception catch (e) {
//       emit(EditFacilityFailure(
//         facilities: facilities,
//         errorMessage: "Something went wrong...",
//       ));
//     }
//   }
// }

//  void ChangeFacility(
//      {required List<Facility> facilities,
//      required int index,
//      required context}) async {
//    emit(EditFacilityLoading());
//    try {
//      String base_url = Api().base_url;
//      final requestBody = {
//        "facilities": facilities
//            .map((facility) => {
//                  "facility_id": facility.id,
//                  "facility_name": facility.facilityName,
//                  "enabled": facility.id == facilities[index].id
//                      ? !facility.enabled
//                      : facility.enabled,
//                })
//            .toList(),
//      };
//      final data = await Api().post(
//        url: '$base_url/editFacility',
//        body: jsonEncode(requestBody),
//        content: 'application/json',
//        token: prefs!.getString("token"),
//      );
//      print('after api');
//      if (data.statusCode == 200) {
//        print('20000000000');
//        BlocProvider.of<ShowFacilityCubit>(context).facilities[index].enabled =
//            !BlocProvider.of<ShowFacilityCubit>(context)
//                .facilities[index]
//                .enabled;
//        print('enabled');
//        emit(EditFacilitySuccess());
//      } else {
//        emit(EditFacilityFailure(message: jsonDecode(data.body)["message"]));
//      }
//    } on Exception catch (e) {
//      emit(EditFacilityFailure(message: "something is wrong ..."));
//    }
//  }


