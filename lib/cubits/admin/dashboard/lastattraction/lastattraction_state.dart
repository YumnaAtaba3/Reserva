part of 'lastattraction_cubit.dart';

@immutable
sealed class LastattractionState {}

final class LastattractionInitial extends LastattractionState {}
class LastAttractionloading extends LastattractionState {}
class LastAttractionFailure extends LastattractionState {
  final String message;
      LastAttractionFailure({required this.message});
}

class EmptyLastAttraction extends LastattractionState {
  final String message;

  EmptyLastAttraction({
    required this.message,
  });
}

class dashboardSuccessLastAttraction extends LastattractionState {
  final List<LastAttraction> Attraction;

  dashboardSuccessLastAttraction({
    required this.Attraction,
  });
}