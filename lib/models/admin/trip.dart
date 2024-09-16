

import 'package:reserva/models/admin/service.dart';

class Trip {
  final int id;
  final String tripName;
  final double price;
  final String destination;
  final String requiredAge;
  final int numberOfDays;
  final int maxNumberOfPeople;
  final String tripDetails;
  final String tripProgramme;
  final String fromDate;
  final String toDate;
  final List<String> tripPhotos;
  final List<Service> tripServices;

  Trip({
    required this.id,
    required this.tripName,
    required this.price,
    required this.destination,
    required this.requiredAge,
    required this.numberOfDays,
    required this.maxNumberOfPeople,
    required this.tripDetails,
    required this.tripProgramme,
    required this.fromDate,
    required this.toDate,
    required this.tripPhotos,
    required this.tripServices,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    var tripPhotosList = json['trip_photos'].cast<String>();
    var tripServicesList = (json['trip_services_type'] as List)
        .map((service) => Service.fromJson(service))
        .toList();

    return Trip(
      id: json['id'],
      tripName: json['trip_name'],
      price: double.parse(json['price']),
      destination: json['destination'],
      requiredAge: json['required_age'],
      numberOfDays: json['number_of_days'],
      maxNumberOfPeople: json['max_number_of_people'],
      tripDetails: json['trip_details'],
      tripProgramme: json['trip_programme'],
      fromDate: json['from_date'],
      toDate: json['to_date'],
      tripPhotos: tripPhotosList,
      tripServices: tripServicesList,
    );
  }
}

class TripService {
  final int id;
  final String serviceName;

  TripService({
    required this.id,
    required this.serviceName,
  });

  factory TripService.fromJson(Map<String, dynamic> json) {
    return TripService(
      id: json['id'],
      serviceName: json['service_name'],
    );
  }
}





// class TripPhoto {
//   int id;
//   String photo;

//   TripPhoto({required this.id, required this.photo});

//   factory TripPhoto.fromJson(Map<String, dynamic> json) {
//     return TripPhoto(
//       id: json['id'],
//       photo: json['photo'] as String, // Assuming 'photo' is a URL string
//     );
//   }
// }

// class Trip {
//   int id;
//   String tripName;
//   String fromDate;
//   String toDate;
//   String destination;
//   String price;
//   String requiredAge;
//   int numberOfDays;
//   int maxNumberOfPeople;
//   String tripDetails;
//   String tripProgramme;
//   String createdAt;
//   String updatedAt;
//   List<TripPhoto> tripPhotos;

//   Trip({
//     required this.id,
//     required this.tripName,
//     required this.fromDate,
//     required this.toDate,
//     required this.destination,
//     required this.tripPhotos,
//     required this.price,
//     required this.maxNumberOfPeople,
//     required this.numberOfDays,
//     required this.requiredAge,
//     required this.tripProgramme,
//     required this.tripDetails,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory Trip.fromJson(Map<String, dynamic> json) {
//     var photosList = json['trip_photos'].toList();
//     List<TripPhoto> photos = photosList.map((photo) => TripPhoto(id: 0, photo: photo)).toList();

//     return Trip(
//       id: json['id'],
//       tripName: json['trip_name'],
//       fromDate: json['from_date'],
//       toDate: json['to_date'],
//       destination: json['destination'],
//       tripPhotos: photos,
//       price: json['price'],
//       tripDetails: json['trip_details'],
//       tripProgramme: json['trip_programme'],
//       maxNumberOfPeople: json['max_number_of_people'],
//       numberOfDays: json['number_of_days'],
//       requiredAge: json['required_age'],
//       createdAt: json['from_date'],
//       updatedAt: json['to_date'],
//     );
//   }
// }
// // import 'dart:convert';

// class TripResponse {
//   int status;
//   List<Trip> data;
//   String message;

//   TripResponse({required this.status, required this.data, required this.message});

//   factory TripResponse.fromJson(Map<String, dynamic> json) {
//     var tripsList = json['data'] as List;
//     List<Trip> trips = tripsList.map((trip) => Trip.fromJson(trip)).toList();

//     return TripResponse(
//       status: json['status'],
//       data: trips,
//       message: json['message'],
//     );
//   }
// }

// class Trip {
//   int id;
//   String tripName;
//   String fromDate;
//   String toDate;
//   String destination;
//   String price;
//   String requiredAge;
//   int numberOfDays;
//   int maxNumberOfPeople;
//   String tripDetails;
//   String tripProgramme;
//   String createdAt;
//   String updatedAt;
//   List<TripPhoto> tripPhotos;

//   Trip({
//     required this.id,
//     required this.tripName,
//     required this.fromDate,
//     required this.toDate,
//     required this.destination,
//     required this.tripPhotos,
//     required this.price,
//     required this.maxNumberOfPeople,
//     required this.numberOfDays,
//     required this .requiredAge,
//     required this.tripProgramme,
//     required this.tripDetails,
//     required this.createdAt,

//     required this.updatedAt
//   });

//   factory Trip.fromJson(Map<String, dynamic> json) {
//     var photosList = json['trip_photos'] as List;
//     List<TripPhoto> photos = photosList.map((photo) => TripPhoto.fromJson(photo)).toList();

//     return Trip(
//       id: json['id'],
//       tripName: json['trip_name'],
//       fromDate: json['from_date'],
//       toDate: json['to_date'],
//       destination: json['destination'],
//       tripPhotos: photos,
//       price: json['price'],
//       tripDetails: json['tripDetails'],
//       tripProgramme: json['tripProgramme'],
//       maxNumberOfPeople :json['maxNumberOfPeople'],
//       numberOfDays :json['numberOfDays'],
//       requiredAge :json['requiredAge'],
//       createdAt :json['createdAt'],
//       updatedAt : json['updatedAt']
//     );
//   }
// }

// class TripPhoto {
//   int id;
//   String photo;

//   TripPhoto({required this.id, required this.photo});

// //   factory TripPhoto.fromJson(Map<String, dynamic> json) {
// //     return TripPhoto(
// //       id: json['id'],
// //       photo: json['photo'],
// //     );
// //   }
// // }
// factory TripPhoto.fromJson(Map<String, dynamic> json) {
//   return TripPhoto(
//     id: json['id'],
//     photo: json['photo'] is Map<String, dynamic> ? json['photo']['url'] : json['photo'], // Assuming 'photo' is a URL string
//   );
// }}