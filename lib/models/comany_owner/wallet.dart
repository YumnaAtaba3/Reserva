class Activity {
  final int id;
  final bool action;
  final int amount;
  final String date;
  final String transfer_type;

  Activity({
    required this.id,
    required this.action,
    required this.amount,
    required this.date,
    required this.transfer_type,
  });
  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      action: json['action'] == 1 ? true : false,
      amount: json['amount'],
      date: json['date'],
      transfer_type: json['transfer_type'],
    );
  }
}

class Line {
  final int x;
  final String y;
  Line({
    required this.x,
    required this.y,
  });
  factory Line.fromJson(Map<String, dynamic> json) {
    return Line(
      x: json['x'],
      y: json['y'],
    );
  }
}

class TotalIncome {
  int income;

  TotalIncome({
    required this.income,
  });

  factory TotalIncome.fromJson(Map<String, dynamic> json) => TotalIncome(
        income: json["totoal_income"],
      );
}
