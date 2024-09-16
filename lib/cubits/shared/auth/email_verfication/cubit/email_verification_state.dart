abstract class EmailVerificationState {}

class EmailVerificationInitial extends EmailVerificationState {}

class EmailVerificationSuccess extends EmailVerificationState {
  final String message;
  final int role_email;

  EmailVerificationSuccess({required this.message, required this.role_email});
}

class EmailVerificationLoading extends EmailVerificationState {}

class EmailVerificationValidationFailure extends EmailVerificationState {
  final Map<String, List<dynamic>> errors;
  EmailVerificationValidationFailure({required this.errors});
}

class EmailVerificationFailure extends EmailVerificationState {
  final String message;

  EmailVerificationFailure({required this.message});
}
