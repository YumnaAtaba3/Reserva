import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/cubits/shared/wallet/card/cubit/card_cubit.dart';
import 'package:reserva/cubits/shared/wallet/card/cubit/card_state.dart';
import 'package:reserva/cubits/shared/wallet/cubit/activity_cubit.dart';
import 'package:reserva/cubits/shared/wallet/cubit/activity_state.dart';
import 'package:reserva/cubits/shared/wallet/line/cubit/line_cubit.dart';
import 'package:reserva/cubits/shared/wallet/line/cubit/line_state.dart';
import 'package:reserva/widgets/admin/card.dart';

import 'package:reserva/widgets/shared/line_chart.dart';
import 'package:reserva/widgets/shared/wallet_table.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Wallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CardCubit>(context).getIncome();
    BlocProvider.of<LineCubit>(context).getLine();
    BlocProvider.of<ActivityCubit>(context).getActiv();

    //BlocProvider.of<WalletCubit>(context).getWalletData();
    //BlocProvider.of<WalletCubit>(context).getLine();
    //BlocProvider.of<WalletCubit>(context).getActiv();
    List<ChartData> chartData = [
      ChartData('Group A', 200, Color.fromARGB(255, 54, 130, 244)),
      // ChartData('Group B', 20, Color.fromARGB(255, 175, 196, 213)),
      // ChartData('Group C', 30, Colors.blue),
    ];

    return Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Text('My Wallet',
                  style: TextStyle(
                      color: const Color(0xFF065061),
                      fontSize: 50,
                      fontFamily: "DancingScript",
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            height: 230,
                            width: 500,
                            decoration: BoxDecoration(
                              color: const Color(0xFF065061),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    "Total Incom:",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 40),
                                    child: BlocBuilder<CardCubit, CardState>(
                                      builder: (context, state) {
                                        if (state is CardLoading) {
                                          return CircularProgressIndicator();
                                        } else if (state is CardFailure) {
                                          return Container(
                                            child:
                                                Text(state.message.toString()),
                                          );
                                        } else if (state is CardSuccess) {
                                          return Text(
                                            "\$" + state.card.income.toString(),
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomLeft: Radius.circular(170),
                              ),
                              child: Container(
                                width: 150,
                                height: 150,
                                color: const Color.fromARGB(255, 197, 197, 197),
                                child: const Padding(
                                  padding:
                                      EdgeInsets.only(left: 20.0, bottom: 10),
                                  child: Icon(
                                    Icons.attach_money,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    /* Expanded(
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                            width: 600,
                            height: 190,
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.attach_money,
                                      size: 100,
                                      color: Colors.blue[300],
                                    ),
                                    /*SizedBox(
                                      width: 110,
                                    ),*/
                                    _buildChart(chartData),
                                  ],
                                ),
                                Row(
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total Income',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 270,
                                      ),
                                      BlocBuilder<WalletCubit, WalletState>(
                                        builder: (context, state) {
                                          if (state is WalletLoading) {
                                            return CircularProgressIndicator();
                                          } else if (state is WalletFailure) {
                                            return Container(
                                              child: Text(
                                                  state.message.toString()),
                                            );
                                          } else if (state is WalletSuccess) {
                                            return Text(
                                              state.card.income.toString(),
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                      ),
                                    ])
                              ],
                            )),
                      ),
                    ),*/
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            "Profit chart for the last year:",
                            style: TextStyle(
                                color: const Color(0xFF064061),
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          BlocBuilder<LineCubit, LineState>(
                            builder: (context, state) {
                              if (state is LineLoading) {
                                return CircularProgressIndicator();
                              } else if (state is LineFailure) {
                                return Container(
                                  child: Text(state.message.toString()),
                                );
                              } else if (state is LineEmpty) {
                                return Center(
                                  child: Card(
                                    elevation: 2,
                                    child: Container(
                                      height: 200,
                                      width: 600,
                                      child: Text(
                                        'There is no line chart data for profits',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                );
                              } else if (state is LineSuccess) {
                                return Container(
                                    height: 200,
                                    width: 600,
                                    child: LineChartSample2(data: state.line));
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ]),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Activities",
                      style: TextStyle(
                          color: const Color(0xFF064061),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  BlocBuilder<ActivityCubit, ActivityState>(
                    builder: (context, state) {
                      if (state is ActivityLoading) {
                        return CircularProgressIndicator();
                      } else if (state is ActivityFailure) {
                        return Container(
                          child: Text(state.message.toString()),
                        );
                      } else if (state is ActivityEmpty) {
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
                      } else if (state is ActivitySuccess) {
                        return WalletTable(data: state.activ);
                      } else {
                        return Container(
                          child: Text('Something went wrong'),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }

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
}

// LineChartData chartData = LineChartData(
//   lineBarsData: [
//     LineChartBarData(
//       spots: [
//         FlSpot(1, 10),
//         FlSpot(4, 13),
//         FlSpot(5, 5),
//         FlSpot(7, 15),
//         // Add more data spots for each day of the month
//       ],
//       isCurved: true,
//       barWidth: 2,
//       color: Colors.blue,
//       dotData: FlDotData(show: false),
//       belowBarData: BarAreaData(show: true, color: Colors.blue[100]),
//     ),
//   ],
// );
