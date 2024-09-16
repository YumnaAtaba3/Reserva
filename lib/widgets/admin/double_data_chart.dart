
// import 'package:flutter/material.dart';
// import 'dart:math';
// import 'package:charts_flutter/flutter.dart' as charts;

// class ChartsDemo extends StatefulWidget {
//   ChartsDemo() : super();

//   final String title = "Profit scheme";

//   @override
//   ChartsDemoState createState() => ChartsDemoState();
// }

// class ChartsDemoState extends State<ChartsDemo> {
//     late List<charts.Series> seriesList;

//   static List<charts.Series<Sales, String>> _createRandomData() {
//     final random = Random();

//     final desktopSalesData = [
//       Sales('2015', random.nextInt(100)),
//       Sales('2016', random.nextInt(100)),
//       Sales('2017', random.nextInt(100)),
//       Sales('2018', random.nextInt(100)),
//       Sales('2019', random.nextInt(100)),
//     ];

//     final tabletSalesData = [
//       Sales('2015', random.nextInt(100)),
//       Sales('2016', random.nextInt(100)),
//       Sales('2017', random.nextInt(100)),
//       Sales('2018', random.nextInt(100)),
//       Sales('2019', random.nextInt(100)),
//     ];

//     final mobileSalesData = [
//       Sales('2015', random.nextInt(100)),
//       Sales('2016', random.nextInt(100)),
//       Sales('2017', random.nextInt(100)),
//       Sales('2018', random.nextInt(100)),
//       Sales('2019', random.nextInt(100)),
//     ];

//     return [
//       charts.Series<Sales, String>(
//         id: 'Desktop Sales',
//         domainFn: (Sales sales, _) => sales.year,
//         measureFn: (Sales sales, _) => sales.sales,
//         data: desktopSalesData,
//         fillColorFn: (Sales sales, _) {
//           return charts.MaterialPalette.blue.shadeDefault;
//         },
//       ),
//       charts.Series<Sales, String>(
//         id: 'Tablet Sales',
//         domainFn: (Sales sales, _) => sales.year,
//         measureFn: (Sales sales, _) => sales.sales,
//         data: tabletSalesData,
//         fillColorFn: (Sales sales, _) {
//           return charts.MaterialPalette.blue.shadeDefault;
//         },
//       ),
//       charts.Series<Sales, String>(
//         id: 'Mobile Sales',
//         domainFn: (Sales sales, _) => sales.year,
//         measureFn: (Sales sales, _) => sales.sales,
//         data: mobileSalesData,
//         fillColorFn: (Sales sales, _) {
//           return charts.MaterialPalette.teal.shadeDefault;
//         },
//       ),
//     ];
//   }

//   barChart() {
//   return charts.BarChart(
//     seriesList as List<charts.Series<Sales, String>>,
//     animate: true,
//     vertical: true,
//     barGroupingType: charts.BarGroupingType.grouped,
//     defaultRenderer: charts.BarRendererConfig(
//       groupingType: charts.BarGroupingType.grouped,
//       strokeWidthPx: 1.0,
//     ),
//     domainAxis: charts.OrdinalAxisSpec(
//       renderSpec: charts.SmallTickRendererSpec(
//         labelStyle: charts.TextStyleSpec(
//           fontSize: 14, // تحديد حجم الخط
//           color: charts.MaterialPalette.black, // تحديد لون الخط
//         ),
//       ),
//       tickProviderSpec: charts.StaticOrdinalTickProviderSpec(
//         <charts.TickSpec<String>>[
//           // تحديد أسماء الأعمدة هنا
//           charts.TickSpec('2015'),
//           charts.TickSpec('2016'),
//           charts.TickSpec('2017'),
//           charts.TickSpec('2018'),
//           charts.TickSpec('2019'),
//         ],
//       ),
//     ),
//   );
// }

//   @override
//   void initState() {
//     super.initState();
//     seriesList = _createRandomData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Container(
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
