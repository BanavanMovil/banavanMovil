//https://flutter-es.io/docs/cookbook/navigation/navigation-basics
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:banavanmov/model/enfundado.dart';
import 'package:banavanmov/vistaEnfundadoJBodega.dart';
import 'package:banavanmov/providers/enfundadoProvider.dart';

class PublicarEnfundadoJB extends StatefulWidget {
  @override
  _PublicarEnfundadoJBState createState() => _PublicarEnfundadoJBState();
}

class _PublicarEnfundadoJBState extends State<PublicarEnfundadoJB> {
  final _formKey = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();
  DateTime fecha_entrega;
  var usuario = TextEditingController();
  var semana = TextEditingController();
  var fundas_entregadas = TextEditingController();
  var fundas_recibidas = TextEditingController();

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

  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text('Registro Enfundador'),
        backgroundColor: Colors.orange,
        centerTitle: true,
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
                        labelText: 'Usuario',
                        //hintText: 'Ej: ',
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
                        //leading: const Icon(Icons.contact_mail),
                        title: Text(
                      'Ingrese el número de lote',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 17, color: Colors.grey),
                    )),
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
                    ),
                    new ListTile(
                        //leading: const Icon(Icons.star),
                        title: Row(
                      children: <Widget>[
                        Text(fecha_entrega == null
                            ? "No ha seleccionado fecha de entrega"
                            : fecha_entrega.toString()),
                        Spacer(),
                        ElevatedButton(
                            onPressed: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: fecha_entrega == null
                                          ? DateTime.now()
                                          : fecha_entrega,
                                      firstDate: DateTime(2001),
                                      lastDate: DateTime(2222))
                                  .then((date) {
                                setState(() {
                                  fecha_entrega = date;
                                });
                              });
                            },
                            child: Icon(Icons.date_range))
                      ],
                    )),
                    new ListTile(
                      //leading: const Icon(Icons.monetization_on),
                      title: TextFormField(
                          //controller: _controller,
                          keyboardType: TextInputType.number,
                          controller: semana,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            labelText: "Número de Semana",
                            //hintText: "whatever you want",
                            //icon: Icon(Icons.phone_iphone)
                          )),
                    ),
                    new ListTile(
                      //leading: const Icon(Icons.supervisor_account),

                      title: TextFormField(
                          //controller: _controller,
                          keyboardType: TextInputType.number,
                          controller: fundas_entregadas,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            labelText: "Número de Fundas Entregadas",
                            //hintText: "whatever you want",
                            //icon: Icon(Icons.phone_iphone)
                          )),
                    ),
                    new ListTile(
                      //leading: const Icon(Icons.contact_phone),

                      title: TextFormField(
                          //controller: _controller,
                          keyboardType: TextInputType.number,
                          controller: fundas_recibidas,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            labelText: "Número de Fundas Recibidas",
                            //hintText: "whatever you want",
                            //icon: Icon(Icons.phone_iphone)
                          )),
                    ),
                    new ListTile(
                        //leading: const Icon(Icons.contact_mail),
                        title: Text(
                      'Seleccione el color de cinta',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 17, color: Colors.grey),
                    )),
                    new ElevatedButton(
                      child: Text("Guardar",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15, color: Colors.white)),
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
    if (_formKey.currentState.validate()) {
      EnfundadoProvider ep = new EnfundadoProvider();
      //ep.postEnfundado(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Enfundado Creado')));
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      //return Footer();
      return EnfundadoVista();
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
