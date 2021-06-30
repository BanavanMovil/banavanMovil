//https://flutter-es.io/docs/cookbook/navigation/navigation-basics
import 'package:flutter/material.dart';

import 'package:banavanmov/vistaEnfundadoJBodega.dart';
import 'package:banavanmov/vistaRacimosJBodega.dart';
import 'package:banavanmov/vistaPerdidosJBodega.dart';

class JBodegaVista extends StatefulWidget {
  @override
  _JBodegaVista createState() => _JBodegaVista();
}

class _JBodegaVista extends State<JBodegaVista> {
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
        title: Text('Jefe de Bodega'),
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
                  new ElevatedButton(
                    //disabledColor: Colors.white,
                    child: Text("Enfundado",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                    //splashColor: Colors.white,
                    //color: Colors.blueGrey,
                    onPressed: ingresarEnfundado,
                  ),
                  Placeholder(
                    fallbackHeight: 50,
                    fallbackWidth: 100,
                    color: Colors.transparent,
                  ),
                  new ElevatedButton(
                    //disabledColor: Colors.white,
                    child: Text("Racimos Cosechados",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                    //splashColor: Colors.white,
                    //color: Colors.blueGrey,
                    onPressed: ingresarRacimos,
                  ),
                  Placeholder(
                    fallbackHeight: 50,
                    fallbackWidth: 100,
                    color: Colors.transparent,
                  ),
                  new ElevatedButton(
                    //disabledColor: Colors.white,
                    child: Text("Racimos Perdidos",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                    //splashColor: Colors.white,
                    //color: Colors.blueGrey,
                    onPressed: ingresarPerdidos,
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void ingresarEnfundado() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EnfundadoVista();
    }));
  }

  void ingresarRacimos() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return RacimosVista();
    }));
  }

  void ingresarPerdidos() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PerdidosVista();
    }));
  }
}
