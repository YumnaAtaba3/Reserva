part of 'new_users_cubit.dart';

@immutable
sealed class NewUsersState {}

final class NewUsersInitial extends NewUsersState {}
class dashboardSuccessNewUsers extends NewUsersState {
  final NewUsers newUsers;
  dashboardSuccessNewUsers({required this.newUsers});
}

class NewUsersLoading extends NewUsersState {}

class NewUsersFailure extends NewUsersState {
  final String message;
     NewUsersFailure({required this.message});
}