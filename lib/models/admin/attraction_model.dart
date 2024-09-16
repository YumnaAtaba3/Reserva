// class Attraction {
//  int id;
//   String attractionName;
//   String openAt;
//   String closeAt;
//   String about;
//   City city;
//   AttractionType attractionType;
//   String attractionPhoto;

//   Attraction({
//    required this.id,
//     required this.attractionName,
//     required this.openAt,
//     required this.closeAt,
//     required this.about,
//     required this.city,
//     required this.attractionType,
//     required this.attractionPhoto,
//   });

//   factory Attraction.fromJson(Map<String, dynamic> json) {
//     return Attraction(
//      id: json['id'],
//       attractionName: json['attraction_name'],
//       openAt: json['open_at'],
//       closeAt: json['close_at'],
//       about: json['about'],
//       city: City.fromJson(json['city']),
//       attractionType: AttractionType.fromJson(json['attraction_type']),
//       attractionPhoto: json['attraction_photo'],
//     );
//   }
// }

// class City {
//   int id;
//   String cityName;

//   City({
//     required this.id,
//     required this.cityName,
//   });

//   factory City.fromJson(Map<String, dynamic> json) {
//     return City(
//       id: json['id'],
//       cityName: json['city_name'],
//     );
//   }
// }

// class AttractionType {
//   int id;
//   String attractionTypeName;

//   AttractionType({
//     required this.id,
//     required this.attractionTypeName,
//   });

//   factory AttractionType.fromJson(Map<String, dynamic> json) {
//     return AttractionType(
//       id: json['id'],
//       attractionTypeName: json['attraction_type_name'],
//     );
//   }
// }
class Attraction {
  final int id;
  final String attractionName;
  final String openAt;
  final String closeAt;
  final String about;
  final City city;
  final AttractionType attractionType;
  final String attractionPhoto;

  Attraction({
    required this.id,
    required this.attractionName,
    required this.openAt,
    required this.closeAt,
    required this.about,
    required this.city,
    required this.attractionType,
    required this.attractionPhoto,
  });

  factory Attraction.fromJson(Map<String, dynamic> json) {
    return Attraction(
      id: json['id'],
      attractionName: json['attraction_name'],
      openAt: json['open_at'],
      closeAt: json['close_at'],
      about: json['about'],
      city: City.fromJson(json['city']),
      attractionType: AttractionType.fromJson(json['attraction_type']),
      attractionPhoto: json['attraction_photo'],
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

class AttractionType {
  final int id;
  final String attractionTypeName;

  AttractionType({
    required this.id,
    required this.attractionTypeName,
  });

  factory AttractionType.fromJson(Map<String, dynamic> json) {
    return AttractionType(
      id: json['id'],
      attractionTypeName: json['attraction_type_name'],
    );
  }

}