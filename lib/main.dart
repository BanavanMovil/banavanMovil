import 'package:flutter/material.dart';
import 'package:banavanmov/misc/MainScreen.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

//void main() {
//  runApp(MyApp());
//}

Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://490cc4d29db0496e91b8e49592e7024d@o867505.ingest.sentry.io/5823802';
    },
    appRunner: () => runApp(MyApp()),
  );

  // or define SENTRY_DSN via Dart environment variable (--dart-define)
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
