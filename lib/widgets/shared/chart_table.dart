import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:reserva/models/comany_owner/hotel/hotel_home.dart';

/*class ChartTable extends StatelessWidget {
  final List<Chart> chartData;
  const ChartTable({super.key, required this.chartData});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<Chart, String>> series = [
      charts.Series(
        id: 'Reservation Rate',
        data: chartData,
        domainFn: (Chart chart, _) => chart.year.toString(),
        measureFn: (Chart chart, _) => chart.months.values.reduce(max),
        fillColorFn: (Chart chart, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff001A45)),
      )
    ];

    return charts.BarChart(
      series,
      animate: true,
      vertical: true,
      barGroupingType: charts.BarGroupingType.grouped,
      defaultRenderer: charts.BarRendererConfig(
        groupingType: charts.BarGroupingType.grouped,
        strokeWidthPx: 1.0,
      ),
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          labelStyle: charts.TextStyleSpec(
            fontSize: 16, //
            color: charts.MaterialPalette.black, // تحديد لون الخط
          ),
        ),
      ),
      behaviors: [
        charts.ChartTitle('Highest 3-month Reservation Rate in 5 Years'),
        // charts.AxisTitle(
        //   measure: 'Reservation Rate',
        //   domainAxis: 'Year',
        // ),
      ],
    );
  }
}*/
