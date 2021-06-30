import 'package:banavanmov/solicitudJCampo.dart';
import 'package:banavanmov/historialJCampo.dart';
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
                        child: Text("Solicitud a Gerente",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                        onPressed: solicitudGerente,
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

  void historial() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      //globals.isLoggedIn = true;
      return HistorialJC();
    }));
  }
}
