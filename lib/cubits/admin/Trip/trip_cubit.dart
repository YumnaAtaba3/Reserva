import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reserva/helper/api.dart';
import 'package:reserva/models/admin/TripDetails.dart';
import 'package:reserva/models/admin/trip.dart';

part 'trip_state.dart';

class TripCubit extends Cubit<TripState> {
  TripCubit() : super(TripInitial());





void showAllTrip() async {
    try {
      emit(TripLoadingState());
      String base_url = Api().base_url;
      final data =
          await Api().get(url: '$base_url/showAllTrips');
            print('.....................Trip ......');
      if (data.statusCode == 200) {
        final responseData = json.decode(data.body);
          print('2000000.......trip.................');
        print('responseData: $responseData');

        if (responseData['status'] == 1) {
          List datamap = jsonDecode(data.body)["data"];

          final TripList =
              List<Trip>.from(datamap.map((e) =>Trip.fromJson(e)));
          emit(TripLoadedState(TripList,responseData['message']));
        } else {
          emit(TripErrorState('There is no  trip to show'));
        }
      } else {
        emit(TripErrorState('There is no  trip to show'));
      }
    } on Exception catch (e) {
        print('Error occurred: $e');
      emit(TripErrorState( "Something went wrong: $e"));
    }
  }


  void deleteTrip(int tripId) async {
    emit(TripLoadingState());

    try {
      String base_url = Api().base_url;

    final response = await Api().get(
      url: '$base_url/deleteTrip/$tripId',
    );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = json.decode(response.body);

        if (responseBody["message"] == "trip is deleted successfully") {
          showAllTrip();
          print('Trip deleted successfully');
          // Perform any additional actions after successful deletion
          emit(TripLoadedState([],responseBody["message"]));
        } else {
          emit(TripErrorState('you can not delete this trip because it has unfinished reservations '));
        }
      } else {
        emit(TripErrorState('Failed to delete Trip'));
      }
    } catch (e) {
      print("Error occurred: $e");
      emit(TripErrorState(''));
    }
  }

bool isSearchActive = false;

void searchTrip(String query) {
  final currentState = state;

  if (query.isEmpty) {
    showAllTrip();
    return;
  }

  final normalizedQuery = query.toLowerCase();

  if (currentState is TripLoadedState) {
    final filteredTrips = currentState.Tripdata.where((trip) {
      final tripName = trip.tripName.toLowerCase();
      final destination = trip.destination.toLowerCase();

      return tripName.contains(normalizedQuery) || destination.contains(normalizedQuery);
    }).toList();

    if (filteredTrips.isEmpty) {
      // Emit the same state to prevent changing the current page content
      emit(TripLoadedState(currentState.Tripdata,''));
      isSearchActive = false;
      return;
    }

    emit(TripLoadedState(filteredTrips,'success search'));
    isSearchActive = true;
  }
}

}




