import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

class FlightInfo {
  final String airwayName;

  final City city;

  FlightInfo({
    required this.airwayName,
    required this.city,
  });
  factory FlightInfo.fromJson(Map<String, dynamic> json) {
    return FlightInfo(
      airwayName: json['airway_name'],
      city: City.fromJson(json['city']),
    );
  }
}

class Service {
  final int id;
  final String serviceName;
  final bool enabled;

  Service({
    required this.id,
    required this.serviceName,
    required this.enabled,
  });
  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      serviceName: json['service_name'],
      enabled: json['enabled'],
    );
  }
}

class FromCity {
  final int id;
  final String fromCityName;

  FromCity({
    required this.id,
    required this.fromCityName,
  });

  factory FromCity.fromJson(Map<String, dynamic> json) {
    return FromCity(
      id: json['id'],
      fromCityName: json['from_city_name'],
    );
  }
}

class ToCity {
  final int id;
  final String toCityName;

  ToCity({
    required this.id,
    required this.toCityName,
  });

  factory ToCity.fromJson(Map<String, dynamic> json) {
    return ToCity(
      id: json['id'],
      toCityName: json['to_city_name'],
    );
  }
}

class Flight {
  final int id;
  final City fromCity;
  final City toCity;
  final bool handBag;
  final bool checkedBag;
  final int seatsNum;
  final int airwayId;
  final List<FlightTime> flightTimes;
  final List<FlightClass> flightClasses;

  Flight({
    required this.id,
    required this.fromCity,
    required this.toCity,
    required this.handBag,
    required this.checkedBag,
    required this.seatsNum,
    required this.airwayId,
    required this.flightTimes,
    required this.flightClasses,
  });
  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      id: json['id'],
      fromCity: City.fromJson(json['from_city']),
      toCity: City.fromJson(json['to_city']),
      handBag: json['handBag'],
      checkedBag: json['checkedBag'],
      seatsNum: json['seats_num'],
      airwayId: json['airway_id'],
      flightTimes: json['flight_times'] is List
          ? (json['flight_times'] as List<dynamic>)
              .map((flightTime) => FlightTime.fromJson(flightTime))
              .toList()
          : [],
      flightClasses: (json['flight_classes'] as List<dynamic>)
          .map((flightClass) => FlightClass.fromJson(flightClass))
          .toList(),
    );
  }
}

class FlightClass {
  final int flightClassId;
  final String flightClassName;
  final String seatSelection;

  FlightClass({
    required this.flightClassId,
    required this.flightClassName,
    required this.seatSelection,
  });

  factory FlightClass.fromJson(Map<String, dynamic> json) {
    return FlightClass(
        flightClassId: json['flight_class_id'],
        flightClassName: json['flight_class_name'],
        seatSelection: json['seat_selection']);
  }
}

class FlightTime {
  final int id;
  final String departureDay;
  final String toHour;
  final String fromHour;
  final int adultPrice;
  final int childrenPrice;
  final int flightId;

  FlightTime({
    required this.id,
    required this.departureDay,
    required this.toHour,
    required this.fromHour,
    required this.adultPrice,
    required this.childrenPrice,
    required this.flightId,
  });
  factory FlightTime.fromJson(Map<String, dynamic> json) {
    return FlightTime(
      id: json['id'],
      departureDay: json['departure_day'],
      toHour: json['to_hour'],
      fromHour: json['from_hour'],
      adultPrice: json['adult_price'],
      childrenPrice: json['children_price'],
      flightId: json['flight_id'],
    );
  }
}

class FlightReview {
  final int id;
  final String review;
  final String userName;
  final int flightId;

  FlightReview({
    required this.id,
    required this.review,
    required this.userName,
    required this.flightId,
  });

  factory FlightReview.fromJson(Map<String, dynamic> json) {
    return FlightReview(
      id: json['id'],
      review: json['review'],
      userName: json['user_name'],
      flightId: json['flight_id'],
    );
  }
}
