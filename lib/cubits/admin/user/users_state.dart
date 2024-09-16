part of 'users_cubit.dart';

@immutable
sealed class UsersState {}

final class UsersInitial extends UsersState {}

class UsersLoadingState extends UsersState {}

class UsersLoadedState extends UsersState {
  final List<User> users;
   final String message;

  UsersLoadedState(this.users,this.message);
}

class UsersEmpty extends UsersState {
  final String message;

  UsersEmpty(this.message);
}



class UsersErrorState extends UsersState {
  final String errorMessage;

  UsersErrorState(this.errorMessage);
}
