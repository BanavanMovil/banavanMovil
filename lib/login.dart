//https://flutter-es.io/docs/cookbook/navigation/navigation-basics
import 'package:banavanmov/mainJCampo.dart';
import 'package:flutter/material.dart';
import 'package:banavanmov/mainGeneral.dart';

//import 'package:izijob/clases/usuario.dart';
//import 'globals.dart' as globals;
//import 'registro.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

//enum SingingCharacter { empleo, cachuelo }

class _LoginState extends State<Login> {
  final _formLogin = GlobalKey<FormState>();
  //SingingCharacter _character = SingingCharacter.empleo;
  final globalKey = GlobalKey<ScaffoldState>();

  //List<Usuario> usuarioList = [];

  @override
  void initState() {
    super.initState();
  }

  final myController = TextEditingController();
  final myControllerCon = TextEditingController();
  @override
  void dispose() {
    myController.dispose();
    myControllerCon.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      /*appBar: AppBar(
        title: Text('Iniciar Sesión'),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
      ),*/
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Form(
              key: _formLogin,
              child: Scrollbar(
                child: ListView(
                  children: <Widget>[
                    Placeholder(
                      fallbackHeight: 40,
                      fallbackWidth: 100,
                      color: Colors.white,
                    ),
                    Image.asset(
                      'assets/banavan.PNG',
                      width: 500,
                      height: 170,
                    ),
                    Placeholder(
                      fallbackHeight: 25,
                      fallbackWidth: 100,
                      color: Colors.white,
                    ),
                    Text(
                      'Iniciar Sesión',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, color: Colors.grey),
                    ),
                    Placeholder(
                      fallbackHeight: 25,
                      fallbackWidth: 100,
                      color: Colors.transparent,
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
                        //                  return tfUsuario = value;
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
                    ),
                    SizedBox(height: 20.0),
                    new RaisedButton(
                      disabledColor: Colors.white,
                      child: Text("Ingresar",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15, color: Colors.white)),
                      splashColor: Colors.white,
                      color: Colors.blueGrey,
                      onPressed: ingresarMain,
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Valida que esté todos los campos llenos
  bool validarForm() {
    final form = _formLogin.currentState;
    if (form.validate()) {
      // Si el formulario es válido, queremos mostrar un Snackbar
      //form.save();
      return true;
    }
    return false;
  }

  _showDialogConfirm(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (context) {
          return SimpleDialog(
            title: Center(child: Text("Ingreso Exitoso")),
            children: <Widget>[
              Center(child: Text("Datos ingresados correctamente.")),
              Placeholder(
                fallbackHeight: 7,
                fallbackWidth: 100,
                color: Colors.transparent,
              ),
              //Center(child: Text("")),
              Center(child: Text("Bienvenido: " + myController.text)),

              Placeholder(
                fallbackHeight: 10,
                fallbackWidth: 100,
                color: Colors.transparent,
              ),
              //Center(child: Text("Regístrese. Gracias!")),
              Center(
                  child: RaisedButton(
                      child: Text("Ok"),
                      onPressed: () {
                        myController.clear();
                        myControllerCon.clear();
                        Navigator.pop(ctx);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          //globals.isLoggedIn = true;
                          //return MainJCampo();
                          //return JBodegaVista();

                          return GeneralVista();
                        }));
                      })),
            ],
          );
        });
  }

  void ingresarMain() {
    if (validarForm()) {
      _showDialogConfirm(context);
      //if (validarLogin() == "true") {
      //myController.clear();
      //myControllerCon.clear();
      //Navigator.push(context, MaterialPageRoute(builder: (context) {
      //globals.isLoggedIn = true;
      //return MainJCampo();
      //return JBodegaVista();
      //  return GeneralVista();
      //}));
      //} else {
      //  _showDialog(context);
    }
    //}
  }
}
