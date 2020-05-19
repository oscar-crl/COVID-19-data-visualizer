import 'package:flutter/material.dart';
import 'package:mobile/Classes/ChartData.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Widget FifthPage(List<String> data, BuildContext context) {
  return SfCartesianChart(
      primaryXAxis: DateTimeAxis(),
      title: ChartTitle(text: 'Daily Cases'),
      tooltipBehavior: TooltipBehavior(enable: true, header: 'Daily Cases'),
      series: <ChartSeries<ChartData, DateTime>>[
        ColumnSeries<ChartData, DateTime>(
          dataSource: <ChartData>[
            ChartData(new DateTime(2020, 3, 29), 10),
            ChartData(new DateTime(2020, 3, 30), 20),
            ChartData(new DateTime(2020, 3, 31), 30),
            ChartData(new DateTime(2020, 4, 1), 40),
            ChartData(new DateTime(2020, 4, 2), 50)
          ],
          xValueMapper: (ChartData sales, _) => sales.month,
          yValueMapper: (ChartData sales, _) => sales.data,
        )
      ]);
}