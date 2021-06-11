//https://flutter-es.io/docs/cookbook/navigation/navigation-basics
//import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:izijob/footer.dart';
import 'package:flutter/services.dart';

import 'package:banavanmov/vistaPerdidosJBodega.dart';

class PublicarPerdidoJB extends StatefulWidget {
  @override
  _PublicarPerdidoJBState createState() => _PublicarPerdidoJBState();
}

//enum SingingCharacter { empleo, cachuelo }

class _PublicarPerdidoJBState extends State<PublicarPerdidoJB> {
  final _formKey = GlobalKey<FormState>();
  //SingingCharacter _character = SingingCharacter.empleo;
  final globalKey = GlobalKey<ScaffoldState>();

  List<String> _locations = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9'
  ]; // Option 2
  String _selectedLocation; // Option 2

  List<String> _motivos = [
    'Mal apuntalado',
    'Eliminación de planta',
    'Caída del fruto'
  ]; // Option 2
  String _selectedMotivos;

  /*String tfTitulo,
      tfDescripcion,
      tfExp,
      tfVacantes,
      tfSueldo,
      tfTelefono,
      tfEmail,
      tfCategoria;*/

  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text('Registro Racimo Perdido'),
        backgroundColor: Colors.orange,
        centerTitle: true,
        /*actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ),
            onPressed: uploadStatusEmpleo,
          )
        ],*/
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Form(
              key: _formKey,
              child: Scrollbar(
                child: ListView(
                  children: <Widget>[
                    new ListTile(
                        //leading: const Icon(Icons.title),
                        title: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Trabajador que encontró el racimo perdido',
                        //hintText: 'Ej: Necesito empleador...',
                      ),
                      validator: (value) {
                        return value.isEmpty
                            ? 'Por favor, ingresa el usuario'
                            : null;
                      },
                      onSaved: (value) {
                        //return tfTitulo = value;
                      },
                    )),
                    new ListTile(
                      //leading: const Icon(Icons.star),
                      title: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Fecha de entrega',
                          //hintText: 'Ej: Experiencia en dicho campo...',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Por favor, ingrese la fecha de entrega';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          //return tfExp = value;
                        },
                      ),
                    ),
                    new ListTile(
                      //leading: const Icon(Icons.monetization_on),
                      title: TextFormField(
                          //controller: _controller,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            labelText: "Número de Semana",
                            //hintText: "whatever you want",
                            //icon: Icon(Icons.phone_iphone)
                          )),
                      /*title: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Número de Semana',
                        //hintText: 'Ingresa el posible sueldo',
                      ),
                      validator: (value) {
                        return value.isEmpty
                            ? 'Por favor, ingrese el número de semana.'
                            : null;
                      },
                      onSaved: (value) {
                        return tfSueldo = value;
                      },
                    )*/
                    ),
                    new ListTile(
                      title: DropdownButton(
                        hint: Text(
                            'Número de lote'), // Not necessary for Option 1
                        value: _selectedLocation,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedLocation = newValue;
                          });
                        },
                        items: _locations.map((location) {
                          return DropdownMenuItem(
                            child: new Text(location),
                            value: location,
                          );
                        }).toList(),
                      ),
                      //leading: const Icon(Icons.description),
                      /*title: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Ingrese el número de lote',
                          //hintText: 'Ej: Señor(a) de tal edad...',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Por favor, ingrese el número de lote';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          return tfDescripcion = value;
                        },
                      ),*/
                    ),
                    new ListTile(
                        //leading: const Icon(Icons.contact_mail),
                        title: Text(
                      'Seleccione el color de cinta',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 17, color: Colors.grey),
                    )),
                    new ListTile(
                      title: DropdownButton(
                        hint: Text(
                            'Motivo de pérdida'), // Not necessary for Option 1
                        value: _selectedMotivos,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedMotivos = newValue;
                          });
                        },
                        items: _motivos.map((motivo) {
                          return DropdownMenuItem(
                            child: new Text(motivo),
                            value: motivo,
                          );
                        }).toList(),
                      ),

                      //leading: const Icon(Icons.description),
                      /*title: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Ingrese el número de lote',
                          //hintText: 'Ej: Señor(a) de tal edad...',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Por favor, ingrese el número de lote';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          return tfDescripcion = value;
                        },
                      ),*/
                    ),
                    new RaisedButton(
                      disabledColor: Colors.white,
                      child: Text("Guardar",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15, color: Colors.white)),
                      splashColor: Colors.white,
                      color: Colors.blueGrey,
                      onPressed: uploadStatusEmpleo,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      //backgroundColor: Colors.green,
    );
  }

  //Valida que esté todos los campos llenos
  /*bool validarForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      // Si el formulario es válido, queremos mostrar un Snackbar
      form.save();
      final snackBar = SnackBar(content: Text('Empleo Publicado'));
      globalKey.currentState.showSnackBar(snackBar);
      return true;
    }
    return false;
  }*/

  void uploadStatusEmpleo() async {
    //if (validarForm()) {
    // guardarToDatabase();
    // Navigator.pop(context);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      //return Footer();
      return PerdidosVista();
    }));
    // }
  }

  TextFormField textFormFieldFunction(
      String labelText, String hintText, String tfTexto, String msgError) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
      ),
      validator: (value) {
        return value.isEmpty ? msgError : null;
      },
      onSaved: (value) {
        return tfTexto = value;
      },
    );
  }
}
