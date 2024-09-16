abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {
  final String message;
  final int role_id;

  LoginSuccess({required this.message, required this.role_id});
}

class LoginLoading extends LoginState {}

class LoginValidationFailure extends LoginState {
  final Map<String, List<dynamic>> errors;
  LoginValidationFailure({required this.errors});
}

class LoginFailure extends LoginState {
  final String message;

  LoginFailure({required this.message});
}

class LoginSecure extends LoginState {}

class LoginInSecure extends LoginState {}
