/*class Home {
  final int status;
  final List<Datum> data;
  final String message;

  Home({
    required this.status,
    required this.data,
    required this.message,
  });

  factory Home.fromJson(Map<String, dynamic> json) {
    return Home(
      status: json['status'],
      data: (json['data'] as List<dynamic>)
          .map((datum) => Datum.fromJson(datum))
          .toList(),
      message: json['message'],
    );
  }
}*/

/*class Datum {
  final HotelShowAdmin hotelShowAdmin;
  final HotelLastForYear hotelLastForYear;
  final HotelReservationChartTable hotelReservationChartTable;

  Datum({
    required this.hotelShowAdmin,
    required this.hotelLastForYear,
    required this.hotelReservationChartTable,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      hotelShowAdmin: HotelShowAdmin.fromJson(json['hotelShowAdmin']),
      hotelLastForYear: HotelLastForYear.fromJson(json['hotelLastForYear']),
      hotelReservationChartTable: HotelReservationChartTable.fromJson(
          json['hotelReservationChartTable']),
    );
  }
}*/

class PieData {
  final Map<String, int> yearValue;
  final String message;

  PieData({
    required this.yearValue,
    required this.message,
  });

  factory PieData.fromJson(Map<String, dynamic> json) {
    return PieData(
      yearValue: Map<String, int>.from(json['data']),
      message: json['message'],
    );
  }
}

/*class HotelLastForYear {
  final Map<String, int> yearReservationsCount;
  final String message;

  HotelLastForYear({
    required this.yearReservationsCount,
    required this.message,
  });

  factory HotelLastForYear.fromJson(Map<String, dynamic> json) {
    return HotelLastForYear(
      yearReservationsCount:
          Map<String, int>.from(json['yearReservationsCount']),
      message: json['message'],
    );
  }
}*/

/*class HotelReservationChartTable {
  final List<YearTopMothRe> yearTopMothRes;
  final String message;

  HotelReservationChartTable({
    required this.yearTopMothRes,
    required this.message,
  });

  factory HotelReservationChartTable.fromJson(Map<String, dynamic> json) {
    return HotelReservationChartTable(
      yearTopMothRes: (json['yearTopMothRes'] as List<dynamic>)
          .map((yearTopMonthData) => YearTopMothRe.fromJson(yearTopMonthData))
          .toList(),
      message: json['message'],
    );
  }
}*/

class Chart {
  final int year;
  final Map<String, int> months;

  Chart({
    required this.year,
    required this.months,
  });
  factory Chart.fromJson(Map<String, dynamic> json) {
    return Chart(
      year: json['year'] as int,
      months: Map<String, int>.from(json['months'] as Map<String, dynamic>),
    );
  }
  /* factory Chart.fromJson(Map<String, dynamic> json) {
    return Chart(
      year: json['year'],
      months: Map<String, int>.from(json['months']),
    );
  }*/
}

/*class HotelShowAdmin {
  final List<Admin> admin;
  final String message;

  HotelShowAdmin({
    required this.admin,
    required this.message,
  });

  factory HotelShowAdmin.fromJson(Map<String, dynamic> json) {
    return HotelShowAdmin(
      admin: (json['admin'] as List<dynamic>)
          .map((adminData) => Admin.fromJson(adminData))
          .toList(),
      message: json['message'],
    );
  }
}*/

class Admin {
  final int id;
  final String email;
  final String companyName;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  Admin({
    required this.id,
    required this.email,
    required this.companyName,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });
  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['id'],
      email: json['email'],
      companyName: json['company_name'],
      name: json['name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}


  /*factory Admin.fromJson(Map<String, dynamic> json) {
    final adminData = json['hotelShowAdmin']['admin'][0];
    return Admin(
      id: adminData['id'],
      email: adminData['email'],
      companyName: adminData['company_name'],
      name: adminData['name'],
      createdAt: DateTime.parse(adminData['created_at']),
      updatedAt: DateTime.parse(adminData['updated_at']),
    );
  }*/