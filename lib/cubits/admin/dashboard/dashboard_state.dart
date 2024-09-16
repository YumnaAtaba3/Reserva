part of 'dashboard_cubit.dart';

@immutable
abstract class dashboardState {}

class dashboardInitial extends dashboardState {}

class dashboardLoading extends dashboardState {}

class dashboardEmpty extends dashboardState {
  final String message;

  dashboardEmpty({required this.message});
}


















class dashboardFailure extends dashboardState {
  final String message;
      dashboardFailure({required this.message});
}










class dashboardSuccess extends dashboardState {
  final NewCompanies newCompanies;
  final NewUsers newUsers;
  final TotalReservations totalReservations;
  final List<LastClient> client;
    final List<LastAttraction> Attraction;
      final List<LastFlight> Flight;
  final List<LastHotel> Hotel;
   //  final TotalIncome totalincom;
  dashboardSuccess({
    required this.newCompanies,
    required this.newUsers,
    required this.totalReservations,
    required this.client,
    required this.Attraction,
    required this.Flight,
    required this.Hotel,
    //required this.totalincom,
  });
}