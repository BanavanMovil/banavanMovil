//https://flutter-es.io/docs/cookbook/navigation/navigation-basics
import 'dart:convert';

import 'package:banavanmov/mainJCampo.dart';
import 'package:banavanmov/mainJBodega.dart';
import 'package:banavanmov/providers/loginProvider.dart';
import 'package:flutter/material.dart';
import 'package:banavanmov/mainGeneral.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formLogin = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();
  var userController = TextEditingController();
  var passController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    userController.dispose();
    passController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
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
                      controller: userController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Usuario',
                      ),
                      validator: (value) {
                        return value.isEmpty
                            ? 'Por favor, ingrese su usuario'
                            : null;
                      },
                      onSaved: (value) {},
                    )),
                    new ListTile(
                      title: TextFormField(
                        controller: passController,
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
                    new ElevatedButton(
                      //disabledColor: Colors.black,
                      child: Text(isLoading ? 'Cargando' : "Ingresar",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15, color: Colors.white)),
                      //splashColor: Colors.white,
                      //color: Colors.blueGrey,
                      onPressed: isLoading ? null : ingresarMain,
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

  _showErrorMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg != null ? msg : "No se ha pasado nada"),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  _showDialogConfirm(BuildContext ctx, dynamic body) {
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
              Center(child: Text("Bienvenido: " + userController.text)),

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
                        userController.clear();
                        passController.clear();
                        Navigator.pop(ctx);
                        if (body['rol'] == 'Jefe de Campo') {
                          LoginProvider.setToken(body['access_token']);
                          print("Aqui se debio de guardar el token");
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return MainJCampo();
                          }));
                        } else if (body['rol'] == 'Jefe de Bodega') {
                          LoginProvider.setToken(body['access_token']);
                          print("Aqui se debio de guardar el token");
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return JBodegaVista();
                          }));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text(
                                  'Usuario sin acceso a la aplicacion'),
                              action: SnackBarAction(
                                label: 'Cerrar',
                                onPressed: () {
                                  // Code to execute.
                                },
                              )));
                        }
                      })),
            ],
          );
        });
  }

  void ingresarMain() async {
    try {
      if (validarForm()) {
        setState(() {
          isLoading = true;
        });

        var body = await LoginProvider()
            .login(userController.text, passController.text);

        print(body['message']);
        if (body['message'] == null) {
          print('Login Exitoso');
          _showDialogConfirm(this.context, body);
        } else {
          print('Login Fallido');
          _showErrorMsg(body['message']);
        }
        setState(() {
          isLoading = false;
        });
      }
    } on Exception {
      setState(() {
        isLoading = false;
      });
    }

    //}
  }
}
