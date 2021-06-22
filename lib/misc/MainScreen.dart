import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import '../login.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      image: new Image.asset('assets/bana.png'),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      loaderColor: Colors.white,
      loadingText: Text(
        "Cargando",
        style: new TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      photoSize: 100.0,
      seconds: 4,
      navigateAfterSeconds: Login(),
      gradientBackground: RadialGradient(
        radius: 1.5,
        colors: [
          Colors.yellow[100],
          Colors.yellow[300],
          Colors.yellow[500],
        ],
      ),
    );
  }
}
