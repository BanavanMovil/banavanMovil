import 'package:flutter/material.dart';
import 'package:banavanmov/misc/MainScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banavan Móvil',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: Footer(),s
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
