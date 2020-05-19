import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile/Widgets/ListCard.dart';
import 'package:mobile/Widgets/TextCardFlat.dart';
import 'package:mobile/utils/request.dart';

class ListConfirmed extends StatefulWidget {
  @override
  _ListConfirmed createState() => _ListConfirmed();
}

class _ListConfirmed extends State<ListConfirmed> {
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
      Future<dynamic> request = getRequest("/epicovid/country");
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
  Widget displayView() {
    return Column(
      children: <Widget>[
        TextCardFlat('Total Confirmed', '2 078 277', Colors.redAccent, context),
        Container(
          height: MediaQuery.of(context).size.height - 220,
          child: ListView.separated(
            itemCount: this._data.length,
            separatorBuilder: (context, index) => SizedBox(height: 5),
            itemBuilder: (BuildContext context, int index) {

              return InkWell(
                  onTap: () {},
                  child: TextCardFlat(this._data[index]["country"], this._data[index]["confirmed"].toString(), Colors.redAccent, context)
              );
            },
          ),
        ),
      ],
    );
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

