import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:reserva/cubits/admin/dashboard/dashboard_cubit.dart';
import 'package:reserva/cubits/admin/dashboard/newUser/new_users_cubit.dart';
import 'package:reserva/cubits/admin/dashboard/newcompanies/newcompanies_cubit.dart';
import 'package:reserva/cubits/admin/dashboard/totalReservations/total_reservations_cubit.dart';
import 'package:reserva/models/admin/dashboard_model.dart';
import 'package:reserva/cubits/admin/walllet/wallet_cubit.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class card_page extends StatelessWidget {
  final NewCompanies newCompanies;
  final TotalReservations totalReservations;
  final NewUsers newUsers;
  card_page({super.key,
   required this.newCompanies, required this.totalReservations,required this.newUsers
   });


  List<ChartData> chartData = [
    ChartData('Group A', 10, Color.fromARGB(255, 54, 130, 244)),
    ChartData('Group B', 20, Color.fromARGB(255, 175, 196, 213)),
    ChartData('Group C', 30, Colors.blue),
  ];

  Widget build(BuildContext context) {
    BlocProvider.of<WalletCubit>(context).getIncome();
   // BlocProvider.of<WalletCubit>(context).getWalletData();
//  BlocProvider.of<NewUsersCubit>(context).shownewuser();
//   BlocProvider.of<NewcompaniesCubit>(context).shownewcompanies();
//    BlocProvider.of<TotalReservationsCubit>(context).showtotalReservations();
    return Row(
      children: [


        Expanded(
        child: 
        //  BlocBuilder<NewcompaniesCubit, NewcompaniesState>(
        //     builder: (context, state) {
        //       if (state is NewcompaniesLoading) {
        //         return Center(child: CircularProgressIndicator());
        //       } else if (state is NewcompaniesFailure) {
        //         return Container(
        //           child: Text(state.message.toString()),
        //         );
        //       } else if (state is dashboardSuccessNewCompanies) {
        //         return
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: 100,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.home_outlined,
                        size: 50,
                        color: Colors.blue[300],
                      ),
                      SizedBox(width: 100),
                      _buildChart(chartData),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'New Companies:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' ${newCompanies.newCompanies.toString()}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //   }
          //     return Container(); // Default return if none of the states match
          //   },
          // ),
        ),


        Expanded(
          child: 
          //  BlocBuilder<TotalReservationsCubit, TotalReservationsState>(
          //   builder: (context, state) {
          //     if (state is TotalReservationsLoading) {
          //       return Center(child: CircularProgressIndicator());
          //     } else if (state is TotalReservationsFailure) {
          //       return Container(
          //         child: Text(state.message.toString()),
          //       );
          //     } else if (state is dashboardSuccessTotalReservations) {
          //       return
          
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: 100,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.flight_rounded,
                        size: 50,
                        color: Colors.blue[300],
                      ),
                      SizedBox(width: 100),
                      _buildChart(chartData),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Reservations',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' ${totalReservations.totalFlightReservations.toString()}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ) ),
          //   }
          //     return Container(); // Default return if none of the states match
          //   },
          // ),
        ),




        Expanded(
          child:
            // BlocBuilder<NewUsersCubit, NewUsersState>(
            // builder: (context, state) {
            //   if (state is NewUsersLoading) {
            //     return Center(child: CircularProgressIndicator());
            //   } else if (state is NewUsersFailure) {
            //     return Container(
            //       child: Text(state.message.toString()),
            //     );
            //   } else if (state is dashboardSuccessNewUsers) {
            //     return
          
          
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: 100,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.blue[300],
                      ),
                      SizedBox(width: 100),
                      _buildChart(chartData),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'New Users:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 125),
                      Text(
                        ' ${newUsers.newClients.toString()}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ) ),
           // }
          //     return Container(); // Default return if none of the states match
          //   },
          // ),
        ),






        Expanded(
          child: BlocBuilder<WalletCubit, WalletState>(
            builder: (context, state) {
              if (state is WalletLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is WalletFailure) {
                return Container(
                  child: Text(state.message.toString()),
                );
              } else if (state is WalletCardSuccess) {
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: 100,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.attach_money,
                              size: 50,
                              color: Colors.blue[300],
                            ),
                            SizedBox(width: 100),
                            _buildChart(chartData),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Income',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 50),
                            Text(
                              state.card!.totalIncome.toString()??'',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Container(); // Default return if none of the states match
            },
          ),
        ),
      ],
    );
  }
}

  Widget _buildChart(List<ChartData> chartData) {
    return Container(
      width: 80,
      height: 80,
      child: SfCircularChart(series: <CircularSeries>[
        DoughnutSeries<ChartData, String>(
          dataSource: chartData,
          pointColorMapper: (ChartData data, _) => data.color,
          xValueMapper: (ChartData data, _) => data.name,
          yValueMapper: (ChartData data, _) => data.age,
          // Radius of doughnut
          radius: '100%',
        ),
      ]),
    );
  }


class ChartData {
  final String name;
  final int age;
  final Color color;

  ChartData(this.name, this.age, this.color);
}
