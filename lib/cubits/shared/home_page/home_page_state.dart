import 'package:reserva/models/comany_owner/hotel/hotel_home.dart';

abstract class HomePageState {}

class HomePageInitial extends HomePageState {}

class HomePageLoading extends HomePageState {}

class HomePageEmpty extends HomePageState {
  final String message;
  final List<Admin> admin;
  HomePageEmpty({
    required this.message,
    required this.admin,
  });
}

class HomePageSuccessPieChart extends HomePageState {
  final PieData pieChart;
  HomePageSuccessPieChart({required this.pieChart});
}

class HomePageSuccessChartTable extends HomePageState {
  final List<Chart> barChart;
  HomePageSuccessChartTable({required this.barChart});
}

class HomePageSuccessAdmin extends HomePageState {
  final List<Admin> admin;

  HomePageSuccessAdmin({
    required this.admin,
  });
}

class HomePageFailure extends HomePageState {
  final String message;
  HomePageFailure({required this.message});
}

class HomePageSuccess extends HomePageState {
  final PieData pieChart;
  final List<Chart> barChart;
  final List<Admin> admin;

  HomePageSuccess({
    required this.pieChart,
    required this.barChart,
    required this.admin,
  });
}
