abstract class CheckCodeState {}

class CheckCodeInitial extends CheckCodeState {}

class CheckCodeSuccess extends CheckCodeState {
  final String message;

  CheckCodeSuccess({
    required this.message,
  });
}

class CheckCodeResend extends CheckCodeState {
  final String message;

  CheckCodeResend({
    required this.message,
  });
}

class CheckCodeLoading extends CheckCodeState {}

class CheckCodeValidationFailure extends CheckCodeState {
  final Map<String, List<dynamic>> errors;
  CheckCodeValidationFailure({required this.errors});
}

class CheckCodeFailure extends CheckCodeState {
  final String message;

  CheckCodeFailure({required this.message});
}
