part of 'newcompanies_cubit.dart';

@immutable
sealed class NewcompaniesState {}

final class NewcompaniesInitial extends NewcompaniesState {}

class dashboardSuccessNewCompanies extends NewcompaniesState {
  final NewCompanies newCompanies;
dashboardSuccessNewCompanies({required this.newCompanies});
}

class NewcompaniesLoading extends NewcompaniesState {}

class NewcompaniesFailure extends NewcompaniesState {
  final String message;
      NewcompaniesFailure({required this.message});
}