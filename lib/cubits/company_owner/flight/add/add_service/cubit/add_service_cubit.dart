import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:reserva/constants.dart';
import 'package:reserva/cubits/company_owner/flight/add/add_service/cubit/add_service_state.dart';
import 'package:reserva/helper/api.dart';

class AddServiceCubit extends Cubit<AddServiceState> {
  AddServiceCubit() : super(AddServiceInitial());
  Future<void> AddService({
    required String service_name,
  }) async {
    emit(AddServiceLoading());
    try {
      print("before api request!!");

      String base_url = Api().base_url;
      final data = await Api().post(
          url: "$base_url/addNewService",
          body: {
            'service_name': service_name,
          },
          // content: 'application/json',
          token: prefs!.getString("token"));
      print("token");
      inspect(data);
      print("after api request!!");
      print(data.body.toString());

      if (data.statusCode == 200) {
        emit(AddServiceSuccess(message: jsonDecode(data.body)["message"]));
      } else if (data.statusCode == 422) {
        emit(AddServiceFailure(message: jsonDecode(data.body)["message"]));
      } else {
        emit(AddServiceFailure(message: jsonDecode(data.body)["message"]));
      }
    } on Exception catch (e) {
      print(e.toString());
      emit(AddServiceFailure(message: "there is something wrong.."));
    }
  }
}
