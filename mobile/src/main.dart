import 'package:flutter/material.dart';

import 'Pages/FifthPage.dart';
import 'Pages/FirstPage.dart';
import 'Pages/FourthPage.dart';
import 'Pages/MapPage.dart';
import 'Pages/SecondPage.dart';
import 'Pages/ThirdPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data viz for COVID19',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          brightness: Brightness.dark,
          fontFamily: 'Gilroy'),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> data = List<String>.generate(100, (i) => "$i France");
  final controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    final pageView = PageView(
      controller: controller,
      children: <Widget>[
        Dashboard(),
        MapPage(),
        ListConfirmed(),
        ThirdPage(data, context),
        FourthPage(data, context),
        FifthPage(data, context)
      ],
    );
    return Scaffold(
        backgroundColor: Color.fromRGBO(33, 33, 33, 1),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 40.0, bottom: 10),
              child: Text(
                "EPICOVID Dashboard",
                style: TextStyle(fontSize: 38),
              ),
            ),
            Expanded(child: pageView),
          ],
        ));
  }
}
