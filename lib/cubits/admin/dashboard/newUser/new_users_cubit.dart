import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reserva/helper/api.dart';
import 'package:reserva/models/admin/dashboard_model.dart';

part 'new_users_state.dart';

class NewUsersCubit extends Cubit<NewUsersState> {
  NewUsersCubit() : super(NewUsersInitial());
   void shownewuser() async {
    try {
      emit(NewUsersLoading());

      String base_url = Api().base_url;

      final data = await Api().get(url: '$base_url/newUsers');
      print('data :${data.body}');
      print("................................................");
      if (data.statusCode == 200) {
        final responseData = jsonDecode(data.body);

        final user = NewUsers.fromJson(responseData);
        emit(dashboardSuccessNewUsers(newUsers: user));
      } else {
        emit(NewUsersFailure(message: 'Error fetching new user data'));
      }
    } on Exception catch (e) {
      emit(NewUsersFailure(message: "Something went wrong: $e"));
    }
  }

}
