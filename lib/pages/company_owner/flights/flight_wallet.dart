import 'package:flutter/material.dart';
import 'package:reserva/widgets/admin/card.dart';

import 'package:reserva/widgets/shared/line_chart.dart';
import 'package:reserva/widgets/shared/wallet_table.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FlightWallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<ChartData> chartData = [
      ChartData('Group A', 10, Color.fromARGB(255, 54, 130, 244)),
      ChartData('Group B', 20, Color.fromARGB(255, 175, 196, 213)),
      ChartData('Group C', 30, Colors.blue),
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
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(children: [
                    Expanded(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total Income',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      /* SizedBox(
                                    width: 90,
                                  ),*/
                                      Text(
                                        '3648',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ])
                              ],
                            )),
                      ),
                    ),
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
                          Container(
                            height: 200,
                            width: 600,
                            // child: LineChartSample2()
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
                  // WalletTable(),
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
