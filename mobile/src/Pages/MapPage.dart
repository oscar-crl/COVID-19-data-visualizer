import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

Widget MapPage() {
  var circleMarkers = <CircleMarker>[
    CircleMarker(
        point: LatLng(43.6958368, 7.2701262),
        color: Colors.red.withOpacity(0.7),
        useRadiusInMeter: true,
        radius: 200000 // 2000 meters | 2 km
    ),
  ];
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
      CircleLayerOptions(circles: circleMarkers),
    ],
  );
}