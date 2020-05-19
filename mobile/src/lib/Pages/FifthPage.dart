import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile/Classes/ChartData.dart';
import 'package:mobile/utils/request.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class DailyGraphView extends StatefulWidget {
  @override
  _DailyGraphView createState() => _DailyGraphView();
}

class _DailyGraphView extends State<DailyGraphView> {
  bool _loaded = false;
  String _total = "";
  List<dynamic> _data;

  @override
  void initState() {
    super.initState();
    if (!this._loaded)
      this.getData();
    if (this._loaded)
      this.startTime();
  }

  startTime() async {
    print("cron func");
    var _duration = new Duration(seconds: 10);
    return new Timer(_duration, () {
      this.getData().then((res) {
        this.setState(() {
          this._loaded = true;
        });
      });
      this.startTime();
    });
  }

  Future<String> getData() async {
    String count = "";

    print("get country data");
    Future<dynamic> request = getRequest("/epicovid/total");
    request.then((data) {
      print(data);
      count = data[0]['confirmed'];
      Future<dynamic> request = getRequest("/epicovid/dailytotal");
      request.then((data) {
        print(data);
        this.setState(() {
          this._total = count;
          this._data = data;
          this._loaded = true;
          print(data);
        });
      });
    });
    return "ok";
  }

  List<String> splitDate(String data) {
    List<String> tmp = [];

    tmp = data.split("-");
    return(tmp);
  }

  List<ChartData> createDataList() {
    List<ChartData> tmp = [];
    int i = 1;

    while (i < this._data.length - 1) {
      List <String> bis = splitDate(this._data[i]["date"]);
      double daily = 0.0;
      print(bis);
      daily = double.parse(this._data[i]["confirmed"]) - double.parse(this._data[i - 1]["confirmed"]);

      tmp.add(ChartData(new DateTime(int.parse(bis[0]), int.parse(bis[1]), int.parse(bis[2])), daily));
      i++;
    }
    return(tmp);
  }

  Widget displayView() {
    List<ChartData> test = createDataList();
    return SfCartesianChart(
        primaryXAxis: DateTimeAxis(),
        title: ChartTitle(text: 'Daily Cases'),
        tooltipBehavior: TooltipBehavior(enable: true, header: 'Daily Cases'),
        series: <ChartSeries<ChartData, DateTime>>[
          ColumnSeries<ChartData, DateTime>(
            dataSource: test,
            xValueMapper: (ChartData sales, _) => sales.month,
            yValueMapper: (ChartData sales, _) => sales.data,
          )
        ]);
  }

  Widget build(BuildContext context) {
    if (!this._loaded) {
      return SizedBox(
        height: MediaQuery.of(context).size.height - 130,
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 60,
        ),
      );
    }
    return displayView();
  }
}
