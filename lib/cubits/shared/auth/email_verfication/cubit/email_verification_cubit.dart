import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reserva/constants.dart';
import 'package:reserva/cubits/shared/auth/email_verfication/cubit/email_verification_state.dart';
import 'package:reserva/helper/api.dart';

class EmailVerificationCubit extends Cubit<EmailVerificationState> {
  EmailVerificationCubit() : super(EmailVerificationInitial());

  void email_verification({
    required String email,
  }) async {
    emit(EmailVerificationLoading());
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
        final role_email = jsonDecode(data.body)['data']['role'];
        prefs?.setInt('role_email', jsonDecode(data.body)['data']['role']);
        print(role_email);

        emit(EmailVerificationSuccess(
            message: jsonDecode(data.body)["message"], role_email: role_email));
      } else if (data.statusCode == 422) {
        var errors =
            Map<String, List<dynamic>>.from(jsonDecode(data.body)["errors"]);
        emit(EmailVerificationValidationFailure(errors: errors));
      } else {
        emit(EmailVerificationFailure(
            message: jsonDecode(data.body)["message"]));
      }
    } on Exception catch (e) {
      print(e.toString());
      emit(EmailVerificationFailure(message: "there is something wrong.."));
    }
  }
}
