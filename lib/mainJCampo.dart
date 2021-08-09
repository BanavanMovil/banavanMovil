import 'package:banavanmov/actividadesJCampo.dart';
import 'package:banavanmov/solicitudJCampo.dart';
import 'package:banavanmov/historialJCampo.dart';
import 'package:banavanmov/vistaSolicitudesJC.dart';
import 'package:flutter/material.dart';

class MainJCampo extends StatefulWidget {
  @override
  _MainJCampoState createState() {
    // TODO: implement createState
    return _MainJCampoState();
  }
}

class _MainJCampoState extends State<MainJCampo> {
  final _formLogin = GlobalKey<FormState>();
  //SingingCharacter _character = SingingCharacter.empleo;
  final globalKey = GlobalKey<ScaffoldState>();

  //List<Usuario> usuarioList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: globalKey,
        appBar: AppBar(
          title: Text('Jefe de Campo'),
          backgroundColor: Colors.orange,
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
                //padding: const EdgeInsets.all(5.0),
                child: Form(
                    key: _formLogin,
                    child: Scrollbar(
                        child: ListView(children: <Widget>[
                      Placeholder(
                        fallbackHeight: 60,
                        fallbackWidth: 100,
                        color: Colors.transparent,
                      ),
                      new ElevatedButton(
                        child: Text("Registro diario",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                        onPressed: historial,
                      ),
                      Placeholder(
                        fallbackHeight: 50,
                        fallbackWidth: 100,
                        color: Colors.transparent,
                      ),
                      new ElevatedButton(
                        child: Text("Crear Solicitud",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                        onPressed: solicitudGerente,
                      ),
                      Placeholder(
                        fallbackHeight: 50,
                        fallbackWidth: 100,
                        color: Colors.transparent,
                      ),
                      new ElevatedButton(
                        child: Text("Mis Solicitudes",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                        onPressed: misSolicitudes,
                      ),
                      Placeholder(
                        fallbackHeight: 50,
                        fallbackWidth: 100,
                        color: Colors.transparent,
                      ),
                      new ElevatedButton(
                        child: Text("Actividades",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                        onPressed: actividades,
                      ),
                      SizedBox(height: 10.0)
                    ]))))));
  }

  void solicitudGerente() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      //globals.isLoggedIn = true;
      return SolicitudJC();
    }));
  }

  void actividades() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      //globals.isLoggedIn = true;
      return ActividadesJC();
    }));
  }

  void historial() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      //globals.isLoggedIn = true;
      return HistorialJC();
    }));
  }

  void misSolicitudes() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      //globals.isLoggedIn = true;
      return SolicitudesJC();
    }));
  }
}
