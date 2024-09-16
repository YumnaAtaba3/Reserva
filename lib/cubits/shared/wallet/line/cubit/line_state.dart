import 'package:reserva/models/comany_owner/hotel/hotel_home.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

import 'package:reserva/models/comany_owner/wallet.dart';

abstract class LineState {}

class LineInitial extends LineState {}

class LineLoading extends LineState {}

class LineSuccess extends LineState {
  final List<Line> line;

  LineSuccess({required this.line});
}

class LineFailure extends LineState {
  final String message;
  LineFailure({required this.message});
}

class LineEmpty extends LineState {
  final String message;

  LineEmpty({
    required this.message,
  });
}
