//https://flutter-es.io/docs/cookbook/navigation/navigation-basics

import 'package:flutter/material.dart';

import 'package:banavanmov/mainJCampo.dart';
import 'package:banavanmov/mainJBodega.dart';

class GeneralVista extends StatefulWidget {
  @override
  _GeneralVista createState() => _GeneralVista();
}

class _GeneralVista extends State<GeneralVista> {
  final _formLogin = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text('Menú Principal'),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        //child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Form(
            key: _formLogin,
            child: Scrollbar(
              child: ListView(
                children: <Widget>[
                  Placeholder(
                    fallbackHeight: 60,
                    fallbackWidth: 100,
                    color: Colors.transparent,
                  ),
                  new RaisedButton(
                    disabledColor: Colors.white,
                    child: Text("Jefe de Bodega",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                    splashColor: Colors.white,
                    color: Colors.blueGrey,
                    onPressed: ingresarJBodega,
                  ),
                  Placeholder(
                    fallbackHeight: 50,
                    fallbackWidth: 100,
                    color: Colors.transparent,
                  ),
                  new RaisedButton(
                    disabledColor: Colors.white,
                    child: Text("Jefe de Campo",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                    splashColor: Colors.white,
                    color: Colors.blueGrey,
                    onPressed: ingresarJCampo,
                  ),
                  Placeholder(
                    fallbackHeight: 50,
                    fallbackWidth: 100,
                    color: Colors.transparent,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void ingresarJBodega() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return JBodegaVista();
    }));
  }

  void ingresarJCampo() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MainJCampo();
    }));
  }
}
