import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reserva/constants.dart';
import 'package:reserva/cubits/shared/auth/reset_password/cubit/reset_password_state.dart';
import 'package:reserva/helper/api.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  bool is_scure1 = true;
  bool is_scure2 = true;

  void changeVisibility1() {
    is_scure1 = !is_scure1;
    if (is_scure1)
      emit(ResetPasswordSecure());
    else
      emit(ResetPasswordInSecure());
  }

  void changeVisibility2() {
    is_scure2 = !is_scure2;
    if (is_scure2)
      emit(ResetPasswordSecure());
    else
      emit(ResetPasswordInSecure());
  }

  ResetPasswordCubit() : super(ResetPasswordInitial());
  void reset_password({
    required String password,
    required String password_confirmation,
    String? code,
    //String? stored_verify_code,
  }) async {
    emit(ResetPasswordLoading());
    try {
      print("before api request!!");

      String base_url = Api().base_url;
      final data = await Api().post(
          url: "$base_url/userResetPassword",
          body: {
            //'stored_verify_code': stored_verify_code,
            'code': code,
            'password': password,
            'password_confirmation': password_confirmation
          },
          token: null);
      print("token");
      inspect(data);
      print("after api request!!");
      print(data.body.toString());

      if (data.statusCode == 200) {
        print('200');
        //prefs?.setInt('role', jsonDecode(data.body)['role']);
        //print(jsonDecode(data.body)['role']);
        final role = jsonDecode(data.body)['data']['role'];

        print(role);
        prefs?.setString('token', jsonDecode(data.body)['data']['token']);
        print(jsonDecode(data.body)['data']['token']);
        emit(ResetPasswordSuccess(message: 'successs', role: role));
      } else if (data.statusCode == 422) {
        print('4222222');
        var errors =
            Map<String, List<dynamic>>.from(jsonDecode(data.body)["errors"]);
        emit(ResetPasswordValidationFailure(errors: errors));
      } else {
        print('5000000000');
        emit(ResetPasswordFailure(message: jsonDecode(data.body)["message"]));
      }
    } on Exception catch (e) {
      print(e.toString());
      emit(ResetPasswordFailure(message: "there is something wrong.."));
    }
  }
}
