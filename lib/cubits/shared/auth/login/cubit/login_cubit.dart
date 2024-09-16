// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:reserva/constants.dart';
import 'package:reserva/cubits/shared/auth/login/cubit/login_state.dart';
import 'package:reserva/helper/api.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<LoginState> {
  bool is_scure = true;

  LoginCubit() : super(LoginInitial());

  void changeVisibility() {
    is_scure = !is_scure;
    if (is_scure)
      emit(LoginSecure());
    else
      emit(LoginInSecure());
  }

  void login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      print("before api request!!");

      String base_url = Api().base_url;
      final data = await Api().post(
          url: "$base_url/signin",
          body: {
            'email': email,
            'password': password,
          },
          token: null);
      print("token");
      inspect(data);
      print("after api request!!");
      print(data.body.toString());

      if (data.statusCode == 200) {
        prefs?.setString('token', jsonDecode(data.body)['data']['token']);
        print(jsonDecode(data.body)['data']['token']);
        prefs?.setInt('role_id',
            jsonDecode(data.body)['data']['roles']['pivot']['role_id']);

        final role_id =
            jsonDecode(data.body)['data']['roles']['pivot']['role_id'];
        print(role_id);
        emit(LoginSuccess(
            message: jsonDecode(data.body)["message"], role_id: role_id));
      } else if (data.statusCode == 422) {
        var errors =
            Map<String, List<dynamic>>.from(jsonDecode(data.body)["errors"]);
        emit(LoginValidationFailure(errors: errors));
      } else {
        emit(LoginFailure(message: jsonDecode(data.body)["message"]));
      }
    } on Exception catch (e) {
      print(e.toString());
      emit(LoginFailure(message: "there is something wrong.."));
    }
  }
}
