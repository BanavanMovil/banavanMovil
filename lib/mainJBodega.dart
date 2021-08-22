//https://flutter-es.io/docs/cookbook/navigation/navigation-basics
import 'package:banavanmov/providers/loginProvider.dart';
import 'package:flutter/material.dart';

import 'package:banavanmov/vistaEnfundadoJBodega.dart';
import 'package:banavanmov/vistaRacimosJBodega.dart';
import 'package:banavanmov/vistaPerdidosJBodega.dart';
import 'package:banavanmov/Login.dart';

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
      appBar: AppBar(
        title: const Text('Jefe de Bodega'),
        backgroundColor: Colors.orange,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            //tooltip: 'Show Snackbar',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Login();
              }));
            },
          ),
        ],
      ),
      //key: globalKey,
      /*appBar: AppBar(
          title: Text('Jefe de Bodega'),
          backgroundColor: Colors.orange,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_alert),
              tooltip: 'Show Snackbar',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is a snackbar')));
              },
            ),
          ]),*/
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
    LoginProvider.getToken().then((value) {
      print("Token: ");
      print(value);
    });
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
