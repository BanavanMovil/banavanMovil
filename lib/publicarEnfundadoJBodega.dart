//https://flutter-es.io/docs/cookbook/navigation/navigation-basics
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:banavanmov/model/enfundado.dart';
import 'package:banavanmov/vistaEnfundadoJBodega.dart';
import 'package:banavanmov/providers/enfundadoProvider.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

class PublicarEnfundadoJB extends StatefulWidget {
  @override
  _PublicarEnfundadoJBState createState() => _PublicarEnfundadoJBState();
}

class _PublicarEnfundadoJBState extends State<PublicarEnfundadoJB> {
  final _formKey = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();
  DateTime fecha_entrega;
  String usuario, usuarioResult;
  String semana, semanaResult;
  String lote, loteResult;
  String fundas_entregadas, fundas_entregadasResult;
  String fundas_recibidas, fundas_recibidasResult;
  String color, colorResult;

  @override
  void initState() {
    super.initState();
    usuario = '';
    semana = '';
    fundas_entregadas = '';
    fundas_recibidas = '';
    lote = '';
    color = '';
    usuarioResult = '';
    semanaResult = '';
    fundas_entregadasResult = '';
    fundas_recibidasResult = '';
    loteResult = '';
    colorResult = '';
  }

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
                    Container(
                        padding: EdgeInsets.all(10),
                        child: DropDownFormField(
                          titleText: 'Trabajador',
                          hintText: 'Elija el Trabajador',
                          value: usuario,
                          validator: (value) {
                            if (value == null) {
                              return "Por favor seleccione un trabajador.";
                            }
                            return null;
                          },
                          onChanged: (newValue) {
                            setState(() {
                              usuario = newValue;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              usuario = value;
                            });
                          },
                          dataSource: [
                            {"display": "Carlos Salazar", "value": "1"},
                            {"display": "Livingston Perez", "value": "5"}
                          ],
                          textField: 'display',
                          valueField: 'value',
                        )),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: DropDownFormField(
                          titleText: 'Lote',
                          hintText: 'Elija el Lote',
                          value: lote,
                          validator: (value) {
                            if (value == null) {
                              return "Por favor seleccione un lote";
                            }
                            return null;
                          },
                          onChanged: (newValue) {
                            setState(() {
                              lote = newValue;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              lote = value;
                            });
                          },
                          dataSource: [
                            {"display": "1", "value": "1"},
                            {"display": "2", "value": "2"}
                          ],
                          textField: 'display',
                          valueField: 'value',
                        )),
                    new ListTile(
                        //leading: const Icon(Icons.star),
                        title: Row(
                      children: <Widget>[
                        Text(fecha_entrega == null
                            ? "No ha seleccionado fecha"
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
                    Container(
                        padding: EdgeInsets.all(10),
                        child: DropDownFormField(
                          titleText: 'Semana',
                          hintText: 'Elija la Semana',
                          value: semana,
                          validator: (value) {
                            if (value == null) {
                              return "Por favor elija una semana.";
                            }
                            return null;
                          },
                          onChanged: (newValue) {
                            setState(() {
                              semana = newValue;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              semana = value;
                            });
                          },
                          dataSource: [
                            {"display": "52", "value": "1"},
                            {"display": "54", "value": "6"}
                          ],
                          textField: 'display',
                          valueField: 'value',
                        )),
                    new ListTile(
                      //leading: const Icon(Icons.supervisor_account),

                      title: TextFormField(
                          //controller: _controller,
                          keyboardType: TextInputType.number,
                          onChanged: (newValue) {
                            setState(() {
                              fundas_entregadas = newValue;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              fundas_entregadas = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Ingrese un valor.";
                            }
                            return null;
                          },
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
                          onChanged: (newValue) {
                            setState(() {
                              fundas_recibidas = newValue;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              fundas_recibidas = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Por favor ingrese un valor.";
                            }
                            return null;
                          },
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            labelText: "Número de Fundas Recibidas",
                            //hintText: "whatever you want",
                            //icon: Icon(Icons.phone_iphone)
                          )),
                    ),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: DropDownFormField(
                          titleText: 'Color de cinta',
                          hintText: 'Elija el Color',
                          value: color,
                          validator: (value) {
                            if (value == null) {
                              return "Por favor elija un color.";
                            }
                            return null;
                          },
                          onChanged: (newValue) {
                            setState(() {
                              color = newValue;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              color = value;
                            });
                          },
                          dataSource: [
                            {"display": "Rojo", "value": "6546"},
                            {"display": "Verde", "value": "5416"}
                          ],
                          textField: 'display',
                          valueField: 'value',
                        )),
                    new ElevatedButton(
                      child: Text("Guardar",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15, color: Colors.white)),
                      onPressed: uploadStatusEnfundado,
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

  void uploadStatusEnfundado() async {
    print(_formKey.currentState.validate());
    if (_formKey.currentState.validate()) {
      EnfundadoProvider ep = new EnfundadoProvider();
      //ep.postEnfundado(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Enfundado Creado')));
    }
    /*Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      //return Footer();
      return EnfundadoVista();
    }));*/
    // }
  }

  cargarTrabajadores() {
    //TODO
  }

  cargarLotes() {
    //TODO
  }
}
