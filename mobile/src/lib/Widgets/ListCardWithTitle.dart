import 'package:flutter/material.dart';

Widget ListCardWtTitle(List<String> data, Color theme, BuildContext context) {
  return ListView.builder(
    padding: EdgeInsets.all(0),
    itemCount: data.length,
    itemBuilder: (context, index) {
      return Container(
        width: MediaQuery.of(context).size.width / 1.05,
        height: MediaQuery.of(context).size.height / 10,
        decoration: BoxDecoration(
            color: Color.fromRGBO(42, 42, 42, 1),
            border: Border.all(
              color: Colors.black26,
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${data[index]}',
                    style: TextStyle(fontSize: 24, color: theme),
                  ),
                  Text(
                    '${data[index]}',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}