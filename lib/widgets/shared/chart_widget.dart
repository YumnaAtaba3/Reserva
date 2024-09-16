// import 'package:flutter/material.dart';
// import 'package:reserva/models/comany_owner/hotel/hotel_home.dart';
// import 'package:charts_flutter/flutter.dart' as charts;

// class ChartWidget extends StatelessWidget {
//   final List<Chart> barChartData;

//   const ChartWidget({Key? key, required this.barChartData}) : super(key: key);

//   barChart() {
//     final firstMonthData = <String, int>{};
//     final secondMonthData = <String, int>{};
//     final thirdMonthData = <String, int>{};

//     for (final chart in barChartData) {
//       firstMonthData[chart.year.toString()] = chart.months.values.elementAt(0);
//       secondMonthData[chart.year.toString()] = chart.months.values.elementAt(1);
//       thirdMonthData[chart.year.toString()] = chart.months.values.elementAt(2);
//     }

//     final seriesList = [
//       charts.Series<ChartData, String>(
//         id: 'First Month',
//         domainFn: (ChartData data, _) => data.year,
//         measureFn: (ChartData data, _) => data.value,
//         data: firstMonthData.entries
//             .map((e) => ChartData(e.key, e.value))
//             .toList(),
//         fillColorFn: (_, __) =>
//             charts.ColorUtil.fromDartColor(const Color(0xff0185B7)),
//       ),
//       charts.Series<ChartData, String>(
//         id: 'Second Month',
//         domainFn: (ChartData data, _) => data.year,
//         measureFn: (ChartData data, _) => data.value,
//         data: secondMonthData.entries
//             .map((e) => ChartData(e.key, e.value))
//             .toList(),
//         fillColorFn: (_, __) =>
//             charts.ColorUtil.fromDartColor(const Color(0xff024275)),
//       ),
//       charts.Series<ChartData, String>(
//         id: 'Third Month',
//         domainFn: (ChartData data, _) => data.year,
//         measureFn: (ChartData data, _) => data.value,
//         data: thirdMonthData.entries
//             .map((e) => ChartData(e.key, e.value))
//             .toList(),
//         fillColorFn: (_, __) =>
//             charts.ColorUtil.fromDartColor(const Color(0xff001A45)),
//       ),
//     ];

//     return charts.BarChart(
//       seriesList,
//       behaviors: [
//         charts.ChartTitle('Highest 3-month Reservation Rate in 5 Years'),
//         // charts.AxisTitle(
//         //   measure: 'Reservation Rate',
//         //   domainAxis: 'Year',
//         // ),
//       ],
//       animate: true,
//       vertical: true,
//       barGroupingType: charts.BarGroupingType.grouped,
//       defaultRenderer: charts.BarRendererConfig(
//         groupingType: charts.BarGroupingType.grouped,
//         strokeWidthPx: 1.0,
//       ),
//       domainAxis: charts.OrdinalAxisSpec(
//         renderSpec: charts.SmallTickRendererSpec(
//           labelStyle: charts.TextStyleSpec(
//             fontSize: 16,
//             color: charts.MaterialPalette.black,
//           ),
//         ),
//         tickProviderSpec: charts.StaticOrdinalTickProviderSpec(
//           seriesList.first.data
//               .map((data) => charts.TickSpec(data.year))
//               .toList(),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 300,
//       width: 600,
//       padding: const EdgeInsets.all(20.0),
//       child: barChartData.isNotEmpty
//           ? barChart()
//           : const Center(child: CircularProgressIndicator()),
//     );
//   }
// }

// class ChartData {
//   final String year;
//   final int value;

//   ChartData(this.year, this.value);
// }
