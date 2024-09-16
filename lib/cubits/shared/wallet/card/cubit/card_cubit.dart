import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:reserva/cubits/shared/wallet/card/cubit/card_state.dart';
import 'package:reserva/helper/api.dart';
import 'package:reserva/models/comany_owner/wallet.dart';

class CardCubit extends Cubit<CardState> {
  CardCubit() : super(CardInitial());

  void getIncome() async {
    try {
      emit(CardLoading());
      String base_url = Api().base_url;
      final data = await Api().get(url: '$base_url/returnTotalEncom');

      if (data.statusCode == 200) {
        final responseData = jsonDecode(data.body);
        // print(responseData.toString());
        final income = TotalIncome.fromJson(responseData);

        emit(CardSuccess(card: income));
      } else {
        final errorMessage = 'Error ${data.statusCode}: ${data.reasonPhrase}';
        emit(CardFailure(message: errorMessage));
      }
    } on Exception catch (e) {
      emit(CardFailure(message: "Something went wrong: $e"));
    }
  }
}
