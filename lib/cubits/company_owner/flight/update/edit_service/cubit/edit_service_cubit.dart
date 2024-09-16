import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/constants.dart';
import 'package:reserva/cubits/company_owner/flight/show/show_service/cubit/show_service_cubit.dart';
import 'package:reserva/cubits/company_owner/flight/update/edit_service/cubit/edit_service_state.dart';
import 'package:reserva/cubits/company_owner/hotel/update/edit_facility/cubit/edit_facility_state.dart';

import 'package:reserva/helper/api.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

class EditServiceCubit extends Cubit<EditServiceState> {
  EditServiceCubit() : super(EditServiceInitial());

  void ChangeService(
      {required int id,
      required String service_name,
      required bool enabled,
      required context}) async {
    emit(EditServiceLoading());
    try {
      String base_url = Api().base_url;

      final requestBody = {
        "services": [
          {
            "service_id": id,
            "service_name": service_name,
            "enabled": enabled,
          },
        ],
      };
      // final request = {requestBody};
      // Make the API request
      final data = await Api().post(
          url: '$base_url/editService',
          body: jsonEncode(requestBody),
          content: 'application/json',
          token: prefs!.getString("token"));
      print(data.body.toString());
      if (data.statusCode == 200) {
        print('222222220');
        BlocProvider.of<ShowServiceCubit>(context)
                .services
                .firstWhere((element) => element.id == id)
                .enabled !=
            enabled;
        print('afterrrrrrr');
        emit(EditServiceSuccess());
      } else {
        print('failureee');
        emit(EditServiceFailure(message: jsonDecode(data.body)["message"]));
      }
    } on Exception catch (e) {
      print('exception');
      emit(EditServiceFailure(message: "something is wrong ..."));
    }
  }
}
