import 'package:reserva/models/comany_owner/hotel/hotel_home.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

import 'package:reserva/models/comany_owner/wallet.dart';

abstract class CardState {}

class CardInitial extends CardState {}

class CardLoading extends CardState {}

class CardSuccess extends CardState {
  final TotalIncome card;
  CardSuccess({
    required this.card,
  });
}

class CardFailure extends CardState {
  final String message;
  CardFailure({required this.message});
}

class CardEmpty extends CardState {
  final String message;

  CardEmpty({
    required this.message,
  });
}
