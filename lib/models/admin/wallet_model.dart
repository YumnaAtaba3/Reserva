class Activity {
  int id;

  bool action;
  int amount;
  String transferType;
  String date;
  int walletId;
  String cameFrom;

  Activity({
    required this.id,
   
    required this.action,
    required this.amount,
    required this.transferType,
    required this.date,
    required this.walletId,
    required this.cameFrom,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
     
      action: json['action'] == 1 ? true : false,
      amount: json['amount'],
      transferType: json['transfer_type'],
      date: json['date'],
      walletId: json['wallet_id'],
      cameFrom: json['came_from'],
    );
  }
}
class TotalIncome {
  int totalIncome;

  TotalIncome({required this.totalIncome});

  factory TotalIncome.fromJson(Map<String, dynamic> json) {
    return TotalIncome(totalIncome: json['totoal_income']);
  }
}

class DataPoint {
  int x;
  String y;

  DataPoint({required this.x, required this.y});

  factory DataPoint.fromJson(Map<String, dynamic> json) {
    return DataPoint(x: json['x'], y: json['y']);
  }
}

class TripsFinancialReturn {
  int tripsFinancialReturn;

  TripsFinancialReturn({required this.tripsFinancialReturn});

  factory TripsFinancialReturn.fromJson(Map<String, dynamic> json) {
    return TripsFinancialReturn(tripsFinancialReturn: json['trips_financial_return']);
  }
}


class HotelsFinancialReturn {
  int hotelsFinancialReturn;

  HotelsFinancialReturn({required this.hotelsFinancialReturn});

  factory HotelsFinancialReturn.fromJson(Map<String, dynamic> json) {
    return HotelsFinancialReturn(hotelsFinancialReturn: json['hotels_financial_return']);
  }
}


class FlightsFinancialReturn {
  int flightsFinancialReturn;

  FlightsFinancialReturn({required this.flightsFinancialReturn});

  factory FlightsFinancialReturn.fromJson(Map<String, dynamic> json) {
    return FlightsFinancialReturn(flightsFinancialReturn: json['flights_financial_return']);
  }
}