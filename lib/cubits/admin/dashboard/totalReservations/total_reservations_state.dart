part of 'total_reservations_cubit.dart';

@immutable
sealed class TotalReservationsState {}

final class TotalReservationsInitial extends TotalReservationsState {}
class dashboardSuccessTotalReservations extends TotalReservationsState {
  final TotalReservations totalReservations;

  dashboardSuccessTotalReservations({
    required this.totalReservations,
  });
}

class TotalReservationsLoading extends TotalReservationsState {}

class TotalReservationsFailure extends TotalReservationsState {
  final String message;
     TotalReservationsFailure({required this.message});
}