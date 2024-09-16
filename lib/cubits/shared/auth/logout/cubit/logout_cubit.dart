import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reserva/cubits/shared/auth/logout/cubit/logout_state.dart';
import 'package:reserva/helper/api.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());
  void logout() async {
    try {
      emit(LogoutLoading());

      String base_url = Api().base_url;
      final data = await Api().get(url: '$base_url/logout');
      print(data.body.toString());
      if (data.statusCode == 200) {
        print('2000000000');

        emit(LogoutSuccess(message: jsonDecode(data.body)["message"]));
      } else {
        emit(LogoutFailure(message: jsonDecode(data.body)["message"]));
      }
    } on Exception catch (e) {
      emit(LogoutFailure(message: "something is wrong ..."));
    }
  }
}
