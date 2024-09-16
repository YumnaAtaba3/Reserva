import 'package:flutter/material.dart';
import 'package:reserva/widgets/admin/card.dart';
import 'package:reserva/widgets/company_owner/hotels/hotel_reservations.dart';
import 'package:reserva/widgets/shared/data_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<ChartData> chartData = [
      ChartData('Group A', 10, Color.fromARGB(255, 54, 130, 244)),
      ChartData('Group B', 20, Color.fromARGB(255, 175, 196, 213)),
      ChartData('Group C', 30, Colors.blue),
    ];

    return Scaffold(
        appBar: AppBar(
          title: Text('My Wallet',
              style: TextStyle(
                  color: const Color(0xFF065061),
                  fontSize: 60,
                  fontFamily: "DancingScript",
                  fontWeight: FontWeight.bold)),
        ),
        body: ListView(
          children: [
            Column(
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
                          height: 200,
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
                                  SizedBox(
                                    width: 100,
                                  ),
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
                                    SizedBox(
                                      width: 100,
                                    ),
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
                  //Container(height: 200, width: 600, child: ChartsDemo()),
                ]),
                HotelReservationTable(),
              ],
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
