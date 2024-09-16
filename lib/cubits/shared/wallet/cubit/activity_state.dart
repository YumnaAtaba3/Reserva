import 'package:reserva/models/comany_owner/hotel/hotel_home.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';
import 'package:reserva/models/comany_owner/wallet.dart';

abstract class ActivityState {}

class ActivityInitial extends ActivityState {}

class ActivityLoading extends ActivityState {}

class ActivitySuccess extends ActivityState {
  final List<Activity> activ;

  ActivitySuccess({
    required this.activ,
  });
}

class ActivityCardSuccess extends ActivityState {
  final TotalIncome card;
  ActivityCardSuccess({
    required this.card,
  });
}

class ActivityLineChartSuccess extends ActivityState {
  final List<Line> line;

  ActivityLineChartSuccess({required this.line});
}

class ActivityFailure extends ActivityState {
  final String message;
  ActivityFailure({required this.message});
}

class ActivityEmpty extends ActivityState {
  final String message;

  ActivityEmpty({
    required this.message,
  });
}

// class ActivitySuccess extends ActivityState {
//   final TotalIncome card;
//   final List<Activity> activ;
//   final List<Line> line;

//   ActivitySuccess({
//     required this.card,
//     required this.activ,
//     required this.line,
//   });
// }
