import 'dart:convert';
import 'dart:io';

import 'package:reserva/helper/api.dart';
import 'package:reserva/models/user_model.dart';

class loginServices {
  Future<User> login({
    required String name,
    required String password,
  }) async {
    final data = await Api().post(
      url: "http://127.0.0.1:8000/api/auth/login",
      body: {
        'name': name,
        'password': password,
      },
    );
    print(data);
    print("--------------------------------------------------------------");
    print(jsonDecode(data.body)['data']);
    print("hellosssssssssssssssssss");
    User user = User.fromjson(jsonDecode(data.body)['data']);
    print(user.name);
    return user;
  }
}
