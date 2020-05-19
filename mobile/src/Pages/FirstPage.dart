import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile/Widgets/TextCard.dart';
import 'package:mobile/utils/request.dart';

class Dashboard extends StatefulWidget {
  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {

  bool _loaded = false;
  List<dynamic> _data = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    print("called");
    Future<dynamic> request = getRequest("/epicovid/total");
    request.then((data) {
      print("data coming");
      print(data);
      this.setState(() {
        this._data = data;
        this._loaded = true;
        print(data);
      });
    });
  }

  Widget displayView() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: Column(
          children: <Widget>[
            TextCard("Total Comfirmed", this._data[0]['confirmed'].toString(), Colors.lightBlue, context),
            TextCard("Total Deaths", this._data[0]["deaths"].toString(), Colors.redAccent, context),
            TextCard("Total Recovered", this._data[0]["recovered"].toString(), Colors.lightGreen, context),
            TextCard("Countries/Regions", "185", Colors.amberAccent, context),
          ],
        ),
      ),
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