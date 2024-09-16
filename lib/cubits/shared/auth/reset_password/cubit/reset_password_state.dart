abstract class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordSuccess extends ResetPasswordState {
  final String message;
  final int role;
  ResetPasswordSuccess({required this.message, required this.role});
}

class ResetPasswordLoading extends ResetPasswordState {}

class ResetPasswordValidationFailure extends ResetPasswordState {
  final Map<String, List<dynamic>> errors;
  ResetPasswordValidationFailure({required this.errors});
}

class ResetPasswordFailure extends ResetPasswordState {
  final String message;

  ResetPasswordFailure({required this.message});
}

class ResetPasswordSecure extends ResetPasswordState {}

class ResetPasswordInSecure extends ResetPasswordState {}
