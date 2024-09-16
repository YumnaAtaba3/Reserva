import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:reserva/cubits/shared/home_page/home_page_state.dart';
import 'package:reserva/helper/api.dart';
import 'package:reserva/models/comany_owner/hotel/hotel_home.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageInitial());

  /*void getAllHome() async {
    try {
      emit(HomePageLoading());

      String base_url = Api().base_url;

      final data = await Api().get(url: '$base_url/showAllHotelHome');
      print(data.body.toString());
      if (data.statusCode == 200) {
        print('2000000000000');
        final responseData = jsonDecode(data.body)['data'];
        print('dataaaaaaa');
        final admin = List<Admin>.from(
          responseData['hotelShowAdmin']['admin'].map((e) => Admin.fromJson(e)),
        );
        print('adminnnnnnnnnnnn');
        // final yearReservationsCount = responseData['hotelLastForYear']['yearReservationsCount'];
        //final yearTopMothRes = responseData['hotelReservationChartTable']['yearTopMothRes'];

        // List datamap = jsonDecode(data.body)["data"]["hotelShowAdmin"]["admin"];

        // final admin = List<Admin>.from(datamap.map((e) => Admin.fromJson(e)));

        emit(HomePageSuccess(admin: admin));
      } else if (data.statusCode == 404) {
        emit(HomepageEmpty());
      } else {
        emit(HomePageFailure(message: jsonDecode(data.body)["message"]));
      }
    } on Exception catch (e) {
      emit(HomePageFailure(message: "something is wrong ..."));
    }
  }*/

  // void showAdmin() async {
  //   try {
  //     emit(HomePageLoading());

  //     String base_url = Api().base_url;

  //     final data = await Api().get(url: '$base_url/hotelShowAdmin');
  //     if (data.statusCode == 200) {
  //       final responseData = jsonDecode(data.body);
  //       if (responseData['status'] == 1) {
  //         final adminList = (responseData['data'] as List)
  //             .map((e) => Admin.fromJson(e))
  //             .toList();
  //         emit(HomePageSuccessAdmin(admin: adminList));
  //       } else {
  //         emit(HomePageFailure(message: responseData['message']));
  //       }
  //     } else {
  //       emit(HomePageFailure(message: 'Error fetching admin data'));
  //     }
  //   } on Exception catch (e) {
  //     emit(HomePageFailure(message: "Something went wrong: $e"));
  //   }
  // }

  // void getChartTable() async {
  //   try {
  //     emit(HomePageLoading());

  //     String base_url = Api().base_url;

  //     final data = await Api().get(url: '$base_url/hotelReservationChartTable');
  //     if (data.statusCode == 200) {
  //       final responseData = jsonDecode(data.body);
  //       if (responseData['status'] == 1) {
  //         final barChartList = (responseData['data'] as List)
  //             .map((e) => Chart.fromJson(e))
  //             .toList();
  //         emit(HomePageSuccessChartTable(barChart: barChartList));
  //       } else if (data.statusCode == 404) {
  //         print('404');
  //         emit(HomePageEmpty(message: 'there is no reservations yet'));
  //       } else if (data.statusCode == 500) {
  //         print('5000000');
  //         emit(HomePageEmpty(message: 'there is no reservations yet'));
  //       }
  //     } else {
  //       emit(HomePageEmpty(message: 'Error fetching admin data'));
  //     }
  //   } on Exception catch (e) {
  //     emit(HomePageFailure(message: "Something went wrong: $e"));
  //   }
  // }

  // void getPieChart() async {
  //   try {
  //     emit(HomePageLoading());

  //     String base_url = Api().base_url;

  //     final data = await Api().get(url: '$base_url/hotelLastForYear');
  //     if (data.statusCode == 200) {
  //       final responseData = jsonDecode(data.body);
  //       if (responseData['status'] == 1) {
  //         final pieChartData = PieData.fromJson(responseData);
  //         emit(HomePageSuccessPieChart(pieChart: pieChartData));
  //       } else {
  //         emit(HomePageEmpty(message: responseData['message']));
  //       }
  //     } else {
  //       emit(HomePageEmpty(message: 'Error fetching admin data'));
  //     }
  //   } on Exception catch (e) {
  //     emit(HomePageFailure(message: "Something went wrong: $e"));
  //   }
  // }

  /*void fetchHotelHomePageData() async {
    try {
      emit(HomePageLoading());

      String base_url = Api().base_url;

      // Fetch admin data
      final adminData = await Api().get(url: '$base_url/hotelShowAdmin');
      if (adminData.statusCode == 200) {
        print('2000000000/admin');
        final adminResponseData = jsonDecode(adminData.body);
        if (adminResponseData['status'] == 1) {
          final adminList = (adminResponseData['data'] as List)
              .map((e) => Admin.fromJson(e))
              .toList();

          // Fetch chart table data
          final chartTableData =
              await Api().get(url: '$base_url/hotelReservationChartTable');
          if (chartTableData.statusCode == 200) {
            print("200000000000000 chartt");
            final chartTableResponseData = jsonDecode(chartTableData.body);
            if (chartTableResponseData['status'] == 1) {
              final barChartList = (chartTableResponseData['data'] as List)
                  .map((e) => Chart.fromJson(e))
                  .toList();

              // Fetch pie chart data
              final pieChartData =
                  await Api().get(url: '$base_url/hotelLastForYear');
              if (pieChartData.statusCode == 200) {
                print("2000000000000 pie");
                final pieChartResponseData = jsonDecode(pieChartData.body);
                if (pieChartResponseData['status'] == 1) {
                  final pieChartData = PieData.fromJson(pieChartResponseData);

                  // Emit the HomePageSuccess state
                  emit(HomePageSuccess(
                    pieChart: pieChartData,
                    barChart: barChartList,
                    admin: adminList,
                  ));
                } else {
                  emit(HomePageEmpty(message: pieChartResponseData['message']));
                }
              } else {
                emit(HomePageEmpty(message: 'Error fetching pie chart data'));
              }
            } else if (chartTableData.statusCode == 404) {
              emit(HomePageEmpty(message: 'there is no reservations yet'));
            } else if (chartTableData.statusCode == 500) {
              emit(HomePageEmpty(message: 'there is no reservations yet'));
            }
          } else {
            emit(HomePageEmpty(message: 'Error fetching chart table data'));
          }
        } else {
          emit(HomePageFailure(message: adminResponseData['message']));
        }
      } else {
        emit(HomePageFailure(message: 'Error fetching admin data'));
      }
    } on Exception catch (e) {
      emit(HomePageFailure(message: "Something went wrong: $e"));
    }
  }*/

  void fetchHotelHomePageData() async {
    try {
      emit(HomePageLoading());

      String base_url = Api().base_url;

      // Fetch admin data
      final adminData = await Api().get(url: '$base_url/hotelShowAdmin');
      if (adminData.statusCode == 200) {
        final adminResponseData = jsonDecode(adminData.body);
        if (adminResponseData['status'] == 1) {
          final adminList = (adminResponseData['data'] as List)
              .map((e) => Admin.fromJson(e))
              .toList();

          // Fetch chart table data
          final chartTableData =
              await Api().get(url: '$base_url/hotelReservationChartTable');
          if (chartTableData.statusCode == 200) {
            final chartTableResponseData = jsonDecode(chartTableData.body);
            if (chartTableResponseData['status'] == 1) {
              final barChartList = (chartTableResponseData['data'] as List)
                  .map((e) => Chart.fromJson(e))
                  .toList();

              // Fetch pie chart data
              final pieChartData =
                  await Api().get(url: '$base_url/hotelLastForYear');
              if (pieChartData.statusCode == 200) {
                final pieChartResponseData = jsonDecode(pieChartData.body);
                if (pieChartResponseData['status'] == 1) {
                  final pieChartData = PieData.fromJson(pieChartResponseData);

                  // Emit the HomePageSuccess state
                  emit(HomePageSuccess(
                    pieChart: pieChartData,
                    barChart: barChartList,
                    admin: adminList,
                  ));
                } else {
                  emit(HomePageEmpty(
                    message: pieChartResponseData['message'],
                    admin: adminList,
                  ));
                }
              } else {
                emit(HomePageEmpty(
                  message: 'Error fetching pie chart data',
                  admin: adminList,
                ));
              }
            } else {
              emit(HomePageEmpty(
                message: chartTableResponseData['message'],
                admin: adminList,
              ));
            }
          } else if (chartTableData.statusCode == 404) {
            emit(HomePageEmpty(
              message: 'There are no reservations yet',
              admin: adminList,
            ));
          } else {
            emit(HomePageFailure(message: 'Error fetching chart table data'));
          }
        } else {
          emit(HomePageFailure(message: adminResponseData['message']));
        }
      } else {
        emit(HomePageFailure(message: 'Error fetching admin data'));
      }
    } on Exception catch (e) {
      emit(HomePageFailure(message: "Something went wrong: $e"));
    }
  }

  void fetchFlightHomePageData() async {
    try {
      emit(HomePageLoading());

      String base_url = Api().base_url;

      // Fetch admin data
      final adminData = await Api().get(url: '$base_url/flightShowAdmin');
      if (adminData.statusCode == 200) {
        final adminResponseData = jsonDecode(adminData.body);
        if (adminResponseData['status'] == 1) {
          final adminList = (adminResponseData['data'] as List)
              .map((e) => Admin.fromJson(e))
              .toList();

          // Fetch chart table data
          final chartTableData =
              await Api().get(url: '$base_url/flightReservationChartTable');
          if (chartTableData.statusCode == 200) {
            final chartTableResponseData = jsonDecode(chartTableData.body);
            if (chartTableResponseData['status'] == 1) {
              final barChartList = (chartTableResponseData['data'] as List)
                  .map((e) => Chart.fromJson(e))
                  .toList();

              // Fetch pie chart data
              final pieChartData =
                  await Api().get(url: '$base_url/lastForYear');
              if (pieChartData.statusCode == 200) {
                final pieChartResponseData = jsonDecode(pieChartData.body);
                if (pieChartResponseData['status'] == 1) {
                  final pieChartData = PieData.fromJson(pieChartResponseData);

                  // Emit the HomePageSuccess state
                  emit(HomePageSuccess(
                    pieChart: pieChartData,
                    barChart: barChartList,
                    admin: adminList,
                  ));
                } else {
                  emit(HomePageEmpty(
                    message: pieChartResponseData['message'],
                    admin: adminList,
                  ));
                }
              } else {
                emit(HomePageEmpty(
                  message: 'Error fetching pie chart data',
                  admin: adminList,
                ));
              }
            } else {
              emit(HomePageEmpty(
                message: chartTableResponseData['message'],
                admin: adminList,
              ));
            }
          } else if (chartTableData.statusCode == 404) {
            emit(HomePageEmpty(
              message: 'There are no reservations yet',
              admin: adminList,
            ));
          } else {
            emit(HomePageFailure(message: 'Error fetching chart table data'));
          }
        } else {
          emit(HomePageFailure(message: adminResponseData['message']));
        }
      } else {
        emit(HomePageFailure(message: 'Error fetching admin data'));
      }
    } on Exception catch (e) {
      emit(HomePageFailure(message: "Something went wrong: $e"));
    }
  }

  // void fetchFlightHomePageData() async {
  //   try {
  //     emit(HomePageLoading());

  //     String base_url = Api().base_url;

  //     // Fetch admin data
  //     final adminData = await Api().get(url: '$base_url/flightShowAdmin');
  //     if (adminData.statusCode == 200) {
  //       print('2000000000/admin');
  //       final adminResponseData = jsonDecode(adminData.body);
  //       if (adminResponseData['status'] == 1) {
  //         final adminList = (adminResponseData['data'] as List)
  //             .map((e) => Admin.fromJson(e))
  //             .toList();

  //         // Fetch chart table data
  //         final chartTableData =
  //             await Api().get(url: '$base_url/flightReservationChartTable');
  //         if (chartTableData.statusCode == 200) {
  //           print("200000000000000 chartt");
  //           final chartTableResponseData = jsonDecode(chartTableData.body);
  //           if (chartTableResponseData['status'] == 1) {
  //             final barChartList = (chartTableResponseData['data'] as List)
  //                 .map((e) => Chart.fromJson(e))
  //                 .toList();

  //             // Fetch pie chart data
  //             final pieChartData =
  //                 await Api().get(url: '$base_url/lastForYear');
  //             if (pieChartData.statusCode == 200) {
  //               print("2000000000000 pie");
  //               final pieChartResponseData = jsonDecode(pieChartData.body);
  //               if (pieChartResponseData['status'] == 1) {
  //                 final pieChartData = PieData.fromJson(pieChartResponseData);

  //                 // Emit the HomePageSuccess state
  //                 emit(HomePageSuccess(
  //                   pieChart: pieChartData,
  //                   barChart: barChartList,
  //                   admin: adminList,
  //                 ));
  //               } else {
  //                 emit(HomePageEmpty(message: pieChartResponseData['message']));
  //               }
  //             } else {
  //               emit(HomePageEmpty(message: 'Error fetching pie chart data'));
  //             }
  //           } else if (chartTableData.statusCode == 404) {
  //             emit(HomePageEmpty(message: 'there is no reservations yet'));
  //           } else if (chartTableData.statusCode == 500) {
  //             emit(HomePageEmpty(message: 'there is no reservations yet'));
  //           }
  //         } else {
  //           emit(HomePageEmpty(message: 'Error fetching chart table data'));
  //         }
  //       } else {
  //         emit(HomePageFailure(message: adminResponseData['message']));
  //       }
  //     } else {
  //       emit(HomePageFailure(message: 'Error fetching admin data'));
  //     }
  //   } on Exception catch (e) {
  //     emit(HomePageFailure(message: "Something went wrong: $e"));
  //   }
  // }
}
