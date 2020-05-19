import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:map_markers/map_markers.dart';
import 'package:latlong/latlong.dart';
import 'package:mobile/utils/request.dart';

class MapView extends StatefulWidget {
  @override
  _MapView createState() => _MapView();
}

class _MapView extends State<MapView> {
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
      count = data[0]['deaths'];
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

  List<Marker> createMarker() {
    List<Marker> tmp = [];
    int i = 0;

    while (i < this._data.length) {
      tmp.add(Marker(
          height: 100.0,
          width: 120.0,
          point: LatLng(this._data[i]["latitude"], this._data[i]["longitude"]),
          builder: (context) => BubbleMarker(
            bubbleColor: Colors.white,
            bubbleContentWidgetBuilder: (BuildContext context) {
              return Container(
                child: Column(
                  children: <Widget>[
                    Text(/*this._data[i]["country"]*/ i.toString(), style: TextStyle(
                      color: Colors.black,
                      fontSize: 9.0,
                    ),),
                    Text("confirmed : " /*+ this._data[i]["confirmed"]*/, style: TextStyle(
                      color: Colors.black,
                      fontSize: 9.0,
                    ),),
                    Text("deaths : " /*+ this._data[i]["deaths"]*/, style: TextStyle(
                      color: Colors.black,
                      fontSize: 9.0,
                    ),),
                  ],
                ),
              );
            },
          )),);
      i++;
    }
    return(tmp);
  }

  Widget displayView() {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(43.6958368, 7.2701262),
        zoom: 4,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://api.mapbox.com/styles/v1/oscar42/ck9460b3i3tai1iqsfuscd22k/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoib3NjYXI0MiIsImEiOiJjazk0NXd6azMwMjVqM3NvZmpnbzd5amIxIn0.yHwM6PDuPgvCvNd0Anb0gg",
          additionalOptions: {
            'accessToken': 'pk.eyJ1Ijoib3NjYXI0MiIsImEiOiJjazk0NXd6azMwMjVqM3NvZmpnbzd5amIxIn0.yHwM6PDuPgvCvNd0Anb0gg',
            'id': 'mapbox.streets',
          },
          subdomains: ['a', 'b', 'c'],
          // For example purposes. It is recommended to use
          // TileProvider with a caching and retry strategy, like
          // NetworkTileProvider or CachedNetworkTileProvider
          tileProvider: NonCachingNetworkTileProvider(),
        ),
        MarkerLayerOptions(markers: createMarker()),
      ],
    );
  }

  Widget build(BuildContext context) {
    if (!this._loaded) {
      return SizedBox(
        height: MediaQuery
            .of(context)
            .size
            .height - 130,
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 60,
        ),
      );
    }
    return displayView();
  }
}
