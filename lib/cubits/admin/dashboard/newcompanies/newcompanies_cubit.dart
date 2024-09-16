import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reserva/helper/api.dart';
import 'package:reserva/models/admin/dashboard_model.dart';

part 'newcompanies_state.dart';

class NewcompaniesCubit extends Cubit<NewcompaniesState> {
  NewcompaniesCubit() : super(NewcompaniesInitial());
    void shownewcompanies() async {
    try {
      emit(NewcompaniesLoading());

      String base_url = Api().base_url;

      final data = await Api().get(url: '$base_url/newCompanies');
      print('data :${data.body}');
      print("................................................");
      if (data.statusCode == 200) {
        final responseData = jsonDecode(data.body);
      
          final Companies = NewCompanies.fromJson(responseData );
              
          emit(dashboardSuccessNewCompanies(newCompanies: Companies));
      } else {
        emit(NewcompaniesFailure(message: 'Error fetching new companies data'));
      }
    } on Exception catch (e) {
      emit(NewcompaniesFailure(message: "Something went wrong: $e"));
    }
  }
}
