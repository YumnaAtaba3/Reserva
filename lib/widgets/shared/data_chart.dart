// import 'package:flutter/material.dart';
// import 'dart:math';
// import 'package:charts_flutter/flutter.dart' as charts;

// class ChartsDemo extends StatefulWidget {
//   ChartsDemo() : super();

//   final String title = "Charts Demo";

//   @override
//   ChartsDemoState createState() => ChartsDemoState();
// }

// class ChartsDemoState extends State<ChartsDemo> {
//   late List<charts.Series> seriesList;

//   static List<charts.Series<Sales, String>> _createRandomData() {
//     final random = Random();

//     final desktopSalesData = [
//       Sales('2024', 20),
//       Sales('2023', random.nextInt(100)),
//       Sales('2022', random.nextInt(100)),
//       Sales('2021', random.nextInt(100)),
//       Sales('2020', random.nextInt(100)),
//     ];

//     final tabletSalesData = [
//       Sales('2024', random.nextInt(100)),
//       Sales('2023', random.nextInt(100)),
//       Sales('2022', random.nextInt(100)),
//       Sales('2021', random.nextInt(100)),
//       Sales('2020', random.nextInt(100)),
//     ];

//     final mobileSalesData = [
//       Sales('2024', random.nextInt(100)),
//       Sales('2023', random.nextInt(100)),
//       Sales('2022', random.nextInt(100)),
//       Sales('2021', random.nextInt(100)),
//       Sales('2020', random.nextInt(100)),
//     ];

//     return [
//       charts.Series<Sales, String>(
//         id: 'Desktop Sales',
//         domainFn: (Sales sales, _) => sales.year,
//         measureFn: (Sales sales, _) => sales.sales,
//         data: desktopSalesData,
//         fillColorFn: (Sales sales, _) =>
//             charts.ColorUtil.fromDartColor(Color(0xff0185B7)),
//       ),
//       charts.Series<Sales, String>(
//         id: 'Tablet Sales',
//         domainFn: (Sales sales, _) => sales.year,
//         measureFn: (Sales sales, _) => sales.sales,
//         data: tabletSalesData,
//         fillColorFn: (Sales sales, _) =>
//             charts.ColorUtil.fromDartColor(Color(0xff024275)),
//       ),
//       charts.Series<Sales, String>(
//         id: 'Mobile Sales',
//         domainFn: (Sales sales, _) => sales.year,
//         measureFn: (Sales sales, _) => sales.sales,
//         data: mobileSalesData,
//         fillColorFn: (Sales sales, _) =>
//             charts.ColorUtil.fromDartColor(Color(0xff001A45)),
//       ),
//     ];
//   }

//   barChart() {
//     return charts.BarChart(
//       seriesList as List<charts.Series<Sales, String>>,
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
//             fontSize: 16, // تحديد حجم الخط
//             color: charts.MaterialPalette.black, // تحديد لون الخط
//           ),
//         ),
//         tickProviderSpec: charts.StaticOrdinalTickProviderSpec(
//           <charts.TickSpec<String>>[
//             // تحديد أسماء الأعمدة هنا
//             charts.TickSpec('2024'),
//             charts.TickSpec('2023'),
//             charts.TickSpec('2022'),
//             charts.TickSpec('2021'),
//             charts.TickSpec('2020'),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     seriesList = _createRandomData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: 300,
//         width: 600,
//         padding: EdgeInsets.all(20.0),
//         child: barChart(),
//       ),
//     );
//   }
// }

// class Sales {
//   final String year;
//   final int sales;

//   Sales(this.year, this.sales);
// }
