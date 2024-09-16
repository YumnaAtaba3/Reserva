// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/cubits/admin/walllet/wallet_cubit.dart';
import 'package:reserva/widgets/admin/card.dart';
import 'package:reserva/widgets/admin/double_data_chart.dart';
import 'package:reserva/widgets/admin/linechart.dart';
import 'package:reserva/widgets/admin/wallet_table.dart';
import 'package:reserva/widgets/company_owner/hotels/hotel_reservations.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class wallet_page extends StatefulWidget {
  const wallet_page({super.key});

  @override
  State<wallet_page> createState() => _wallet_pageState();
}


  List<ChartData> chartData = [
      ChartData('Group A', 10, Color.fromARGB(255, 54, 130, 244)),
      ChartData('Group B', 20, Color.fromARGB(255, 175, 196, 213)),
      ChartData('Group C', 30, Colors.blue),
    ];
class _wallet_pageState extends State<wallet_page> {
  @override
  Widget build(BuildContext context) {
      //  BlocProvider.of<WalletCubit>(context).getWalletData();
        // BlocProvider.of<WalletCubit>(context).getIncome();
        // BlocProvider.of<WalletCubit>(context).getreturnTripsFinancial();
        // BlocProvider.of<WalletCubit>(context).getFlightsFinancial();
        // BlocProvider.of<WalletCubit>(context).getHotelsFinancial();
        // BlocProvider.of<WalletCubit>(context).getLine();
        // BlocProvider.of<WalletCubit>(context).getActiv();
        BlocProvider.of<WalletCubit>(context).getWalletData();
    return 

  Scaffold(
        appBar: AppBar(
          title: Text('My Wallet',
              style: TextStyle(
                 // color: const Color(0xFF065061),
                  fontSize: 40,
                  fontFamily: "DancingScript",
                  fontWeight: FontWeight.bold)),
        ),
        body:    BlocBuilder<WalletCubit, WalletState>(
                                      builder: (context, state) {
                                        if (state is WalletLoading) {
                                          return Center(child: CircularProgressIndicator());
                                        } else if (state is WalletFailure) {
                                          return Container(
                                            child:
                                                Text(state.message.toString()),
                                          );
                                            } else if (state is WalletSuccess) {
    return    ListView(
          children: [
            Column(
              children: [
                Row(children: [
                  Expanded(
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                          width: 600,
                          height: 400,
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                    Expanded(
          child: Card(
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
                          color: Color.fromARGB(255, 54, 130, 244),
                        ),
                        SizedBox(
                          width: 100,
                        ),
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
                          /*SizedBox(
                        width: 60,
                      ),*/
                          Text(
                            state.card1.totalIncome.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ])
                  ],
                )),
          ),
        ),

          Expanded(
          child: Card(
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
                            color: Color.fromARGB(255, 54, 130, 244),
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        _buildChart(chartData),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Flights Financial',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          /*SizedBox(
                        width: 60,
                      ),*/
                          Text(
                            state.card4.flightsFinancialReturn.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ])
                  ],
                )),
          ),
        ),
                        
        
                                ],
                              ),
                            
SizedBox(height: 20,),
 Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                    Expanded(
          child: Card(
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
                          color: Color.fromARGB(255, 54, 130, 244),
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        _buildChart(chartData),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Hotels Financial',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          /*SizedBox(
                        width: 60,
                      ),*/
                          Text(
                            state.card3.hotelsFinancialReturn.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ])
                  ],
                )),
          ),
        ),

         Expanded(
          child: Card(
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
                          Icons.travel_explore_outlined,
                          size: 50,
                        color: Color.fromARGB(255, 54, 130, 244),
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        _buildChart(chartData),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Trips Financial',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          /*SizedBox(
                        width: 60,
                      ),*/
                          Text(
                            state.card2.tripsFinancialReturn.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ])
                  ],
                )),
          ),
        ),
                        
        
                                ],
                              ),
                            




                ])),
                    ),
                  ),
                  Expanded(
                     // padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            "Profit chart for the last year:",
                            style: TextStyle(
                               // color: const Color(0xFF064061),
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          BlocBuilder<WalletCubit, WalletState>(
                            builder: (context, state) {
                              if (state is WalletLoading) {
                                return CircularProgressIndicator();
                              } else if (state is WalletFailure) {
                                return Container(
                                  child: Text(state.message.toString()),
                                );
                              } else if (state is WalletEmpty) {
                                return Center(
                                  child: Card(
                                    elevation: 2,
                                    child: Container(
                                      height: 400,
                                      width: 600,
                                      child: Text(
                                        'There is no line chart data for profits',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                );
                              } else if (state is WalletSuccess) {
                                return Container(
                                    height: 200,
                                    width: 600,
                                    child: LineChartSample2(data: state.line));
                              } else {
                                return Container();
                              }
                            },
                          ),]),)
                ]),
                                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Activities",
                      style: TextStyle(
                          //color: const Color(0xFF064061),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  BlocBuilder<WalletCubit, WalletState>(
                    builder: (context, state) {
                      if (state is WalletLoading) {
                        return CircularProgressIndicator();
                      } else if (state is WalletFailure) {
                        return Container(
                          child: Text(state.message.toString()),
                        );
                      } else if (state is WalletEmpty) {
                        return Center(
                          child: Card(
                            elevation: 2,
                            child: Container(
                              height: 300,
                              width: double.infinity,
                              child: Text(
                                'There is no Activities Found',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      } else if (state is WalletSuccess) {
                        return wallet_table(data: state.activ);
                      } else {
                        return Container(
                          child: Text('Something went wrong'),
                        );
                      }
                    },
                  ),
                ],
              ),
            
              ],
            
        );
   } else {
          return Container();
        }
      },
    ),
  );
}}

  Widget _buildChart(List<ChartData> chartData) {
    return Container(
      width: 100,
      height: 100,
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

