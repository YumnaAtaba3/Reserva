import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:reserva/helper/api.dart';
import 'package:reserva/models/admin/user_page_model.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersInitial());
    void getUsers() async {
    emit(UsersLoadingState());

    try {
      String base_url = Api().base_url;

      final response =
          await Api().get(url: '$base_url/showAllUsers');
              print('.........................');
              print(response.body);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
            print('2000000.........................');
        if (jsonResponse['status'] == 1) {
          if(jsonResponse['data'].isEmpty){
            print('empty user');
            emit(UsersEmpty(jsonResponse['message']));
          }
          final usersData = jsonResponse['data'] as List<dynamic>;
          final users = usersData
              .map((userData) => User(
                      id:userData['id'],
                    name: userData['name'],
                    email: userData['email'],
                    phone: userData['phone'],
                    gender: userData['gender'],
                  ))
              .toList();
          emit(UsersLoadedState(users,jsonResponse['message']));
        } else {
          emit(UsersErrorState(jsonResponse['message']));
        }
      } else {
        emit(UsersErrorState('Failed to fetch users'));
      }
    } catch (e) {
      emit(UsersErrorState('An error occurred'));
    }
  }
void deleteUsers(int Clientid) async {
  emit(UsersLoadingState());

  try {
    String base_url = Api().base_url;

    final response = await Api().get(
      url: '$base_url/deleteClient/$Clientid',
    );

    print('Response body: ${response.body}');
    print('Before delete');

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse['status'] == 1) {
        print('Delete user successful');
        getUsers(); 
        emit(UsersLoadedState([],jsonResponse['message']));
      } else {
        emit(UsersErrorState(jsonResponse['message']));
      }
    } else {
      emit(UsersErrorState('Failed to delete user'));
    }
  } catch (e) {
    emit(UsersErrorState('An error occurred: $e'));
  }
}
}
