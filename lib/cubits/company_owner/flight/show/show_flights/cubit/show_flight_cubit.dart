import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reserva/constants.dart';
import 'package:reserva/cubits/company_owner/flight/show/show_flights/cubit/show_flight_state.dart';
import 'package:reserva/helper/api.dart';
import 'package:reserva/models/comany_owner/flight/my_flight.dart';

class ShowFlightCubit extends Cubit<ShowFlightState> {
  ShowFlightCubit() : super(ShowFlightInitial());
  List<Flight>? flights;
  void showFlights() async {
    try {
      emit(ShowFlightLoading());
      String base_url = Api().base_url;
      final data = await Api().get(url: '$base_url/showAllFlightWithItTime');
      if (data.statusCode == 200) {
        final responseData = json.decode(data.body);
        print('responseData: $responseData');

        if (responseData['status'] == 1) {
          if (responseData['data'].isEmpty) {
            print('flightemptyyyyyy');
            emit(ShowFlightEmpty(message: 'empty'));
          } else {
            print('1111111111');
            List datamap = jsonDecode(data.body)["data"]["flights"];
            print('dataaaaaaamap');
            flights = List<Flight>.from(datamap.map((e) => Flight.fromJson(e)));
            print('listttttttttt');
            emit(ShowFlightSuccess(flights: flights!));
          }
        } else {
          emit(ShowFlightEmpty(message: responseData['message']));
        }
      } else {
        emit(ShowFlightFailure(message: 'Error fetching admin data'));
      }
    } on Exception catch (e) {
      emit(ShowFlightFailure(message: "Something went wrong: $e"));
    }
  }

  void deleteAllFlights() async {
    try {
      emit(ShowFlightLoading());

      String base_url = Api().base_url;
      final data = await Api().get(
          url: '$base_url/deleteAllFlight', token: prefs!.getString('token'));
      print(data.body.toString());
      if (data.statusCode == 200) {
        showFlights();
      } else if (data.statusCode == 404) {
        emit(ShowFlightEmpty(message: 'empty'));
      } else {
        emit(ShowFlightFailure(message: jsonDecode(data.body)["message"]));
      }
    } on Exception catch (e) {
      emit(ShowFlightFailure(message: "something is wrong ..."));
    }
  }

  void deleteFlight({String? id}) async {
    try {
      emit(ShowFlightLoading());

      String base_url = Api().base_url;
      final data = await Api().get(
          url: '$base_url/deleteFlight/$id', token: prefs!.getString('token'));
      print(data.body.toString());
      if (data.statusCode == 200) {
        showFlights();
      } else if (data.statusCode == 404) {
        emit(ShowFlightEmpty(message: 'empty'));
      } else {
        emit(ShowFlightFailure(message: jsonDecode(data.body)["message"]));
      }
    } on Exception catch (e) {
      emit(ShowFlightFailure(message: "something is wrong ..."));
    }
  }

  void deleteFlightTime({String? id}) async {
    try {
      emit(ShowFlightLoading());

      String base_url = Api().base_url;
      final data = await Api().get(
          url: '$base_url/deleteFlightTime/$id',
          token: prefs!.getString('token'));
      print(data.body.toString());
      if (data.statusCode == 200) {
        showFlights();
      } else if (data.statusCode == 404) {
        emit(ShowFlightEmpty(message: 'empty'));
      } else {
        emit(ShowFlightFailure(message: jsonDecode(data.body)["message"]));
      }
    } on Exception catch (e) {
      emit(ShowFlightFailure(message: "something is wrong ..."));
    }
  }
}
