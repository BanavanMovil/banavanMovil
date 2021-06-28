//https://flutter-es.io/docs/cookbook/navigation/navigation-basics
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:banavanmov/model/cosechado.dart';
import 'package:banavanmov/vistaPerdidosJBodega.dart';
import 'package:banavanmov/providers/perdidoProvider.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

class PublicarPerdidoJB extends StatefulWidget {
  @override
  _PublicarPerdidoJBState createState() => _PublicarPerdidoJBState();
}

class _PublicarPerdidoJBState extends State<PublicarPerdidoJB> {
  final _formKey = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();
  String usuario, usuarioResult;
  DateTime fecha_entrega;
  String semana, semanaResult;
  String lote, loteResult;
  String color, colorResult;
  String motivo, motivoResult;

  @override
  void initState() {
    super.initState();
    usuario = '';
    semana = '';
    lote = '';
    color = '';
    motivo = '';
    usuarioResult = '';
    semanaResult = '';
    loteResult = '';
    colorResult = '';
    motivoResult = '';
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text('Registro Racimo Perdido'),
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
                            {"display": "52", "value": "52"},
                            {"display": "53", "value": "53"},
                            {"display": "54", "value": "54"},
                            {"display": "55", "value": "55"},
                            {"display": "56", "value": "56"},
                            {"display": "57", "value": "57"}
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
                            {"display": "2", "value": "2"},
                            {"display": "3", "value": "3"},
                            {"display": "4", "value": "4"}
                          ],
                          textField: 'display',
                          valueField: 'value',
                        )),
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
                            {"display": "Rojo", "value": "Rojo"},
                            {"display": "Verde", "value": "Verde"},
                            {"display": "Azul", "value": "Azul"},
                            {"display": "Amarillo", "value": "Amarillo"}
                          ],
                          textField: 'display',
                          valueField: 'value',
                        )),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: DropDownFormField(
                          titleText: 'Motivo de pérdida',
                          hintText: 'Elija el Motivo',
                          value: motivo,
                          validator: (value) {
                            if (value == null) {
                              return "Por favor elija un motivo.";
                            }
                            return null;
                          },
                          onChanged: (newValue) {
                            setState(() {
                              motivo = newValue;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              motivo = value;
                            });
                          },
                          dataSource: [
                            {
                              "display": "Mal Apuntalado",
                              "value": "Mal Apuntalado"
                            },
                            {
                              "display": "Eliminación de planta",
                              "value": "Eliminación de planta"
                            },
                            {
                              "display": "Caido del fruto",
                              "value": "Caida del fruto"
                            }
                          ],
                          textField: 'display',
                          valueField: 'value',
                        )),
                    new ElevatedButton(
                      child: Text("Guardar",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15, color: Colors.white)),
                      onPressed: uploadStatusPerdido,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void uploadStatusPerdido() async {
    print(_formKey.currentState.validate());
    if (_formKey.currentState.validate()) {
      PerdidoProvider pp = new PerdidoProvider();
      //ep.postEnfundado(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Perdido Creado')));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        //return Footer();
        return PerdidosVista();
      }));
    }
  }
}
