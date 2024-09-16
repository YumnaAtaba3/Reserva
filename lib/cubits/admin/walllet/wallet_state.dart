part of 'wallet_cubit.dart';

@immutable
sealed class WalletState {}

final class WalletInitial extends WalletState {}
class WalletLoading extends WalletState {}

class WalletActivitySuccess extends WalletState {
  final List<Activity>? activ;

  WalletActivitySuccess({
    required this.activ,
  });
}

class WalletCardSuccess extends WalletState {
  final TotalIncome? card;
  WalletCardSuccess({
    required this.card,
  });
}
class WalletTripsFinancialReturnSuccess extends WalletState {
  final TripsFinancialReturn? card2;
  WalletTripsFinancialReturnSuccess({
    required this.card2,
  });
}
class WalletHotelsFinancialReturnSuccess extends WalletState {
  final HotelsFinancialReturn?  card3;
  WalletHotelsFinancialReturnSuccess({
    required this.card3,
  });
}
class WalletFlightsFinancialReturnSuccess extends WalletState {
  final FlightsFinancialReturn? card4;
  WalletFlightsFinancialReturnSuccess({
    required this.card4,
  });
}

class WalletLineChartSuccess extends WalletState {
  final List<DataPoint>? line;

  WalletLineChartSuccess({required this.line});
}

class WalletFailure extends WalletState {
  final String message;
  WalletFailure({required this.message});
}

class WalletEmpty extends WalletState {
  final String message;

  WalletEmpty({
    required this.message,
  });
}

class WalletSuccess extends WalletState {
  final TotalIncome card1;
  final TripsFinancialReturn card2;
  final HotelsFinancialReturn  card3;
  final FlightsFinancialReturn card4;
  final List<Activity> activ;

  final List<DataPoint> line;

  WalletSuccess({
    required this.card1,
    required this.card2,
    required this.card3,
    required this.card4,
    required this.activ,
    required this.line,
  });
}