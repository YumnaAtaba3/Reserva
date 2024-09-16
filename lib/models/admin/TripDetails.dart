class TripDetailseResponse {
  int status;
  TripData data;
  String message;

 TripDetailseResponse({required this.status, required this.data, required this.message});

  factory TripDetailseResponse.fromJson(Map<String, dynamic> json) {
    return TripDetailseResponse(
      status: json['status'],
      data: TripData.fromJson(json['data']),
      message: json['message'],
    );
  }
}

class TripData {
  TripDetails tripDetails;
  List<String> tripPhotos;
  List<TripServiceType> tripServicesType;

  TripData({required this.tripDetails, required this.tripPhotos, required this.tripServicesType});

  factory TripData.fromJson(Map<String, dynamic> json) {
    List<String> tripPhotos = List<String>.from(json['trip_photos']);
    List<dynamic> tripServicesTypeJson = json['trip_services_type'];
    List<TripServiceType> tripServicesType = tripServicesTypeJson.map((data) => TripServiceType.fromJson(data)).toList();

    return TripData(
      tripDetails: TripDetails.fromJson(json['trip']),
      tripPhotos: tripPhotos,
      tripServicesType: tripServicesType,
    );
  }
}

class TripDetails {
  int id;
  String tripName;
  String price;
  String destination;
  String requiredAge;
  int numberOfDays;
  int maxNumberOfPeople;
  String tripDetails;
  String tripProgramme;
  String fromDate;
  String toDate;
  String createdAt;
  String updatedAt;

  TripDetails({
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
    required this.createdAt,
    required this.updatedAt,
  });

  factory TripDetails.fromJson(Map<String, dynamic> json) {
    return TripDetails(
      id: json['id'],
      tripName: json['trip_name'],
      price: json['price'],
      destination: json['destination'],
      requiredAge: json['required_age'],
      numberOfDays: json['number_of_days'],
      maxNumberOfPeople: json['max_number_of_people'],
      tripDetails: json['trip_details'],
      tripProgramme: json['trip_programme'],
      fromDate: json['from_date'],
      toDate: json['to_date'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class TripServiceType {
  int id;
  String serviceName;

  TripServiceType({required this.id, required this.serviceName});

  factory TripServiceType.fromJson(Map<String, dynamic> json) {
    return TripServiceType(
      id: json['id'],
      serviceName: json['service_name'],
    );
  }
}