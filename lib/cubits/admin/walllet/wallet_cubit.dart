import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reserva/helper/api.dart';
import 'package:reserva/models/admin/service.dart';
import 'package:reserva/models/admin/wallet_model.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit() : super(WalletInitial());
    void getIncome() async {
    try {
      emit(WalletLoading());
          TotalIncome? income;
      String base_url = Api().base_url;
      final data = await Api().get(url: '$base_url/returnMainTotalEncom');
        
      if (data.statusCode == 200) {
        print("incom200");
        final responseData = jsonDecode(data.body);
        // print(responseData.toString());
          income = TotalIncome.fromJson(responseData);

        emit(WalletCardSuccess(card: income));
      } else {
        final errorMessage = 'Error ${data.statusCode}: ${data.reasonPhrase}';
        emit(WalletFailure(message: errorMessage));
      }
    } on Exception catch (e) {
      emit(WalletFailure(message: "Something went wrong: $e"));
    }
  }
      void getFlightsFinancial() async {
    try {
      emit(WalletLoading());
      String base_url = Api().base_url;
      final data = await Api().get(url: '$base_url/returnFlightsFinancial');

      if (data.statusCode == 200) {
         print("incom200....................");
        final responseData = jsonDecode(data.body);
        // print(responseData.toString());
        final flightincom = FlightsFinancialReturn.fromJson(responseData);

        emit( WalletFlightsFinancialReturnSuccess (card4: flightincom));
      } else {
        final errorMessage = 'Error ${data.statusCode}: ${data.reasonPhrase}';
        emit(WalletFailure(message: errorMessage));
      }
    } on Exception catch (e) {
      emit(WalletFailure(message: "Something went wrong: $e"));
    }
  }
    void getHotelsFinancial() async {
    try {
      emit(WalletLoading());
      String base_url = Api().base_url;
      final data = await Api().get(url: '$base_url/returnHotelsFinancial');
 print("incom20.......................0");
      if (data.statusCode == 200) {
        final responseData = jsonDecode(data.body);
        // print(responseData.toString());
        final flightincom = HotelsFinancialReturn.fromJson(responseData);

        emit( WalletHotelsFinancialReturnSuccess (card3: flightincom));
      } else {
        final errorMessage = 'Error ${data.statusCode}: ${data.reasonPhrase}';
        emit(WalletFailure(message: errorMessage));
      }
    } on Exception catch (e) {
      emit(WalletFailure(message: "Something went wrong: $e"));
    }
  }

   void getreturnTripsFinancial() async {
    try {
      emit(WalletLoading());
      String base_url = Api().base_url;
      final data = await Api().get(url: '$base_url/returnTripsFinancial');
 print("incom20.....................................................................0");
      if (data.statusCode == 200) {
        final responseData = jsonDecode(data.body);
        // print(responseData.toString());
        final flightincom = TripsFinancialReturn.fromJson(responseData);

        emit( WalletTripsFinancialReturnSuccess (card2: flightincom));
      } else {
        final errorMessage = 'Error ${data.statusCode}: ${data.reasonPhrase}';
        emit(WalletFailure(message: errorMessage));
      }
    } on Exception catch (e) {
      emit(WalletFailure(message: "Something went wrong: $e"));
    }
  }
    void getActiv() async {
    try {
      emit(WalletLoading());
      String base_url = Api().base_url;
      final data = await Api().get(url: '$base_url/showMainActivities');
      if (data.statusCode == 200) {
        print('2000000............0');
        final responseData = jsonDecode(data.body);
        print('after decodeeeee');
        if (responseData.isEmpty) {
          // No hotel information available
          emit(WalletEmpty(message: 'Empty'));
        } else if (responseData is List) {
          final activList =
              (responseData as List).map((e) => Activity.fromJson(e)).toList();
          emit(WalletActivitySuccess(activ: activList));
        } else {
          // Unexpected data format
          emit(WalletFailure(message: 'Unexpected data format'));
        }
      } else {
        emit(WalletFailure(message: 'Error fetching admin data'));
      }
    } on Exception catch (e) {
      emit(WalletFailure(message: "Something went wrong: $e"));
    }
  }

   void getLine() async {
    try {
      emit(WalletLoading());
      String base_url = Api().base_url;
      final data = await Api().get(url: '$base_url/lineMainChart');
      if (data.statusCode == 200) {
        print('20000mmmmmmmmmm000');
        final responseData = jsonDecode(data.body);
        print('after decodeeeee');
        if (responseData.isEmpty) {
          // No hotel information available
          print('emptyyyyyy');
          emit(WalletEmpty(message: 'Empty'));
        } else if (responseData is List) {
          final lineList =
              (responseData as List).map((e) => DataPoint.fromJson(e)).toList();
          emit(WalletLineChartSuccess(line: lineList));
        } else {
          // Unexpected data format
          emit(WalletFailure(message: 'Unexpected data format'));
        }
      } else {
        emit(WalletFailure(message: 'Error fetching admin data'));
      }
    } on Exception catch (e) {
      emit(WalletFailure(message: "Something went wrong: $e"));
    }
  }

void getWalletData() async {
  try {
    emit(WalletLoading());

    String base_url = Api().base_url;

    // Fetch total income
    final incomeResponse = await Api().get(url: '$base_url/returnMainTotalEncom');
    print(incomeResponse.body);
    TotalIncome? income;
    if (incomeResponse.statusCode == 200) {
      final incomeData = jsonDecode(incomeResponse.body);
      income = TotalIncome.fromJson(incomeData);
      print(income);
    } else {
      emit(WalletFailure(message: 'Error fetching total income.'));
      return;
    }

    // Fetch Trips income
    final tripsincomeResponse = await Api().get(url: '$base_url/returnTripsFinancial');
    print(tripsincomeResponse.body);
    TripsFinancialReturn? tripsincome;
    if (tripsincomeResponse.statusCode == 200) {
      final tripsincomeData = jsonDecode(tripsincomeResponse.body);
      tripsincome = TripsFinancialReturn.fromJson(tripsincomeData);
      print(tripsincome);
    } else {
      emit(WalletFailure(message: 'Error fetching Trips income.'));
      return;
    }

    // Fetch Hotels income
    final hotelsincomeResponse = await Api().get(url: '$base_url/returnHotelsFinancial');
    print(hotelsincomeResponse.body);
    HotelsFinancialReturn? hotelincome;
    if (hotelsincomeResponse.statusCode == 200) {
      final hotelincomeData = jsonDecode(hotelsincomeResponse.body);
      hotelincome = HotelsFinancialReturn.fromJson(hotelincomeData);
      print(hotelincome);
    } else {
      emit(WalletFailure(message: 'Error fetching Hotels income.'));
      return;
    }

    // Fetch Flights income
    final flightincomeResponse = await Api().get(url: '$base_url/returnFlightsFinancial');
    print(flightincomeResponse.body);
    FlightsFinancialReturn? flightincome;
    if (flightincomeResponse.statusCode == 200) {
      final flightincomeData = jsonDecode(flightincomeResponse.body);
      flightincome = FlightsFinancialReturn.fromJson(flightincomeData);
      print(flightincome);
    } else {
      emit(WalletFailure(message: 'Error fetching Flights income.'));
      return;
    }

    // Fetch activities
    final activitiesResponse = await Api().get(url: '$base_url/showMainActivities');
    List<Activity>? activities;
    if (activitiesResponse.statusCode == 200) {
      final activitiesData = jsonDecode(activitiesResponse.body);
      if (activitiesData.isEmpty) {
        emit(WalletEmpty(message: 'No activities found.'));
        return;
      }
      activities = (activitiesData as List).map((e) => Activity.fromJson(e)).toList();
    } else {
      emit(WalletFailure(message: 'Error fetching activities.'));
      return;
    }

    // Fetch line chart data
    final lineChartResponse = await Api().get(url: '$base_url/lineMainChart');
    List<DataPoint>? lines;
    if (lineChartResponse.statusCode == 200) {
      final lineChartData = jsonDecode(lineChartResponse.body);
      if (lineChartData.isEmpty) {
        emit(WalletEmpty(message: 'No line chart data available.'));
        return;
      }
      lines = (lineChartData as List).map((e) => DataPoint.fromJson(e)).toList();
    } else {
      emit(WalletFailure(message: 'Error fetching line chart data.'));
      return;
    }

    // Emit the WalletSuccess state
    emit(WalletSuccess(
      card1: income,
      card2: tripsincome,
      card3: hotelincome,
      card4: flightincome,
      activ: activities,
      line: lines,
    ));
  } on Exception catch (e) {
    print('error:$e');
    emit(WalletFailure(message: "Something went wrong: $e"));
  }
}

// void getWalletData() async {
//   try {
//     emit(WalletLoading());

//     String base_url = Api().base_url;

//     final responses = await Future.wait([
//       Api().get(url: '$base_url/returnMainTotalEncom'),
//       Api().get(url: '$base_url/returnTripsFinancial'),
//       Api().get(url: '$base_url/returnHotelsFinancial'),
//       Api().get(url: '$base_url/returnFlightsFinancial'),
//       Api().get(url: '$base_url/showMainActivities'),
//       Api().get(url: '$base_url/lineMainChart'),
//     ]);

//     bool allRequestsSuccessful = true;

//     TotalIncome? income;
//     TripsFinancialReturn? tripsincome;
//     HotelsFinancialReturn? hotelincome;
//     FlightsFinancialReturn? flightincome;
//     List<Activity>? activities;
//     List<DataPoint>? lines;

//     for (int i = 0; i < responses.length; i++) {
//       final response = responses[i];
      
//       if (response.statusCode != 200) {
//         // Update allRequestsSuccessful to false if any request fails
//         allRequestsSuccessful = false;
//         emit(WalletFailure(message: 'Error fetching data.'));
//         return;
//       }

//       final responseData = jsonDecode(response.body);

//       switch (i) {
//         case 0:
//           income = TotalIncome.fromJson(responseData);
//           break;
//         case 1:
//           tripsincome = TripsFinancialReturn.fromJson(responseData);
//           break;
//         case 2:
//           hotelincome = HotelsFinancialReturn.fromJson(responseData);
//           break;
//         case 3:
//           flightincome = FlightsFinancialReturn.fromJson(responseData);
//           break;
//         case 4:
//           activities = (responseData as List).map((e) => Activity.fromJson(e)).toList();
//           break;
//         case 5:
//           lines = (responseData as List).map((e) => DataPoint.fromJson(e)).toList();
//           break;
//       }
//     }

//     if (allRequestsSuccessful) {
//       emit(WalletSuccess(
//         card1: income!,
//         card2: tripsincome!,
//         card3: hotelincome!,
//         card4: flightincome!,
//         activ: activities!,
//         line: lines!,
//       ));
//     } else {
//       emit(WalletFailure(message: 'Error fetching data.'));
//     }

//   } catch (e) {
//     print(e.runtimeType);
//     emit(WalletFailure(message: "Something went wrong: $e"));
//   }
// }

// void getWalletData() async {
//   try {
//     emit(WalletLoading());

//     String base_url = Api().base_url;

//     final responses = await Future.wait([
//       Api().get(url: '$base_url/returnMainTotalEncom'),
//       Api().get(url: '$base_url/returnTripsFinancial'),
//       Api().get(url: '$base_url/returnHotelsFinancial'),
//       Api().get(url: '$base_url/returnFlightsFinancial'),
//       Api().get(url: '$base_url/showMainActivities'),
//       Api().get(url: '$base_url/lineMainChart'),
//     ]);

//     bool allRequestsSuccessful = true;

//     TotalIncome? income;
//     TripsFinancialReturn? tripsincome;
//     HotelsFinancialReturn? hotelincome;
//     FlightsFinancialReturn? flightincome;
//     List<Activity>? activities;
//     List<DataPoint>? lines;

//     for (int i = 0; i < responses.length; i++) {
//       final response = responses[i];
      
//       if (response.statusCode != 200) {
//         // Update allRequestsSuccessful to false if any request fails
//         allRequestsSuccessful = false;
//         emit(WalletFailure(message: 'Error fetching data.'));
//         return;
//       }

//       final responseData = jsonDecode(response.body);

//       switch (i) {
//         case 0:
//           income = TotalIncome.fromJson(responseData);
//           break;
//         case 1:
//           tripsincome = TripsFinancialReturn.fromJson(responseData);
//           break;
//         case 2:
//           hotelincome = HotelsFinancialReturn.fromJson(responseData);
//           break;
//         case 3:
//           flightincome = FlightsFinancialReturn.fromJson(responseData);
//           break;
//         case 4:
//           activities = (responseData as List).map((e) => Activity.fromJson(e)).toList();
//           break;
//         case 5:
//           lines = (responseData as List).map((e) => DataPoint.fromJson(e)).toList();
//           break;
//       }
//     }

//     if (allRequestsSuccessful) {
//       emit(WalletSuccess(
//         card1: income ?? TotalIncome(), // Use null check operator to provide a default value
//         card2: tripsincome ?? TripsFinancialReturn(), 
//         card3: hotelincome ?? HotelsFinancialReturn(),
//         card4: flightincome ?? 0,
//         activ: activities ?? [],
//         line: lines ?? [],
//       ));
//     } else {
//       emit(WalletFailure(message: 'Error fetching data.'));
//     }

//   } catch (e, stackTrace) {
//     print('Error: $e');
//     print('Stack trace: $stackTrace');
//     emit(WalletFailure(message: "Something went wrong: $e"));
//   }
// }
}

  
