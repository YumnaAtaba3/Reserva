import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reserva/helper/api.dart';
import 'package:reserva/models/admin/dashboard_model.dart';

part 'lastattraction_state.dart';

class LastattractionCubit extends Cubit<LastattractionState> {
  LastattractionCubit() : super(LastattractionInitial());
      void showlastattractions() async {
    try {
      emit(LastAttractionloading());

      String base_url = Api().base_url;

      final data = await Api().get(url: '$base_url/lastAttractions');
      print('data :${data.body}');
      print("................................................");
    if (data.statusCode == 200) {
      final lastAttractionResponseData = jsonDecode(data.body);

      if (lastAttractionResponseData != null && lastAttractionResponseData is List) {
        final List<LastAttraction> lastAttraction = lastAttractionResponseData.map((e) => LastAttraction.fromJson(e)).toList();
        emit(dashboardSuccessLastAttraction(Attraction:  lastAttraction));
      } else {
        emit(EmptyLastAttraction(message:lastAttractionResponseData['message']));
      }
    } else {
      emit(LastAttractionFailure(message: 'Error fetching last attraction data'));
    }
  } catch (e) {
    emit(LastAttractionFailure(message: "Something went wrong: $e"));
  }
}
}
