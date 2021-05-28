//https://flutter-es.io/docs/cookbook/navigation/navigation-basics
//import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
//import 'package:izijob/footer.dart';
//import 'package:firebase_database/firebase_database.dart';
//
import 'package:banavanmov/vistaEnfundadoJBodega.dart';
import 'package:banavanmov/vistaRacimosJBodega.dart';

import 'package:banavanmov/mainJCampo.dart';
import 'package:banavanmov/mainJBodega.dart';

//import 'package:izijob/clases/usuario.dart';
//import 'globals.dart' as globals;
//import 'registro.dart';

class GeneralVista extends StatefulWidget {
  @override
  _GeneralVista createState() => _GeneralVista();
}

//enum SingingCharacter { empleo, cachuelo }

class _GeneralVista extends State<GeneralVista> {
  final _formLogin = GlobalKey<FormState>();
  //SingingCharacter _character = SingingCharacter.empleo;
  final globalKey = GlobalKey<ScaffoldState>();

  //List<Usuario> usuarioList = [];

  @override
  void initState() {
    super.initState();
    /*DatabaseReference usuarioRef =
        FirebaseDatabase.instance.reference().child("Usuario");
    usuarioRef.once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      usuarioList.clear();

      /*for (var individualKey in keys) {
        Usuario user = Usuario(
          data[individualKey]['idUSer'],
          data[individualKey]['nombre'],
          data[individualKey]['usuario'],
          data[individualKey]['correo'],
          data[individualKey]['fechaCreacion'],
          data[individualKey]['clave'],
        );
        usuarioList.add(user);
      }*/
    });*/
  }

  /*final myController = TextEditingController();
  final myControllerCon = TextEditingController();
  @override
  void dispose() {
    myController.dispose();
    myControllerCon.dispose();
    super.dispose();
  }*/

  //String tfUsuario, tfContrasena;

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

                  /*Image.asset(
                      'assets/banavan.PNG',
                      width: 500,
                      height: 170,
                    ),
                    Placeholder(
                      fallbackHeight: 50,
                      fallbackWidth: 100,
                      color: Colors.white,
                    ),
                    Text(
                      'Iniciar Sesión',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, color: Colors.grey),
                    ),

                    new ListTile(
                        //leading: const Icon(Icons.person),
                        title: TextFormField(
                      controller: myController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Usuario',
                      ),
                      validator: (value) {
                        return value.isEmpty
                            ? 'Por favor, ingrese su usuario'
                            : null;
                      },
                      onSaved: (value) {
                        return tfUsuario = value;
                      },
                    )),
                    new ListTile(
                      //leading: const Icon(Icons.lock),
                      title: TextFormField(
                        controller: myControllerCon,
                        //keyboardType: TextInputType.multiline,
                        obscureText: true,
                        //maxLines: null,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Contraseña',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Por favor, ingresa la contraseña';
                          }
                          return null;
                        },
                      ),
                    ),*/

                  //SizedBox(height: 20.0),
                  //
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

                  //SizedBox(height: 10.0),

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

                  //SizedBox(height: 10.0),

                  /*new RaisedButton(
                    disabledColor: Colors.white,
                    child: Text("Racimos Perdidos",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                    splashColor: Colors.white,
                    color: Colors.blueGrey,
                    onPressed: ingresarPerdidos,
                  ),
                  SizedBox(height: 10.0),*/

                  /*new RaisedButton(
                      disabledColor: Colors.amber,
                      child: Text("Registrarse"),
                      splashColor: Colors.amber,
                      color: Colors.blueAccent,
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Registro();
                        }));
                      },
                    ),
                    SizedBox(height: 10.0),*/
                  /*new RaisedButton(
                      disabledColor: Colors.amber,
                      child: Text("Ingresar como invitado"),
                      splashColor: Colors.amber,
                      color: Colors.blueAccent,
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          globals.isLoggedIn = false;
                          return Footer();
                        }));
                      },
                    ),*/
                ],
              ),
            ),
          ),
        ),
        //),
      ),
    );
  }

  /*String validarLogin() {
    for (Usuario x in usuarioList) {
      if (x.usuario == myController.text) {
        if (x.clave == myControllerCon.text) {
          return "true";
        }
      }
    }
    return "false";
  }*/

  //Valida que esté todos los campos llenos
  /* bool validarForm() {
    final form = _formLogin.currentState;
    if (form.validate()) {
      // Si el formulario es válido, queremos mostrar un Snackbar
      //form.save();
      return true;
    }
    return false;
  }*/

  /*_showDialog(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (context) {
          return SimpleDialog(
            title: Center(child: Text("Datos Incorrectos")),
            children: <Widget>[
              Center(child: Text("El usuario que ha ingresado ")),
              Center(child: Text("no se encuentra registrado.")),
              Center(child: Text("Compruebe los datos o ")),
              Center(child: Text("Regístrese. Gracias!")),
              Center(
                  child: FlatButton(
                      child: Text("Ok"),
                      onPressed: () {
                        Navigator.pop(ctx);
                      })),
            ],
          );
        });
  }*/

  void ingresarJBodega() {
    //if (validarForm()) {
    //if (validarLogin() == "true") {
    //myController.clear();
    //myControllerCon.clear();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      //globals.isLoggedIn = true;
      return JBodegaVista();
    }));
    //} else {
    //_showDialog(context);
    //}
    //}
  }

  void ingresarJCampo() {
    //if (validarForm()) {
    //if (validarLogin() == "true") {
    //myController.clear();
    //myControllerCon.clear();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      //globals.isLoggedIn = true;
      return MainJCampo();
    }));
    //} else {
    //_showDialog(context);
    //}
    //}
  }

  //void ingresarPerdidos() {
  //if (validarForm()) {
  //if (validarLogin() == "true") {
  //myController.clear();
  //myControllerCon.clear();
  //Navigator.push(context, MaterialPageRoute(builder: (context) {
  //globals.isLoggedIn = true;
  //return PerdidosVista();
  //}));
  //} else {
  //_showDialog(context);
  //}
  //}
  //}
}
