
import 'dart:convert';
import 'dart:core';
import 'dart:math';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:http/http.dart'as http;
import 'package:meta/meta.dart';
import 'package:reserva/helper/api.dart';
import 'package:reserva/models/admin/dashboard_model.dart';
import 'package:reserva/models/admin/dashboard_model.dart';
import 'package:reserva/models/admin/wallet_model.dart';
import 'package:reserva/pages/admin/Attraction/Attraction_drawer.dart';
import '../../../models/admin/dashboard_model.dart';
part 'dashboard_state.dart';

class DashboardCubit extends Cubit<dashboardState> {
  DashboardCubit() : super(dashboardInitial());

void getAllMydashboard() async {
  try {
    emit(dashboardLoading());

    String base_url = Api().base_url;

    // Fetch last client
    final lastClientFuture = Api().get(url: '$base_url/lastClients');
    final lastClientResponse = await lastClientFuture;
    final lastClient = await _processInfoResponse(lastClientResponse);

    // Fetch last attraction
    final lastAttractionsFuture = Api().get(url: '$base_url/lastAttractions');
    final lastAttractionsResponse = await lastAttractionsFuture;
    final lastAttraction = await _processAttractionResponse(lastAttractionsResponse);

    // Fetch last flight
    final lastFlightsFuture = Api().get(url: '$base_url/lastFlights');
    final lastFlightsResponse = await lastFlightsFuture;
    final lastFlight = await _processFlightResponse(lastFlightsResponse);

    // Fetch last hotel
    final lastHotelsFuture = Api().get(url: '$base_url/lastHotels');
    final lastHotelsResponse = await lastHotelsFuture;
    final lastHotels = await _processHotelResponse(lastHotelsResponse);

    // Fetch new companies
    final newCompaniesFuture = Api().get(url: '$base_url/newCompanies');
    final newCompaniesResponse = await newCompaniesFuture;
    final Companies = await _processNewCompaniesResponse(newCompaniesResponse);

    // Fetch new users
    final newUsersFuture = Api().get(url: '$base_url/newUsers');
    final newUsersResponse = await newUsersFuture;
    final newUsers = await _processNewUsersResponse(newUsersResponse);

    // Fetch total reservations
    final totalReservationsFuture = Api().get(url: '$base_url/totalReservations');
    final totalReservationsResponse = await totalReservationsFuture;
    final totalReservations = await _processTotalReservationsResponse(totalReservationsResponse);

    // Fetch data for other purposes
  //   final TotalincomFuture = await Api().get(url: '$base_url/returnMainTotalEncom');
  // final TotalincomResponse = await totalReservationsFuture;
    // final Totalincom = await _processTotalIncomeResponse(TotalincomResponse);

    // Emit the combined success state
    emit(dashboardSuccess(
  newCompanies: Companies,
  newUsers: newUsers,
  totalReservations: totalReservations,
  client: lastClient,
  Attraction: lastAttraction,
  Flight: lastFlight,
  Hotel: lastHotels,
 // totalincom: Totalincom,
));
  } on Exception catch (e) {
    emit(dashboardFailure(message: "Something went wrong: $e"));
  }
}

Future<List<LastClient>> _processInfoResponse(http.Response response) async {
  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    if (responseData!= null && responseData is List) {
      return (responseData as List).map((e) => LastClient.fromJson(e)).toList();
    } else {
      emit(dashboardEmpty(message: 'Empty response'));
      return [];
    }
  } else {
    emit(dashboardFailure(message: 'Error fetching data'));
    return [];
  }
}

Future<List<LastHotel>> _processHotelResponse(http.Response response) async {
  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    if (responseData != null && responseData is List) {
      return (responseData as List).map((e) => LastHotel.fromJson(e)).toList();
    } else {
      emit(dashboardEmpty(message: 'Empty response for last hotel'));
      return [];
    }
  } else {
    emit(dashboardFailure(message: 'Error fetching last hotel data'));
    return [];
  }
}

Future<List<LastFlight>> _processFlightResponse(http.Response response) async {
  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    if (responseData != null && responseData is List) {
      return (responseData as List).map((e) => LastFlight.fromJson(e)).toList();
    } else {
      emit(dashboardEmpty(message: 'Empty response for last flight'));
      return [];
    }
  } else {
    emit(dashboardFailure(message: 'Error fetching last flight data'));
    return [];
  }
}

Future<List<LastAttraction>> _processAttractionResponse(http.Response response) async {
  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    if (responseData != null && responseData is List) {
      return (responseData as List).map((e) => LastAttraction.fromJson(e)).toList();
    } else {
      emit(dashboardEmpty(message: 'Empty response for last attraction'));
      return [];
    }
  } else {
    emit(dashboardFailure(message: 'Error fetching last attraction data'));
    return [];
  }
}

Future<dynamic> _processNewCompaniesResponse(http.Response response) async {
  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    final newCompanies = NewCompanies.fromJson(responseData);
    return newCompanies;
  } else {
    emit(dashboardFailure(message: 'Error fetching new companies data'));
    return 0;
  }
}

Future<dynamic> _processNewUsersResponse(http.Response response) async {
  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    final newUsers = NewUsers.fromJson(responseData);
    return newUsers;
  } else {
    emit(dashboardFailure(message: 'Error fetching new users data'));
    return 0;
  }
}


Future<dynamic> _processTotalReservationsResponse(http.Response response) async {
  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    final totalReservations = TotalReservations.fromJson(responseData);
    return totalReservations;
  } else {
    emit(dashboardFailure(message: 'Error fetching total reservations data'));
    return 0;
  }
}

Future<dynamic> _processTotalIncomeResponse(http.Response response) async {
  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    final totalIncome = TotalIncome.fromJson(responseData);
    return totalIncome;
  } else {
    emit(dashboardFailure(message: 'Error fetching total income data'));
    return 0;
  }
}
  
    
  
  

// void fetchHomePageData() async {
//   try {
//     emit(dashboardLoading());

//     String base_url = Api().base_url;

//     final lastClientFuture = Api().get(url: '$base_url/lastClients');
//     final lastAttractionsFuture = Api().get(url: '$base_url/lastAttractions');
//     final lastFlightsFuture = Api().get(url: '$base_url/lastFlights');
//     final lastHotelsFuture = Api().get(url: '$base_url/lastHotels');
//     final newCompaniesFuture = Api().get(url: '$base_url/newCompanies');
//     final newUsersFuture = Api().get(url: '$base_url/newUsers');
//     final totalReservationsFuture = Api().get(url: '$base_url/totalReservations');

//     final responses = await Future.wait([
//       lastClientFuture,
//       lastAttractionsFuture,
//       lastFlightsFuture,
//       lastHotelsFuture,
//       newCompaniesFuture,
//       newUsersFuture,
//       totalReservationsFuture,
//     ]);

//     bool allRequestsSuccessful = true; // Flag to track the success of all requests

//     final lastClientdata = responses[0];
//     if (lastClientdata.statusCode == 200) {
//       final lastclientResponseData = jsonDecode(lastClientdata.body);

//       final lastClient = (lastclientResponseData as List)
//           .map((e) => LastClient.fromJson(e))
//           .toList();

//       final lastAttractionsdata = responses[1];
//       if (lastAttractionsdata.statusCode == 200) {
//         final attractionResponseData = jsonDecode(lastAttractionsdata.body);

//         final lastAttraction = (attractionResponseData as List)
//             .map((e) => LastAttraction.fromJson(e))
//             .toList();

//         final lastFlightsdata = responses[2];
//         if (lastFlightsdata.statusCode == 200) {
//           final lastFlightsResponseData = jsonDecode(lastFlightsdata.body);

//           final lastFlight = (lastFlightsResponseData as List)
//               .map((e) => LastFlight.fromJson(e))
//               .toList();

//           final lastHotelsdata = responses[3];
//           if (lastHotelsdata.statusCode == 200) {
//             final lastHotelsResponseData = jsonDecode(lastHotelsdata.body);

//             final lastHotels = (lastHotelsResponseData as List)
//                 .map((e) => LastHotel.fromJson(e))
//                 .toList();

//             final newCompaniesdata = responses[4];
//             if (newCompaniesdata.statusCode == 200) {
//               final newCompaniesdataResponseData = jsonDecode(newCompaniesdata.body);

//               final Companies = NewCompanies.fromJson(newCompaniesdataResponseData);

//               final newUsersdata = responses[5];
//               if (newUsersdata.statusCode == 200) {
//                 final newUsersResponseData = jsonDecode(newUsersdata.body);

//                 final newUsers = NewUsers.fromJson(newUsersResponseData);

//                 final totalReservationsdata = responses[6];
//                 if (totalReservationsdata.statusCode == 200) {
//                   final totalReservationsResponseData = jsonDecode(totalReservationsdata.body);

//                   final totalReservations = TotalReservations.fromJson(totalReservationsResponseData);

//                   if (allRequestsSuccessful) { // Check if all requests were successful
//                     emit(dashboardSuccess(
//                       newCompanies: Companies,
//                       newUsers: newUsers,
//                       totalReservations: totalReservations,
//                       client: lastClient,
//                       Attraction: lastAttraction,
//                       Flight: lastFlight,
//                       Hotel: lastHotels,
//                     ));}
//                   } else {
//                     emit(dashboardFailure(message: 'Error fetching data'));
//                   }
//                 } else {
//                   allRequestsSuccessful = false;
//                   emit(dashboardEmpty(message: 'Error fetching pie chart data'));
//                 }
//               } else {
//                 allRequestsSuccessful = false;
//                 emit(dashboardEmpty(message: 'Error fetching chart table data'));
//               }
//             } else {
//               allRequestsSuccessful = false;
//               emit(dashboardFailure(message: 'Error fetching admin data'));
//             }
//           }
//         }
//       }
//     }
//   catch (e) {
//     emit(dashboardFailure(message: "Something went wrong: $e"));
//   }
// }
// }









      }