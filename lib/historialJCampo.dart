import 'package:flutter/material.dart';
import 'package:banavanmov/providers/jCampoProvider.dart';

class HistorialJC extends StatefulWidget {
  @override
  _HistorialJCState createState() => _HistorialJCState();
}

class _HistorialJCState extends State<HistorialJC> {
  final JCampoProvider jc = new JCampoProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Historial de Cosecha'),
          backgroundColor: Colors.blue.shade200,
        ),
        body: Column(
          children: <Widget>[
            ElevatedButton(onPressed: prueba, child: Text("Prueba el get"))
          ],
        ));
  }

  void prueba() {
    jc.getInfo();
  }
}
