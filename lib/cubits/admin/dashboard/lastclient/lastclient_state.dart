part of 'lastclient_cubit.dart';

@immutable
sealed class LastclientState {}

final class LastclientInitial extends LastclientState {}
class dashboardSuccessLastClient extends LastclientState {
  final List<LastClient> client;

  dashboardSuccessLastClient({
    required this.client,
  });
}




class EmptyLastClient extends LastclientState {
  final String message;

  EmptyLastClient({
    required this.message,
  });
}




class LastClientloading extends LastclientState {}
class LastClientFailure extends LastclientState {
  final String message;
      LastClientFailure({required this.message});
}





