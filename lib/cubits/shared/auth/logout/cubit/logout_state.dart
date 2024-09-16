abstract class LogoutState {}

class LogoutInitial extends LogoutState {}

class LogoutSuccess extends LogoutState {
  final String message;

  LogoutSuccess({required this.message});
}

class LogoutLoading extends LogoutState {}

class LogoutFailure extends LogoutState {
  final String message;

  LogoutFailure({required this.message});
}
