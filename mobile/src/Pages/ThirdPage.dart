import 'package:flutter/material.dart';
import 'package:mobile/Widgets/ListCardWithTitle.dart';
import 'package:mobile/Widgets/TextCardFlat.dart';

Widget ThirdPage(List<String> data, BuildContext context) {
  return Column(
    children: <Widget>[
      TextCardFlat('Total Confirmed', '2 078 277', Colors.redAccent, context),
      Expanded(child: ListCardWtTitle(data, Colors.redAccent, context)),
    ],
  );
}