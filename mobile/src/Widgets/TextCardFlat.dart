import 'package:flutter/material.dart';

Widget TextCardFlat(
    String title, String data, Color theme, BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.02),
    child: Container(
      width: MediaQuery.of(context).size.width / 1.05,
      height: MediaQuery.of(context).size.height / 8,
      decoration: BoxDecoration(
        color: Color.fromRGBO(42, 42, 42, 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          Text(
            data,
            style: TextStyle(fontSize: 32, color: theme),
          )
        ],
      ),
    ),
  );
}