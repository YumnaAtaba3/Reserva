import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reserva/helper/api.dart';
import 'package:reserva/models/admin/dashboard_model.dart';

part 'lasthotel_state.dart';

class LasthotelCubit extends Cubit<LasthotelState> {
  LasthotelCubit() : super(LasthotelInitial());
       void showlastHotel() async {
    try {
      emit(LastHotelloading());

      String base_url = Api().base_url;

      final data = await Api().get(url: '$base_url/lastHotels');
  print('data :${data.body}');
      print("................................................");
       if (data.statusCode == 200) {
      final lasthotelResponseData = jsonDecode(data.body);

      if (lasthotelResponseData != null && lasthotelResponseData is List) {
        final List<LastHotel> lasthotel = lasthotelResponseData.map((e) => LastHotel.fromJson(e)).toList();
        emit(dashboardSuccessLastHotel(Hotel:    lasthotel));
      } else {
        emit(EmptyLastHotel(message:lasthotelResponseData['message']));
      }
    } else {
      emit(LastHotelFailure(message: 'Error fetching last hotel data'));
    }
  } catch (e) {
    emit(LastHotelFailure(message: "Something went wrong: $e"));
  }
}
}
