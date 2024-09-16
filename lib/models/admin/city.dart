


class Cities {
  int status;
  Data data;
  String message;

  Cities({
    required this.status,
    required this.data,
    required this.message,
  });

  factory Cities.fromJson(Map<String, dynamic> json) {
    return Cities(
      status: json['status'],
      data: Data.fromJson(json['data']),
      message: json['message'],
    );
  }
}

class Data {
  List<City> cities;

  Data({
    required this.cities,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    List<City> cityList = List<City>.from(json['cities'].map((city) => City.fromJson(city)));
    return Data(cities: cityList);
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
      cityName: json['cityName'],
    );
  }
}
