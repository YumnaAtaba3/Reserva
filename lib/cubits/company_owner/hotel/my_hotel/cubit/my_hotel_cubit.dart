import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:reserva/constants.dart';

import 'package:reserva/cubits/company_owner/hotel/my_hotel/cubit/my_hotel_state.dart';
import 'package:reserva/helper/api.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

class MyHotelCubit extends Cubit<MyHotelState> {
  MyHotelCubit() : super(MyHotelInitial());
  List<City>? cities;
  late List<Facility> facilities;
  Future<void> getFilters() async {
    emit(MyHotelLoading());
    try {
      print("before api request!!");
      // emit(MyHotelLoading());
      final data =
          await Api().get(url: "${Api().base_url}/getAllFliters", token: null);
      print("after api request!!");
      print(data.body.toString());
      if (data.statusCode == 200) {
        List city_map = jsonDecode(data.body)["data"]["cities"];

        cities = List<City>.from(city_map.map((e) => City.fromJson(e)));

        emit(MyHotelGotFiltersSuccess());
      } else {
        emit(MyHotelFailure(message: jsonDecode(data.body)["message"]));
      }
    } catch (e) {
      emit(MyHotelFailure(message: e.toString()));
    }
  }

  void showHotelInfo() async {
    try {
      emit(MyHotelLoading());
      String base_url = Api().base_url;
      final data = await Api().get(url: '$base_url/showHotelIfo');
      if (data.statusCode == 200) {
        final responseData = jsonDecode(data.body);
        if (responseData['status'] == 1) {
          if (responseData['data'] is String) {
            // No hotel information available
            emit(MyHotelEmpty(message: responseData['message']));
          } else if (responseData['data'] is List) {
            final infoList = (responseData['data'] as List)
                .map((e) => HotelInfo.fromJson(e))
                .toList();
            emit(MyHotelSuccessInfo(hotelInfo: infoList));
          } else {
            // Unexpected data format
            emit(MyHotelFailure(message: 'Unexpected data format'));
          }
        } else {
          emit(MyHotelFailure(message: responseData['message']));
        }
      } else {
        emit(MyHotelFailure(message: 'Error fetching admin data'));
      }
    } on Exception catch (e) {
      emit(MyHotelFailure(message: "Something went wrong: $e"));
    }
  }

  void showHotelFacility() async {
    try {
      emit(MyHotelLoading());
      String base_url = Api().base_url;
      final data = await Api().get(url: '$base_url/showAllFacilites');
      if (data.statusCode == 200) {
        final responseData = jsonDecode(data.body);
        List datamap = jsonDecode(data.body)["data"];
        final facilities =
            List<Facility>.from(datamap.map((e) => Facility.fromJson(e)));
        this.facilities = facilities;
        // final facilities = (responseData['data'] as List)
        //     .map((e) => Facility.fromJson(e))
        //     .toList();
        // // this.facilities = facilities;
        emit(MyHotelSuccessFacility(facilities: facilities));
      } else {
        emit(MyHotelFailure(message: jsonDecode(data.body)['message']));
      }
    } on Exception catch (e) {
      emit(MyHotelFailure(message: "Something went wrong: $e"));
    }
  }

  void showHotelReview() async {
    try {
      emit(MyHotelLoading());
      String base_url = Api().base_url;
      final data = await Api().get(url: '$base_url/showHotelReviews');
      if (data.statusCode == 200) {
        final responseData = jsonDecode(data.body);
        if (responseData['status'] == 1) {
          if (responseData['data'] is String) {
            // No hotel information available
            emit(MyHotelEmpty(message: responseData['message']));
          } else if (responseData['data'] is List) {
            final reviewList = (responseData['data'] as List)
                .map((e) => HotelReview.fromJson(e))
                .toList();
            emit(MyHotelSuccessReview(hotelReview: reviewList));
          } else {
            // Unexpected data format
            emit(MyHotelFailure(message: 'Unexpected data format'));
          }
        }
      } else {
        emit(MyHotelFailure(message: 'Error fetching admin data'));
      }
    } on Exception catch (e) {
      emit(MyHotelFailure(message: "Something went wrong: $e"));
    }
  }

  void showHotelPhotos() async {
    try {
      emit(MyHotelLoading());
      String base_url = Api().base_url;
      final data = await Api().get(url: '$base_url/showAllHotelPhotos');
      if (data.statusCode == 200) {
        final responseData = jsonDecode(data.body);
        if (responseData['status'] == 1) {
          if (responseData['data'] is List) {
            final photoList = (responseData['data'] as List)
                .map((e) => HotelPhotos.fromJson(e))
                .toList();
            emit(MyHotelSuccessHotelPhotos(photos: photoList));
          } else if (responseData['data'] == []) {
            emit(MyHotelEmpty(message: responseData['message']));
          } else {
            emit(MyHotelEmpty(message: responseData['message']));
          }
        } else {
          emit(MyHotelFailure(message: responseData['message']));
        }
      }
    } on Exception catch (e) {
      emit(MyHotelFailure(message: "Something went wrong: $e"));
    }
  }

  void showHotelRooms() async {
    try {
      emit(MyHotelLoading());
      String base_url = Api().base_url;
      final data =
          await Api().get(url: '$base_url/showAllHotelWithItPhotosAndRooms');
      if (data.statusCode == 200) {
        final responseData = json.decode(data.body);
        print('responseData: $responseData');

        if (responseData['status'] == 1) {
          List datamap = jsonDecode(data.body)["data"]["rooms"];

          final roomList =
              List<Room>.from(datamap.map((e) => Room.fromJson(e)));
          emit(MyHotelSuccessRoom(rooms: roomList));
        } else {
          emit(MyHotelEmpty(message: responseData['message']));
        }
      } else {
        emit(MyHotelFailure(message: 'Error fetching admin data'));
      }
    } on Exception catch (e) {
      emit(MyHotelFailure(message: "Something went wrong: $e"));
    }
  }

  // void getAllMyHotel() async {
  //   try {
  //     emit(MyHotelLoading());

  //     String base_url = Api().base_url;

  //     // Fetch hotel information
  //     final infoData = await Api().get(url: '$base_url/showHotelIfo');
  //     if (infoData.statusCode == 200) {
  //       final infoResponseData = jsonDecode(infoData.body);
  //       if (infoResponseData['status'] == 1) {
  //         if (infoResponseData['data'] is String) {
  //           emit(MyHotelEmpty(message: infoResponseData['message']));
  //         } else if (infoResponseData['data'] is List) {
  //           final infoList = (infoResponseData['data'] as List)
  //               .map((e) => HotelInfo.fromJson(e))
  //               .toList();
  //           emit(MyHotelSuccessInfo(hotelInfo: infoList));
  //         } else {
  //           emit(MyHotelFailure(message: 'Unexpected data format'));
  //         }
  //       } else {
  //         emit(MyHotelFailure(message: infoResponseData['message']));
  //       }
  //     } else {
  //       emit(MyHotelFailure(message: 'Error fetching hotel information'));
  //     }

  //     // Fetch hotel facilities
  //     final facilityData = await Api().get(url: '$base_url/showAllFacilites');
  //     if (facilityData.statusCode == 200) {
  //       final facilityResponseData = jsonDecode(facilityData.body);
  //       if (facilityResponseData['status'] == 1) {
  //         final facilityList = (facilityResponseData['data'] as List)
  //             .map((e) => Facility.fromJson(e))
  //             .toList();
  //         emit(MyHotelSuccessFacility(facility: facilityList));
  //       } else {
  //         emit(MyHotelFailure(message: facilityResponseData['message']));
  //       }
  //     } else {
  //       emit(MyHotelFailure(message: 'Error fetching hotel facilities'));
  //     }

  //     // Fetch hotel reviews
  //     final reviewData = await Api().get(url: '$base_url/showHotelReviews');
  //     if (reviewData.statusCode == 200) {
  //       final reviewResponseData = jsonDecode(reviewData.body);
  //       if (reviewResponseData['status'] == 1) {
  //         if (reviewResponseData['data'] is String) {
  //           emit(MyHotelEmpty(message: reviewResponseData['message']));
  //         } else if (reviewResponseData['data'] is List) {
  //           final reviewList = (reviewResponseData['data'] as List)
  //               .map((e) => HotelReview.fromJson(e))
  //               .toList();
  //           emit(MyHotelSuccessReview(hotelReview: reviewList));
  //         } else {
  //           emit(MyHotelFailure(message: 'Unexpected data format'));
  //         }
  //       } else {
  //         emit(MyHotelFailure(message: reviewResponseData['message']));
  //       }
  //     } else {
  //       emit(MyHotelFailure(message: 'Error fetching hotel reviews'));
  //     }

  //     // Fetch hotel photos
  //     final photoData = await Api().get(url: '$base_url/showAllHotelPhotos');
  //     if (photoData.statusCode == 200) {
  //       final photoResponseData = jsonDecode(photoData.body);
  //       if (photoResponseData['status'] == 1) {
  //         final photoList = (photoResponseData['data'] as List)
  //             .map((e) => HotelPhotos.fromJson(e))
  //             .toList();
  //         emit(MyHotelSuccessHotelPhotos(photos: photoList));
  //       } else {
  //         emit(MyHotelFailure(message: photoResponseData['message']));
  //       }
  //     } else {
  //       emit(MyHotelFailure(message: 'Error fetching hotel photos'));
  //     }

  //     // Fetch hotel rooms
  //     final roomData =
  //         await Api().get(url: '$base_url/showAllHotelWithItPhotosAndRooms');
  //     if (roomData.statusCode == 200) {
  //       final roomResponseData = json.decode(roomData.body);
  //       if (roomResponseData['status'] == 1) {
  //         List datamap = jsonDecode(roomData.body)["data"]["rooms"];
  //         final roomList =
  //             List<Room>.from(datamap.map((e) => Room.fromJson(e)));
  //         emit(MyHotelSuccessRoom(rooms: roomList));
  //       } else {
  //         emit(MyHotelEmpty(message: roomResponseData['message']));
  //       }
  //     } else {
  //       emit(MyHotelFailure(message: 'Error fetching hotel rooms'));
  //     }
  //   } on Exception catch (e) {
  //     emit(MyHotelFailure(message: "Something went wrong: $e"));
  //   }
  // }

  // void fetchHotelData() async {
  //   try {
  //     emit(MyHotelLoading());

  //     String base_url = Api().base_url;

  //     // Fetch hotel information
  //     final hotelInfoResponse = await Api().get(url: '$base_url/showHotelIfo');
  //     if (hotelInfoResponse.statusCode == 200) {
  //       final hotelInfoResponseData = jsonDecode(hotelInfoResponse.body);
  //       if (hotelInfoResponseData['status'] == 1) {
  //         if (hotelInfoResponseData['data'] is String) {
  //           // No hotel information available
  //           emit(MyHotelEmpty(message: hotelInfoResponseData['message']));
  //         } else if (hotelInfoResponseData['data'] is List) {
  //           final infoList = (hotelInfoResponseData['data'] as List)
  //               .map((e) => HotelInfo.fromJson(e))
  //               .toList();
  //           emit(MyHotelSuccessInfo(hotelInfo: infoList));
  //         } else {
  //           // Unexpected data format
  //           emit(MyHotelFailure(message: 'Unexpected data format'));
  //         }
  //       } else {
  //         emit(MyHotelFailure(message: hotelInfoResponseData['message']));
  //       }
  //     } else {
  //       emit(MyHotelFailure(message: 'Error fetching hotel information'));
  //     }

  //     // Fetch hotel facilities
  //     final facilityResponse =
  //         await Api().get(url: '$base_url/showAllFacilites');
  //     if (facilityResponse.statusCode == 200) {
  //       final facilityResponseData = jsonDecode(facilityResponse.body);
  //       if (facilityResponseData['status'] == 1) {
  //         final facilityList = (facilityResponseData['data'] as List)
  //             .map((e) => Facility.fromJson(e))
  //             .toList();
  //         emit(MyHotelSuccessFacility(facility: facilityList));
  //       } else {
  //         emit(MyHotelFailure(message: facilityResponseData['message']));
  //       }
  //     } else {
  //       emit(MyHotelFailure(message: 'Error fetching hotel facilities'));
  //     }

  //     // Fetch hotel reviews
  //     final reviewResponse = await Api().get(url: '$base_url/showHotelReviews');
  //     if (reviewResponse.statusCode == 200) {
  //       final reviewResponseData = jsonDecode(reviewResponse.body);
  //       if (reviewResponseData['status'] == 1) {
  //         if (reviewResponseData['data'] is String) {
  //           // No hotel information available
  //           emit(MyHotelEmpty(message: reviewResponseData['message']));
  //         } else if (reviewResponseData['data'] is List) {
  //           final reviewList = (reviewResponseData['data'] as List)
  //               .map((e) => HotelReview.fromJson(e))
  //               .toList();
  //           emit(MyHotelSuccessReview(hotelReview: reviewList));
  //         } else {
  //           // Unexpected data format
  //           emit(MyHotelFailure(message: 'Unexpected data format'));
  //         }
  //       } else {
  //         emit(MyHotelFailure(message: reviewResponseData['message']));
  //       }
  //     } else {
  //       emit(MyHotelFailure(message: 'Error fetching hotel reviews'));
  //     }

  //     // Fetch hotel photos
  //     final photoResponse =
  //         await Api().get(url: '$base_url/showAllHotelPhotos');
  //     if (photoResponse.statusCode == 200) {
  //       final photoResponseData = jsonDecode(photoResponse.body);
  //       if (photoResponseData['status'] == 1) {
  //         final photoList = (photoResponseData['data'] as List)
  //             .map((e) => HotelPhotos.fromJson(e))
  //             .toList();
  //         emit(MyHotelSuccessHotelPhotos(photos: photoList));
  //       } else {
  //         emit(MyHotelFailure(message: photoResponseData['message']));
  //       }
  //     } else {
  //       emit(MyHotelFailure(message: 'Error fetching hotel photos'));
  //     }

  //     // Fetch hotel rooms
  //     final roomResponse =
  //         await Api().get(url: '$base_url/showAllHotelWithItPhotosAndRooms');
  //     if (roomResponse.statusCode == 200) {
  //       final roomResponseData = json.decode(roomResponse.body);
  //       if (roomResponseData['status'] == 1) {
  //         List datamap = jsonDecode(roomResponse.body)["data"]["rooms"];
  //         final roomList =
  //             List<Room>.from(datamap.map((e) => Room.fromJson(e)));
  //         emit(MyHotelSuccessRoom(rooms: roomList));
  //       } else {
  //         emit(MyHotelEmpty(message: roomResponseData['message']));
  //       }
  //     } else {
  //       emit(MyHotelFailure(message: 'Error fetching hotel rooms'));
  //     }

  //     // Emit the combined success state
  //     emit(MyHotelSuccess(hotel));
  //   } on Exception catch (e) {
  //     emit(MyHotelFailure(message: "Something went wrong: $e"));
  //   }
  // }

  void getAllMyHotel() async {
    try {
      emit(MyHotelLoading());

      String base_url = Api().base_url;

      // Fetch hotel information
      final hotelInfoResponse = await Api().get(url: '$base_url/showHotelIfo');
      final hotelInfoResponseData =
          await _processHotelInfoResponse(hotelInfoResponse);

      // Fetch hotel facilities
      final facilityResponse =
          await Api().get(url: '$base_url/showAllFacilites');
      final facilityResponseData =
          await _processFacilityResponse(facilityResponse);

      // Fetch hotel reviews
      final reviewResponse = await Api().get(url: '$base_url/showHotelReviews');
      final reviewResponseData = await _processReviewResponse(reviewResponse);

      // Fetch hotel photos
      final photoResponse =
          await Api().get(url: '$base_url/showAllHotelPhotos');
      final photoResponseData = await _processPhotoResponse(photoResponse);

      // Fetch hotel rooms
      final roomResponse =
          await Api().get(url: '$base_url/showAllHotelWithItPhotosAndRooms');
      final roomResponseData = await _processRoomResponse(roomResponse);

      // Emit the combined success state
      emit(
        MyHotelSuccess(
          hotelInfo: hotelInfoResponseData,
          facility: facilityResponseData,
          hotelReview: reviewResponseData,
          photos: photoResponseData,
          rooms: roomResponseData,
        ),
      );
    } on Exception catch (e) {
      emit(MyHotelFailure(message: "Something went wrong: $e"));
    }
  }

  Future<List<HotelInfo>> _processHotelInfoResponse(
      http.Response response) async {
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['status'] == 1) {
        if (responseData['data'] is List) {
          // prefs?.setInt('hotel_id', responseData['data'][0]['id']);
          // print(responseData['data'][0]['id']);
          return (responseData['data'] as List)
              .map((e) => HotelInfo.fromJson(e))
              .toList();
        } else {
          emit(MyHotelEmpty(message: responseData['message']));
          return [];
        }
      } else {
        emit(MyHotelFailure(message: responseData['message']));
        return [];
      }
    } else {
      emit(MyHotelFailure(message: 'Error fetching hotel information'));
      return [];
    }
  }

  Future<List<Facility>> _processFacilityResponse(
      http.Response response) async {
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['status'] == 1) {
        return (responseData['data'] as List)
            .map((e) => Facility.fromJson(e))
            .toList();
      } else {
        emit(MyHotelFailure(message: responseData['message']));
        return [];
      }
    } else {
      emit(MyHotelFailure(message: 'Error fetching hotel facilities'));
      return [];
    }
  }

  Future<List<HotelReview>> _processReviewResponse(
      http.Response response) async {
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['status'] == 1) {
        if (responseData['data'] is List) {
          return (responseData['data'] as List)
              .map((e) => HotelReview.fromJson(e))
              .toList();
        } else {
          emit(MyHotelEmpty(message: responseData['message']));
          return [];
        }
      } else {
        emit(MyHotelFailure(message: responseData['message']));
        return [];
      }
    } else {
      emit(MyHotelFailure(message: 'Error fetching hotel reviews'));
      return [];
    }
  }

  Future<List<HotelPhotos>> _processPhotoResponse(
      http.Response response) async {
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['status'] == 1) {
        if (responseData['data'] is List) {
          return (responseData['data'] as List)
              .map((e) => HotelPhotos.fromJson(e))
              .toList();
        } else {
          emit(MyHotelEmpty(message: responseData['message']));
          return [];
        }
        // // prefs?.setInt('photo_id', responseData['data'][0]['id']);
        // // print(responseData['data'][0]['id']);
        // return (responseData['data'] as List)
        //     .map((e) => HotelPhotos.fromJson(e))
        //     .toList();
      } else {
        emit(MyHotelFailure(message: responseData['message']));
        return [];
      }
    } else {
      emit(MyHotelFailure(message: 'Error fetching hotel photos'));
      return [];
    }
  }

  Future<List<Room>> _processRoomResponse(http.Response response) async {
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['status'] == 1) {
        if (responseData['data'].isEmpty) {
          print('empty22222222');
          emit(MyHotelEmpty(message: responseData['message']));
          return [];
        } else if (responseData['data']['rooms'] is List) {
          return (responseData['data']['rooms'] as List)
              .map((e) => Room.fromJson(e))
              .toList();
        } else {
          emit(MyHotelEmpty(message: responseData['message']));
          return [];
        }
        // List datamap = jsonDecode(response.body)["data"]["rooms"];
        // // prefs?.setInt('room_id', responseData['data']['rooms'][0]['id']);
        // // print(responseData['data']['rooms'][0]['id']);
        // return List<Room>.from(datamap.map((e) => Room.fromJson(e)));
      } else {
        emit(MyHotelEmpty(message: responseData['message']));
        return [];
      }
    } else {
      emit(MyHotelFailure(message: 'Error fetching hotel rooms'));
      return [];
    }
  }
}
