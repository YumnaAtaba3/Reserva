import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reserva/helper/api.dart';
import 'package:reserva/models/admin/dashboard_model.dart';

part 'lastclient_state.dart';

class LastclientCubit extends Cubit<LastclientState> {
  LastclientCubit() : super(LastclientInitial());
  
void showlastClients() async {
  try {
    emit(LastClientloading());

    String base_url = Api().base_url;

    final data = await Api().get(url: '$base_url/lastClients');
    print('data :${data.body}');
    print("................................................");

    if (data.statusCode == 200) {
      final lastclientResponseData = jsonDecode(data.body);

      if (lastclientResponseData != null && lastclientResponseData is List) {
        final List<LastClient> lastClients = lastclientResponseData.map((e) => LastClient.fromJson(e)).toList();
        emit(dashboardSuccessLastClient(client: lastClients));
      } else {
        emit(EmptyLastClient(message:lastclientResponseData ['message']));
      }
    } else {
      emit(LastClientFailure(message: 'Error fetching last client data'));
    }
  } catch (e) {
    emit(LastClientFailure(message: "Something went wrong: $e"));
  }
}
}
