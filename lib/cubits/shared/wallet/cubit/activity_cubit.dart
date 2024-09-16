import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reserva/cubits/shared/wallet/cubit/activity_state.dart';

import 'package:reserva/helper/api.dart';
import 'package:reserva/models/comany_owner/wallet.dart';

class ActivityCubit extends Cubit<ActivityState> {
  ActivityCubit() : super(ActivityInitial());

  // void getIncome() async {
  //   try {
  //     emit(ActivityLoading());
  //     String base_url = Api().base_url;
  //     final data = await Api().get(url: '$base_url/returnTotalEncom');

  //     if (data.statusCode == 200) {
  //       final responseData = jsonDecode(data.body);
  //       // print(responseData.toString());
  //       final income = TotalIncome.fromJson(responseData);

  //       emit(ActivityCardSuccess(card: income));
  //     } else {
  //       final errorMessage = 'Error ${data.statusCode}: ${data.reasonPhrase}';
  //       emit(ActivityFailure(message: errorMessage));
  //     }
  //   } on Exception catch (e) {
  //     emit(ActivityFailure(message: "Something went wrong: $e"));
  //   }
  // }

  void getActiv() async {
    try {
      emit(ActivityLoading());
      String base_url = Api().base_url;
      final data = await Api().get(url: '$base_url/showActivities');
      if (data.statusCode == 200) {
        print('20000000');
        final responseData = jsonDecode(data.body);
        print('after decodeeeee');
        if (responseData.isEmpty) {
          // No hotel information available
          emit(ActivityEmpty(message: 'Empty'));
        } else if (responseData is List) {
          final activList =
              (responseData as List).map((e) => Activity.fromJson(e)).toList();
          emit(ActivitySuccess(activ: activList));
        } else {
          // Unexpected data format
          emit(ActivityFailure(message: 'Unexpected data format'));
        }
      } else {
        emit(ActivityFailure(message: 'Error fetching admin data'));
      }
    } on Exception catch (e) {
      emit(ActivityFailure(message: "Something went wrong: $e"));
    }
  }
}

  // void getLine() async {
  //   try {
  //     emit(ActivityLoading());
  //     String base_url = Api().base_url;
  //     final data = await Api().get(url: '$base_url/lineChart');
  //     if (data.statusCode == 200) {
  //       print('20000000');
  //       final responseData = jsonDecode(data.body);
  //       print('after decodeeeee');
  //       if (responseData.isEmpty) {
  //         // No hotel information available
  //         print('emptyyyyyy');
  //         emit(ActivityEmpty(message: 'Empty'));
  //       } else if (responseData is List) {
  //         final lineList =
  //             (responseData as List).map((e) => Line.fromJson(e)).toList();
  //         emit(ActivityLineChartSuccess(line: lineList));
  //       } else {
  //         // Unexpected data format
  //         emit(ActivityFailure(message: 'Unexpected data format'));
  //       }
  //     } else {
  //       emit(ActivityFailure(message: 'Error fetching admin data'));
  //     }
  //   } on Exception catch (e) {
  //     emit(ActivityFailure(message: "Something went wrong: $e"));
  //   }
  // }

  /* void getActivityData() async {
    try {
      emit(ActivityLoading());

      String base_url = Api().base_url;
      final incomeData = await Api().get(url: '$base_url/returnTotalEncom');
      final activitiesData = await Api().get(url: '$base_url/showActivities');

      if (incomeData.statusCode == 200 && activitiesData.statusCode == 200) {
        final incomeResponseData = jsonDecode(incomeData.body);
        final activitiesResponseData = jsonDecode(activitiesData.body);

        if (activitiesResponseData == []) {
          emit(ActivityEmpty(message: 'No activities found'));
        } else if (activitiesResponseData is List) {
          final activList = (activitiesResponseData as List)
              .map((e) => Activity.fromJson(e))
              .toList();
          emit(ActivityDataSuccess(card: incomeResponseData, activ: activList));
        } else {
          emit(ActivityFailure(message: 'Unexpected activities data format'));
        }
      } else {
        final incomeErrorMessage =
            'Error getting income: ${incomeData.statusCode} - ${incomeData.reasonPhrase}';
        final activitiesErrorMessage =
            'Error getting activities: ${activitiesData.statusCode} - ${activitiesData.reasonPhrase}';
        emit(ActivityFailure(
            message: '$incomeErrorMessage, $activitiesErrorMessage'));
      }
    } on Exception catch (e) {
      emit(ActivityFailure(message: "Something went wrong: $e"));
    }
  }*/
  // void getActivityData() async {
  //   try {
  //     emit(ActivityLoading());

  //     String base_url = Api().base_url;

  //     // Fetch total income
  //     final incomeResponse = await Api().get(url: '$base_url/returnTotalEncom');
  //     if (incomeResponse.statusCode == 200) {
  //       final incomeData = jsonDecode(incomeResponse.body);
  //       final income = TotalIncome.fromJson(incomeData);
  //       emit(ActivityCardSuccess(card: income));
  //     } else {
  //       final errorMessage =
  //           'Error ${incomeResponse.statusCode}: ${incomeResponse.reasonPhrase}';
  //       emit(ActivityFailure(message: errorMessage));
  //       return;
  //     }

  //     // Fetch activities
  //     final activitiesResponse =
  //         await Api().get(url: '$base_url/showActivities');
  //     if (activitiesResponse.statusCode == 200) {
  //       final activitiesData = jsonDecode(activitiesResponse.body);
  //       if (activitiesData.isEmpty) {
  //         emit(ActivityEmpty(message: 'No activities found.'));
  //       } else if (activitiesData is List) {
  //         final activities = (activitiesData as List)
  //             .map((e) => Activity.fromJson(e))
  //             .toList();
  //         emit(ActivityActivitySuccess(activ: activities));
  //       } else {
  //         emit(
  //             ActivityFailure(message: 'Unexpected data format for activities.'));
  //         return;
  //       }
  //     } else {
  //       emit(ActivityFailure(message: 'Error fetching activities.'));
  //       return;
  //     }

  //     // Fetch line chart data
  //     final lineChartResponse = await Api().get(url: '$base_url/lineChart');
  //     if (lineChartResponse.statusCode == 200) {
  //       final lineChartData = jsonDecode(lineChartResponse.body);
  //       if (lineChartData.isEmpty) {
  //         emit(ActivityEmpty(message: 'No line chart data available.'));
  //       } else if (lineChartData is List) {
  //         final lineChartList =
  //             (lineChartData as List).map((e) => Line.fromJson(e)).toList();
  //         emit(ActivityLineChartSuccess(line: lineChartList));
  //       } else {
  //         emit(
  //             ActivityFailure(message: 'Unexpected data format for line chart.'));
  //         return;
  //       }
  //     } else {
  //       emit(ActivityFailure(message: 'Error fetching line chart data.'));
  //       return;
  //     }
  //   } on Exception catch (e) {
  //     emit(ActivityFailure(message: "Something went wrong: $e"));
  //   }
  // }

  //finalllllll
//     void getActivityData() async {
//     try {
//       emit(ActivityLoading());

//       String base_url = Api().base_url;

//       // Fetch total income
//       final incomeResponse = await Api().get(url: '$base_url/returnTotalEncom');
//       TotalIncome? income;
//       if (incomeResponse.statusCode == 200) {
//         final incomeData = jsonDecode(incomeResponse.body);
//         income = TotalIncome.fromJson(incomeData);
//       } else {
//         emit(ActivityFailure(message: 'Error fetching total income.'));
//         return;
//       }

//       // Fetch activities
//       final activitiesResponse =
//           await Api().get(url: '$base_url/showActivities');
//       List<Activity>? activities;
//       if (activitiesResponse.statusCode == 200) {
//         final activitiesData = jsonDecode(activitiesResponse.body);
//         if (activitiesData.isEmpty) {
//           emit(ActivityEmpty(message: 'No activities found.'));
//           return;
//         }
//         activities =
//             (activitiesData as List).map((e) => Activity.fromJson(e)).toList();
//       } else {
//         emit(ActivityFailure(message: 'Error fetching activities.'));
//         return;
//       }

//       // Fetch line chart data
//       final lineChartResponse = await Api().get(url: '$base_url/lineChart');
//       List<Line>? lines;
//       if (lineChartResponse.statusCode == 200) {
//         final lineChartData = jsonDecode(lineChartResponse.body);
//         if (lineChartData.isEmpty) {
//           emit(ActivityEmpty(message: 'No line chart data available.'));
//           return;
//         }
//         lines = (lineChartData as List).map((e) => Line.fromJson(e)).toList();
//       } else {
//         emit(ActivityFailure(message: 'Error fetching line chart data.'));
//         return;
//       }

//       // Emit the ActivitySuccess state
//       emit(ActivitySuccess(
//         card: income,
//         activ: activities,
//         line: lines,
//       ));
//     } on Exception catch (e) {
//       emit(ActivityFailure(message: "Something went wrong: $e"));
//     }
//   }
// }
