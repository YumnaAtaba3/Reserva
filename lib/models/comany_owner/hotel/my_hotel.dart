class HotelInfo {
  final int id;
  final int hotelAdminId;
  final String hotelName;
  final String location;
  final String description;
  final City city;
  final int stars;

  HotelInfo({
    required this.id,
    required this.hotelAdminId,
    required this.hotelName,
    required this.location,
    required this.description,
    required this.city,
    required this.stars,
  });
  factory HotelInfo.fromJson(Map<String, dynamic> json) {
    return HotelInfo(
      id: json['id'],
      hotelAdminId: json['hotel_admin_id'],
      hotelName: json['hotel_name'],
      location: json['location'],
      description: json['description'],
      city: City.fromJson(json['city']),
      stars: json['stars'],
    );
  }
}

class City {
  final int id;
  final String cityName;

  City({
    required this.id,
    required this.cityName,
  });
  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      cityName: json['city_name'],
    );
  }
}

class HotelReview {
  final int id;
  final String review;
  final String userName;
  final int hotelId;

  HotelReview({
    required this.id,
    required this.review,
    required this.userName,
    required this.hotelId,
  });

  factory HotelReview.fromJson(Map<String, dynamic> json) {
    return HotelReview(
      id: json['id'],
      review: json['review'],
      userName: json['user_name'],
      hotelId: json['hotel_id'],
    );
  }
}

class Facility {
  final int id;
  final String facilityName;
  final bool enabled;

  Facility({
    required this.id,
    required this.facilityName,
    required this.enabled,
  });
  factory Facility.fromJson(Map<String, dynamic> json) {
    return Facility(
      id: json['id'],
      facilityName: json['facility_name'],
      enabled: json['enabled'],
    );
  }
}

class Feature {
  final int id;
  final String featureName;
  final bool enabled;

  Feature({
    required this.id,
    required this.featureName,
    required this.enabled,
  });
  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      id: json['id'],
      featureName: json['feature_name'],
      enabled: json['enabled'],
    );
  }
}

class RoomType {
  final int id;
  final String roomType;

  RoomType({
    required this.id,
    required this.roomType,
  });

  factory RoomType.fromJson(Map<String, dynamic> json) {
    return RoomType(
      id: json['id'],
      roomType: json['room_type'],
    );
  }
}

//model for get all filters for the key
class RoomTypeModel {
  final int id;
  final String roomTypeName;

  RoomTypeModel({
    required this.id,
    required this.roomTypeName,
  });

  factory RoomTypeModel.fromJson(Map<String, dynamic> json) {
    return RoomTypeModel(
      id: json['id'],
      roomTypeName: json['room_type_name'],
    );
  }
}

class HotelPhotos {
  final int id;
  final String photo;
  HotelPhotos({
    required this.id,
    required this.photo,
  });

  factory HotelPhotos.fromJson(Map<String, dynamic> json) {
    return HotelPhotos(
      id: json['id'],
      photo: json['photo'],
    );
  }
}

class Room {
  final int id;
  final int hotelId;
  final RoomType roomType;
  final int beds;
  final int sleeps;
  final String details;
  final String priceForNight;
  final List<String> roomPhotos;
  final List<Feature> roomFeatures;

  Room({
    required this.id,
    required this.hotelId,
    required this.roomType,
    required this.beds,
    required this.sleeps,
    required this.details,
    required this.priceForNight,
    required this.roomPhotos,
    required this.roomFeatures,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      hotelId: json['hotel_id'],
      roomType: RoomType.fromJson(json['room_type']),
      beds: json['beds'],
      sleeps: json['sleeps'],
      details: json['details'],
      priceForNight: json['price_for_night'],
      roomPhotos: List<String>.from(json['room_photos']),
      roomFeatures: (json['room_features'] as List<dynamic>)
          .map((feature) => Feature.fromJson(feature))
          .toList(),
    );
  }
}











// class Room {
//   final int id;
//   final int hotelId;
//   final RoomType roomType;
//   final int beds;
//   final int sleeps;
//   final String details;
//   final String priceForNight;
//   final List<dynamic> roomPhotos;
//   final List<dynamic> roomFeatures;
//   Room({
//     required this.id,
//     required this.hotelId,
//     required this.roomType,
//     required this.beds,
//     required this.sleeps,
//     required this.details,
//     required this.priceForNight,
//     required this.roomPhotos,
//     required this.roomFeatures,
//   });
//   factory Room.fromJson(Map<String, dynamic> json) {
//     return Room(
//       id: json['id'],
//       hotelId: json['hotel_id'],
//       roomType: RoomType.fromJson(json['room_type']),
//       beds: json['beds'],
//       sleeps: json['sleeps'],
//       details: json['details'],
//       priceForNight: json['price_for_night'],
//       roomPhotos: json['room_photos'],
//       roomFeatures: (json['room_features'] as List)
//           .map((feature) => Feature.fromJson(feature))
//           .toList(),
//     );
//   }
  // factory Room.fromJson(Map<String, dynamic> json) {
  //   return Room(
  //     id: json['id'],
  //     hotelId: json['hotel_id'],
  //     roomType: RoomType.fromJson(json['room_type']),
  //     beds: json['beds'],
  //     sleeps: json['sleeps'],
  //     details: json['details'],
  //     priceForNight: json['price_for_night'],
  //     roomPhotos: json['room_photos'] is List ? json['room_photos'] : [],
  //     roomFeatures: json['room_features'] is List
  //         ? (json['room_features'] as List)
  //             .map((feature) => Feature.fromJson(feature))
  //             .toList()
  //         : [],
  //   );
  // }
//}
//   factory Room.fromJson(Map<String, dynamic> json) {
//     return Room(
//       id: json['id'],
//       hotelId: json['hotel_id'],
//       roomType: RoomType.fromJson(json['room_type']),
//       beds: json['beds'],
//       sleeps: json['sleeps'],
//       details: json['details'],
//       priceForNight: json['price_for_night'],
//       roomPhotos: json['room_photos'] is List
//           ? json['room_photos']
//           : [json['room_photos']],
//       roomFeatures: json['room_features'] is List
//           ? (json['room_features'] as List)
//               .map((feature) => Feature.fromJson(feature))
//               .toList()
//           : [
//               Feature(id: 0, featureName: json['room_features'], enabled: false)
//             ],
//     );
//   }
// }



// class Room {
//   final int id;
//   final int hotelId;
//   final RoomType roomType;
//   final int beds;
//   final int sleeps;
//   final String details;
//   final int priceForNight;
//   final List<String> roomPhotos;
//   final List<Feature> roomFeatures;

//   Room({
//     required this.id,
//     required this.hotelId,
//     required this.roomType,
//     required this.beds,
//     required this.sleeps,
//     required this.details,
//     required this.priceForNight,
//     required this.roomPhotos,
//     required this.roomFeatures,
//   });

//   factory Room.fromJson(Map<String, dynamic> json) {
//     return Room(
//       id: json['id'],
//       hotelId: json['hotel_id'],
//       roomType: RoomType.fromJson(json['room_type']),
//       beds: json['beds'],
//       sleeps: json['sleeps'],
//       details: json['details'],
//       priceForNight: int.parse(json['price_for_night']),
//       roomPhotos: json['room_photos'] is List
//           ? (json['room_photos'] as List).cast<String>()
//           : json['room_photos'] != null && json['room_photos'].isNotEmpty
//               ? [json['room_photos']]
//               : [],
//       roomFeatures: json['room_features'] is List
//           ? (json['room_features'] as List)
//               .map((feature) => Feature.fromJson(feature))
//               .toList()
//           : [],
//     );
//   }
// }

// class Room {
//   final int id;
//   final int hotelId;
//   final RoomType roomType;
//   final int beds;
//   final int sleeps;
//   final String details;
//   final int priceForNight;
//   final List<dynamic> roomPhotos;
//   final List<dynamic> roomFeatures;

//   Room({
//     required this.id,
//     required this.hotelId,
//     required this.roomType,
//     required this.beds,
//     required this.sleeps,
//     required this.details,
//     required this.priceForNight,
//     required this.roomPhotos,
//     required this.roomFeatures,
//   });

//   factory Room.fromJson(Map<String, dynamic> json) {
//     return Room(
//       id: json['id'],
//       hotelId: json['hotel_id'],
//       roomType: RoomType.fromJson(json['room_type']),
//       beds: json['beds'],
//       sleeps: json['sleeps'],
//       details: json['details'],
//       priceForNight: int.parse(json['price_for_night']),
//       roomPhotos: json['room_photos'] is List
//           ? (json['room_photos'] as List).cast<String>()
//           : [],
//       roomFeatures: json['room_features'] is List
//           ? (json['room_features'] as List)
//               .map((feature) => Feature.fromJson(feature))
//               .toList()
//           : [],
//     );
//   }
// }
