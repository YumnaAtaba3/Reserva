import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reserva/cubits/shared/wallet/line/cubit/line_state.dart';

import 'package:reserva/helper/api.dart';
import 'package:reserva/models/comany_owner/wallet.dart';

class LineCubit extends Cubit<LineState> {
  LineCubit() : super(LineInitial());

  void getLine() async {
    try {
      emit(LineLoading());
      String base_url = Api().base_url;
      final data = await Api().get(url: '$base_url/lineChart');
      if (data.statusCode == 200) {
        print('20000000');
        final responseData = jsonDecode(data.body);
        print('after decodeeeee');
        if (responseData.isEmpty) {
          // No hotel information available
          print('emptyyyyyy');
          emit(LineEmpty(message: 'Empty'));
        } else if (responseData is List) {
          final lineList =
              (responseData as List).map((e) => Line.fromJson(e)).toList();
          emit(LineSuccess(line: lineList));
        } else {
          // Unexpected data format
          emit(LineFailure(message: 'Unexpected data format'));
        }
      } else {
        emit(LineFailure(message: 'Error fetching admin data'));
      }
    } on Exception catch (e) {
      emit(LineFailure(message: "Something went wrong: $e"));
    }
  }
}
