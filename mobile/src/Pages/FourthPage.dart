import 'package:flutter/material.dart';
import 'package:mobile/Classes/ChartData.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Widget FourthPage(List<String> data, BuildContext context) {
  return SfCartesianChart(
      primaryXAxis: DateTimeAxis(),
      title: ChartTitle(text: 'Confirmed'),
      tooltipBehavior: TooltipBehavior(enable: true, header: 'Confirmed'),
      series: <ChartSeries<ChartData, DateTime>>[
        LineSeries<ChartData, DateTime>(
          dataSource: <ChartData>[
            ChartData(new DateTime(2020, 3, 1), 0),
            ChartData(new DateTime(2020, 3, 2), 0),
            ChartData(new DateTime(2020, 3, 20), 76000),
            ChartData(new DateTime(2020, 4, 10), 400000),
            ChartData(new DateTime(2020, 4, 20), 2000000)
          ],
          xValueMapper: (ChartData sales, _) => sales.month,
          yValueMapper: (ChartData sales, _) => sales.data,
        )
      ]);
}