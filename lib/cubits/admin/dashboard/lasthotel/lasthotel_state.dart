part of 'lasthotel_cubit.dart';

@immutable
sealed class LasthotelState {}

final class LasthotelInitial extends LasthotelState {}
class LastHotelloading extends LasthotelState {}
class LastHotelFailure extends LasthotelState {
  final String message;
      LastHotelFailure({required this.message});
}

class EmptyLastHotel extends LasthotelState {
  final String message;

  EmptyLastHotel({
    required this.message,
  });
}

class dashboardSuccessLastHotel extends LasthotelState {
  final List<LastHotel> Hotel;

  dashboardSuccessLastHotel({
    required this.Hotel,
  });
}