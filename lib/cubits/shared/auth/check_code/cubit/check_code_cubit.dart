import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reserva/constants.dart';
import 'package:reserva/cubits/shared/auth/check_code/cubit/check_code_state.dart';
import 'package:reserva/helper/api.dart';

class CheckCodeCubit extends Cubit<CheckCodeState> {
  CheckCodeCubit() : super(CheckCodeInitial());

  void check_code({
    required String code,
  }) async {
    emit(CheckCodeLoading());
    try {
      print("before api request!!");

      String base_url = Api().base_url;
      final data = await Api().post(
          url: "$base_url/userCheckCode",
          body: {
            'code': code,
          },
          token: null);
      print("token");
      inspect(data);
      print("after api request!!");
      print(data.body.toString());

      if (data.statusCode == 200) {
        // prefs?.setString('token', jsonDecode(data.body)['data']['token']);
        // print(jsonDecode(data.body)['data']['token'])
        prefs?.setString('data', jsonDecode(data.body)['data']['code']);
        prefs?.setString('token', jsonDecode(data.body)['data']['token']);
        print(jsonDecode(data.body)['data']['token']);

        emit(CheckCodeSuccess(message: jsonDecode(data.body)["message"]));
      } else if (data.statusCode == 422) {
        var errors =
            Map<String, List<dynamic>>.from(jsonDecode(data.body)["errors"]);
        emit(CheckCodeValidationFailure(errors: errors));
      } else {
        emit(CheckCodeFailure(message: jsonDecode(data.body)["message"]));
      }
    } on Exception catch (e) {
      print(e.toString());
      emit(CheckCodeFailure(message: "there is something wrong.."));
    }
  }

  void email_verification({
    required String email,
  }) async {
    emit(CheckCodeLoading());
    try {
      print("before api request!!");

      String base_url = Api().base_url;
      final data = await Api().post(
          url: "$base_url/userForgotPassword",
          body: {
            'email': email,
          },
          token: null);
      print("token");
      inspect(data);
      print("after api request!!");
      print(data.body.toString());

      if (data.statusCode == 200) {
        print('danaaaaa');
        prefs?.setString('email', jsonDecode(data.body)['data']['email']);
        print(jsonDecode(data.body)['data']['email']);

        final code = jsonDecode(data.body)['data']['code'];
        print(code);
        emit(CheckCodeResend(message: jsonDecode(data.body)["message"]));
      } else if (data.statusCode == 422) {
        var errors =
            Map<String, List<dynamic>>.from(jsonDecode(data.body)["errors"]);
        emit(CheckCodeValidationFailure(errors: errors));
      } else {
        emit(CheckCodeFailure(message: jsonDecode(data.body)["message"]));
      }
    } on Exception catch (e) {
      print(e.toString());
      emit(CheckCodeFailure(message: "there is something wrong.."));
    }
  }
}
