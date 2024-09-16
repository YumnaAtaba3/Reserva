
class Services {
  int status;
  Data data;
  String message;

  Services({
    required this.status,
    required this.data,
    required this.message,
  });

  factory Services.fromJson(Map<String, dynamic> json) {
    return Services(
      status: json['status'],
      data: Data.fromJson(json['data']),
      message: json['message'],
    );
  }
}

class Data {
  List<Service> services;

  Data({
    required this.services,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    List<Service> serviceList = List<Service>.from(json['services'].map((service) => Service.fromJson(service)));
    return Data(services: serviceList);
  }
}

class Service {
  int id;
  String serviceName;

  Service({
    required this.id,
    required this.serviceName,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      serviceName: json['service_name'],
    );
  }
}