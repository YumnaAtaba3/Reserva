import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';
import 'package:reserva/models/comany_owner/hotel/hotel_home.dart';

class PieChartSample2 extends StatelessWidget {
  final PieData pieChartData;
  PieChartSample2({super.key, required this.pieChartData});

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 300,
        width: 300,
        child: PieChart(
          swapAnimationDuration: Duration(milliseconds: 10),
          swapAnimationCurve: Curves.linear,
          PieChartData(
            pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                /*setState(() {
                  if (!event.isInterestedForInteractions ||
                      pieTouchResponse == null ||
                      pieTouchResponse.touchedSection == null) {
                    touchedIndex = -1;
                    return;
                  }
                  touchedIndex =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                });*/
              },
            ),
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 0,
            centerSpaceRadius: 40,
            sections: showingSections(),
          ),
        ),
      ),
    );
    /*const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Indicator(
                color: Color(0xff001A45),
                text: 'First',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: Color(0xff024275),
                text: 'Second',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: Color(0xff0185B7),
                text: 'Third',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: Color(0xffA6D7F1),
                text: 'Fourth',
                isSquare: true,
              ),
            ],
          ),*/
  }

  List<PieChartSectionData> showingSections() {
    int totalCount =
        pieChartData.yearValue.values.fold(0, (sum, count) => sum + count);

    return pieChartData.yearValue.entries.map((entry) {
      final percentage = entry.value;
      final isTouched = false; // You can implement touch logic here
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;

      return PieChartSectionData(
        color: getColorForSection(entry.key),
        value: percentage as double,
        title: '${percentage}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  Color getColorForSection(String sectionIndex) {
    switch (sectionIndex) {
      case '2024':
        return Color(0xff001A45);
      case '2023':
        return Color(0xff024275);
      case '2022':
        return Color(0xff0185B7);
      case '2021':
        return Color(0xffA6D7F1);
      default:
        return Colors.white;
    }
  }

  // return List.generate(4, (i) {
  //   final isTouched = i == touchedIndex;
  //   final fontSize = isTouched ? 25.0 : 16.0;
  //   final radius = isTouched ? 60.0 : 50.0;
  //   // const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

  //   switch (i) {
  //     case 0:
  //       return PieChartSectionData(
  //         color: Color(0xff001A45),
  //         value: perc,
  //         title: '40%',
  //         radius: radius,
  //         titleStyle: TextStyle(
  //           fontSize: fontSize,
  //           fontWeight: FontWeight.bold,
  //           color: Colors.white,
  //           // shadows: shadows,
  //         ),
  //       );
  //     case 1:
  //       return PieChartSectionData(
  //         color: Color(0xff024275),
  //         value: 30,
  //         title: '30%',
  //         radius: radius,
  //         titleStyle: TextStyle(
  //           fontSize: fontSize,
  //           fontWeight: FontWeight.bold,
  //           color: Colors.white,
  //           //shadows: shadows,
  //         ),
  //       );
  //     case 2:
  //       return PieChartSectionData(
  //         color: Color(0xff0185B7),
  //         value: 15,
  //         title: '15%',
  //         radius: radius,
  //         titleStyle: TextStyle(
  //           fontSize: fontSize,
  //           fontWeight: FontWeight.bold,
  //           color: Colors.white,
  //           //shadows: shadows,
  //         ),
  //       );
  //     case 3:
  //       return PieChartSectionData(
  //         color: Color(0xffA6D7F1),
  //         value: 15,
  //         title: '15%',
  //         radius: radius,
  //         titleStyle: TextStyle(
  //           fontSize: fontSize,
  //           fontWeight: FontWeight.bold,
  //           color: Colors.white,
  //           //shadows: shadows,
  //         ),
  //       );
  //     default:
  //       throw Error();
  //   }
  // });
}




/*class Sales {
  final String year;
  final int sales;
  final charts.Color color;

  Sales(this.year, this.sales, this.color);
}

class PieChartExample extends StatelessWidget {
  final List<Sales> data = [
    Sales('2019', 24, charts.ColorUtil.fromDartColor(Color(0xff001A45))),
    Sales('2020', 30, charts.ColorUtil.fromDartColor(Color(0xff024275))),
    Sales('2021', 50, charts.ColorUtil.fromDartColor(Color(0xff0185B7))),
    Sales('2022', 75, charts.ColorUtil.fromDartColor(Color(0xffA6D7F1))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pie Chart Example'),
      ),
      body: Container(
        height: 300,
        width: 300,
        child: charts.PieChart(
          _createSeriesData(),
          animate: true,
          animationDuration: Duration(milliseconds: 500),
        ),
      ),
    );
  }

  List<charts.Series<Sales, String>> _createSeriesData() {
    return [
      charts.Series<Sales, String>(
        id: 'Sales',
        domainFn: (Sales sales, _) => sales.year,
        measureFn: (Sales sales, _) => sales.sales,
        colorFn: (Sales sales, _) => sales.color,
        data: data,
        labelAccessorFn: (Sales sales, _) => '${sales.year}: ${sales.sales}',
      ),
    ];
  }
}*/