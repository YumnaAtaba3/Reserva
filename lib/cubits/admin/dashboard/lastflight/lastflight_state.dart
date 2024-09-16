part of 'lastflight_cubit.dart';

@immutable
sealed class LastflightState {}

final class LastflightInitial extends LastflightState {}
class dashboardSuccessLastFlight extends LastflightState {
  final List<LastFlight> Flight;

  dashboardSuccessLastFlight({
    required this.Flight,
  });
}

class EmptyLastFlight extends LastflightState {
  final String message;

  EmptyLastFlight({
    required this.message,
  });
}

class Lastflightloading extends LastflightState {}
class LastflightFailure extends LastflightState{
  final String message;
      LastflightFailure({required this.message});
}