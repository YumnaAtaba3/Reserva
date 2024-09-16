class AttractionDetails {
  String attractionName;
  String openAt;
  String closeAt;
  String about;
  City city;
  AttractionType attractionType;
  List<String> attractionPhotos;

  AttractionDetails({
    required this.attractionName,
    required this.openAt,
    required this.closeAt,
    required this.about,
    required this.city,
    required this.attractionType,
    required this.attractionPhotos,
  });

  factory AttractionDetails.fromJson(Map<String, dynamic> json) {
    return AttractionDetails(
      attractionName: json['attraction_name'],
      openAt: json['open_at'],
      closeAt: json['close_at'],
      about: json['about'],
      city: City.fromJson(json['city']),
      attractionType: AttractionType.fromJson(json['attraction_type']),
      attractionPhotos: List<String>.from(json['attraction_photo']),
    );
  }
}

class City {
  int id;
  String cityName;

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
  int id;
  String attractionTypeName;

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
