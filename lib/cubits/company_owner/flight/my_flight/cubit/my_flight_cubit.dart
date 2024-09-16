import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:reserva/constants.dart';
import 'package:reserva/cubits/company_owner/flight/my_flight/cubit/my_flight_state.dart';
import 'package:reserva/cubits/company_owner/hotel/my_hotel/cubit/my_hotel_state.dart';
import 'package:reserva/helper/api.dart';
import 'package:reserva/models/city_model.dart';
import 'package:reserva/models/comany_owner/flight/my_flight.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

class MyFlightCubit extends Cubit<MyFlightState> {
  MyFlightCubit() : super(MyFlightInitial());
  List<City>? cities;
  Future<void> getFilters() async {
    emit(MyFlightLoading());
    try {
      print("before api request!!");

      final data =
          await Api().get(url: "${Api().base_url}/getAllFliters", token: null);
      print("after api request!!");
      print(data.body.toString());
      if (data.statusCode == 200) {
        List city_map = jsonDecode(data.body)["data"]["cities"];

        cities = List<City>.from(city_map.map((e) => City.fromJson(e)));

        emit(MyFlightGotFiltersSuccess());
      } else {
        emit(MyFlightFailure(message: jsonDecode(data.body)["message"]));
      }
    } catch (e) {
      emit(MyFlightFailure(message: e.toString()));
    }
  }

  void showFlightInfo() async {
    try {
      emit(MyFlightLoading());
      String base_url = Api().base_url;
      final data = await Api().get(url: '$base_url/showAirwayIfo');
      if (data.statusCode == 200) {
        final responseData = jsonDecode(data.body);
        if (responseData['status'] == 1) {
          if (responseData['data'] is String) {
            // No hotel information available
            emit(MyFlightEmpty(message: responseData['message']));
          } else if (responseData['data'] is List) {
            final infoList = (responseData['data'] as List)
                .map((e) => FlightInfo.fromJson(e))
                .toList();
            emit(MyFlightSuccessInfo(flightInfo: infoList));
          } else {
            // Unexpected data format
            emit(MyFlightFailure(message: 'Unexpected data format'));
          }
        } else {
          emit(MyFlightFailure(message: responseData['message']));
        }
      } else {
        emit(MyFlightFailure(message: 'Error fetching admin data'));
      }
    } on Exception catch (e) {
      emit(MyFlightFailure(message: "Something went wrong: $e"));
    }
  }

  void showFlightService() async {
    try {
      emit(MyFlightLoading());
      String base_url = Api().base_url;
      final data = await Api().get(url: '$base_url/showAllServices');
      if (data.statusCode == 200) {
        final responseData = jsonDecode(data.body);
        if (responseData['status'] == 1) {
          final serviceList = (responseData['data'] as List)
              .map((e) => Service.fromJson(e))
              .toList();
          emit(MyFlightSuccessService(service: serviceList));
        } else {
          emit(MyFlightFailure(message: responseData['message']));
        }
      }
    } on Exception catch (e) {
      emit(MyFlightFailure(message: "Something went wrong: $e"));
    }
  }

  void showFlightReview() async {
    try {
      emit(MyFlightLoading());
      String base_url = Api().base_url;
      final data = await Api().get(url: '$base_url/showAllFlightsReviews');
      if (data.statusCode == 200) {
        final responseData = jsonDecode(data.body);
        if (responseData['status'] == 1) {
          if (responseData['data'] is String) {
            // No hotel information available
            emit(MyFlightEmpty(message: responseData['message']));
          } else if (responseData['data'] is List) {
            final reviewList = (responseData['data'] as List)
                .map((e) => FlightReview.fromJson(e))
                .toList();
            emit(MyFlightSuccessReview(flightReview: reviewList));
          } else {
            // Unexpected data format
            emit(MyFlightFailure(message: 'Unexpected data format'));
          }
        }
      } else {
        emit(MyFlightFailure(message: 'Error fetching admin data'));
      }
    } on Exception catch (e) {
      emit(MyFlightFailure(message: "Something went wrong: $e"));
    }
  }

  void showFlights() async {
    try {
      emit(MyFlightLoading());
      String base_url = Api().base_url;
      final data = await Api().get(url: '$base_url/showAllFlightWithItTime');
      if (data.statusCode == 200) {
        final responseData = json.decode(data.body);
        print('responseData: $responseData');

        if (responseData['status'] == 1) {
          print('1111111111');
          List datamap = jsonDecode(data.body)["data"]["flights"];
          print('dataaaaaaamap');
          final flightList =
              List<Flight>.from(datamap.map((e) => Flight.fromJson(e)));
          print('listttttttttt');
          emit(MyFlightSuccessFlightWithTime(flights: flightList));
        } else {
          emit(MyFlightEmpty(message: responseData['message']));
        }
      } else {
        emit(MyFlightFailure(message: 'Error fetching admin data'));
      }
    } on Exception catch (e) {
      emit(MyFlightFailure(message: "Something went wrong: $e"));
    }
  }

  // void getAllMyFlight() async {
  //   try {
  //     emit(MyFlightLoading());

  //     String base_url = Api().base_url;

  //     // Fetch hotel information
  //     final infoData = await Api().get(url: '$base_url/showAirwayIfo');
  //     if (infoData.statusCode == 200) {
  //       final infoResponseData = jsonDecode(infoData.body);
  //       if (infoResponseData['status'] == 1) {
  //         if (infoResponseData['data'] is String) {
  //           emit(MyFlightEmpty(message: infoResponseData['message']));
  //         } else if (infoResponseData['data'] is List) {
  //           final infoList = (infoResponseData['data'] as List)
  //               .map((e) => FlightInfo.fromJson(e))
  //               .toList();
  //           emit(MyFlightSuccessInfo(flightInfo: infoList));
  //         } else {
  //           emit(MyFlightFailure(message: 'Unexpected data format'));
  //         }
  //       } else {
  //         emit(MyFlightFailure(message: infoResponseData['message']));
  //       }
  //     } else {
  //       emit(MyFlightFailure(message: 'Error fetching hotel information'));
  //     }

  //     // Fetch hotel facilities
  //     final serviceData = await Api().get(url: '$base_url/showAllServices');
  //     if (serviceData.statusCode == 200) {
  //       final serviceResponseData = jsonDecode(serviceData.body);
  //       if (serviceResponseData['status'] == 1) {
  //         final serviceList = (serviceResponseData['data'] as List)
  //             .map((e) => Service.fromJson(e))
  //             .toList();
  //         emit(MyFlightSuccessService(service: serviceList));
  //       } else {
  //         emit(MyFlightFailure(message: serviceResponseData['message']));
  //       }
  //     } else {
  //       emit(MyFlightFailure(message: 'Error fetching hotel facilities'));
  //     }

  //     // Fetch hotel reviews
  //     final reviewData =
  //         await Api().get(url: '$base_url/showAllFlightsReviews');
  //     if (reviewData.statusCode == 200) {
  //       final reviewResponseData = jsonDecode(reviewData.body);
  //       if (reviewResponseData['status'] == 1) {
  //         if (reviewResponseData['data'] is String) {
  //           emit(MyFlightEmpty(message: reviewResponseData['message']));
  //         } else if (reviewResponseData['data'] is List) {
  //           final reviewList = (reviewResponseData['data'] as List)
  //               .map((e) => FlightReview.fromJson(e))
  //               .toList();
  //           emit(MyFlightSuccessReview(flightReview: reviewList));
  //         } else {
  //           emit(MyFlightFailure(message: 'Unexpected data format'));
  //         }
  //       } else {
  //         emit(MyFlightFailure(message: reviewResponseData['message']));
  //       }
  //     } else {
  //       emit(MyFlightFailure(message: 'Error fetching hotel reviews'));
  //     }

  //     // Fetch hotel rooms
  //     final flightData =
  //         await Api().get(url: '$base_url/showAllFlightWithItTime');
  //     if (flightData.statusCode == 200) {
  //       final flightResponseData = json.decode(flightData.body);
  //       if (flightResponseData['status'] == 1) {
  //         List datamap = jsonDecode(flightData.body)["data"]["rooms"];
  //         final fligthList =
  //             List<Flight>.from(datamap.map((e) => Room.fromJson(e)));
  //         emit(MyFlightSuccessFlightWithTime(flights: fligthList));
  //       } else {
  //         emit(MyFlightEmpty(message: flightResponseData['message']));
  //       }
  //     } else {
  //       emit(MyFlightFailure(message: 'Error fetching hotel rooms'));
  //     }
  //   } on Exception catch (e) {
  //     emit(MyFlightFailure(message: "Something went wrong: $e"));
  //   }
  // }

  void getAllMyFlight() async {
    try {
      emit(MyFlightLoading());

      String baseUrl = Api().base_url;

      // Fetch flight information
      final flightInfoResponse = await Api().get(url: '$baseUrl/showAirwayIfo');
      final flightInfoData =
          await _processFlightInfoResponse(flightInfoResponse);

      // Fetch flight services
      final flightServiceResponse =
          await Api().get(url: '$baseUrl/showAllServices');
      final flightServiceData =
          await _processFlightServiceResponse(flightServiceResponse);

      // Fetch flight reviews
      final flightReviewResponse =
          await Api().get(url: '$baseUrl/showAllFlightsReviews');
      final flightReviewData =
          await _processFlightReviewResponse(flightReviewResponse);

      // Fetch flights with departure and arrival time
      final flightsWithTimeResponse =
          await Api().get(url: '$baseUrl/showAllFlightWithItTime');
      final flightsWithTimeData =
          await _processFlightsWithTimeResponse(flightsWithTimeResponse);

      emit(MyFlightSuccess(
        flightInfo: flightInfoData,
        service: flightServiceData,
        flightReview: flightReviewData,
        flights: flightsWithTimeData,
      ));
    } on Exception catch (e) {
      emit(MyFlightFailure(message: "Something went wrong: $e"));
    }
  }

  Future<List<FlightInfo>> _processFlightInfoResponse(
      http.Response response) async {
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['status'] == 1) {
        if (responseData['data'] is List) {
          return (responseData['data'] as List)
              .map((e) => FlightInfo.fromJson(e))
              .toList();
        } else {
          emit(MyFlightEmpty(message: responseData['message']));
          return [];
        }
      } else {
        emit(MyFlightFailure(message: responseData['message']));
        return [];
      }
    } else {
      emit(MyFlightFailure(message: 'Error fetching airway information'));
      return [];
    }
  }

  Future<List<Service>> _processFlightServiceResponse(
      http.Response response) async {
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['status'] == 1) {
        return (responseData['data'] as List)
            .map((e) => Service.fromJson(e))
            .toList();
      } else {
        emit(MyFlightFailure(message: responseData['message']));
        return [];
      }
    } else {
      emit(MyFlightFailure(message: 'Error fetching airway services'));
      return [];
    }
  }

  Future<List<FlightReview>> _processFlightReviewResponse(
      http.Response response) async {
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['status'] == 1) {
        if (responseData['data'].isEmpty) {
          emit(MyFlightEmpty(message: responseData['message']));
          return [];
        }
        if (responseData['data'] is List) {
          return (responseData['data'] as List)
              .map((e) => FlightReview.fromJson(e))
              .toList();
        } else {
          emit(MyFlightEmpty(message: responseData['message']));
          return [];
        }
      } else {
        emit(MyFlightFailure(message: responseData['message']));
        return [];
      }
    } else {
      emit(MyFlightFailure(message: 'Error fetching flight reviews'));
      return [];
    }
  }

  Future<List<Flight>> _processFlightsWithTimeResponse(
      http.Response response) async {
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['status'] == 1) {
        print('11111111111111danaaaaaaaaa');
        // if (responseData['data'].isEmpty) {
        //   print('empty22222222');
        //   emit(MyFlightEmpty(message: responseData['message']));
        //   return [];
        // } else
        //if (responseData['data']['flights']) {
        print('succcesssssssss2');
        List datamap = jsonDecode(response.body)["data"]["flights"];
        //  prefs?.setInt('flight_id', responseData['data']['flights'][0]['id']);
        // print(responseData['data']['flights'][0]['id']);
        return List<Flight>.from(datamap.map((e) => Flight.fromJson(e)));
        // } else {
        //   emit(MyFlightEmpty(message: responseData['message']));
        //   return [];
        // }
      } else {
        emit(MyFlightEmpty(message: responseData['message']));
        return [];
      }
    } else {
      emit(MyFlightFailure(message: 'Error fetching flights'));
      return [];
    }
  }
}
