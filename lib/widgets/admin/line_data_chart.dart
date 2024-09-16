import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

LineChartData chartData = LineChartData(
  lineBarsData: [
    LineChartBarData(
      spots: [
        FlSpot(1, 10),
        FlSpot(1.5, 13),
        FlSpot(2, 5),
        FlSpot(3, 15),
        // Add more data spots for each day of the month
      ],
      isCurved: true,
      barWidth: 2,
      color: Colors.blue,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
    ),
  ],);