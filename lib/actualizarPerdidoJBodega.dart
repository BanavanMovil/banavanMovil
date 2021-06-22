import 'package:banavanmov/model/perdido.dart';
import 'package:banavanmov/providers/perdidoProvider.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ActualizarPerdidoJB extends StatefulWidget {
  Perdido perdido;
  ActualizarPerdidoJB(Perdido perdido) {
    this.perdido = perdido;
  }

  @override
  ActualizarPerdidoJBState createState() => ActualizarPerdidoJBState(perdido);
}

class ActualizarPerdidoJBState extends State<ActualizarPerdidoJB> {
  Perdido perdido;
  final _formKey = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();
  String trabajador, trabajadorResult;
  String lote, loteResult;
  DateTime fecha_registro;
  String semana, semanaResult;
  String color, colorResult;
  String motivo, motivoResult;
  ActualizarPerdidoJBState(Perdido perdido) {
    this.perdido = perdido;
  }

  @override
  void initState() {
    super.initState();
    trabajador = '';
    semana = '';
    lote = '';
    color = '';
    motivo = '';
    trabajadorResult = '';
    semanaResult = '';
    loteResult = '';
    colorResult = '';
    motivoResult = '';
  }

  validarCampos() {
    return loteResult.isNotEmpty ||
        trabajadorResult != null ||
        semanaResult != null ||
        motivoResult != null ||
        fecha_registro != null;
  }

  _saveForm() {
    print(validarCampos());
    if (validarCampos()) {
      PerdidoProvider pp = new PerdidoProvider();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Perdido Actualizado')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No hay cambios en los campos')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text('Actualizar Racimo Perdido'),
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
                child: ListView(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('Id de Enfundado: ' + perdido.id.toString())),
                  Container(
                      padding: EdgeInsets.all(10),
                      child: DropDownFormField(
                        titleText: 'Trabajador Actual: ' + perdido.trabajador,
                        hintText: 'Elija un Nuevo Trabajador',
                        value: trabajador,
                        onChanged: (newValue) {
                          setState(() {
                            trabajador = newValue;
                          });
                        },
                        onSaved: (value) {
                          setState(() {
                            trabajador = value;
                          });
                        },
                        dataSource: [
                          {"display": "52", "value": "1"},
                          {"display": "54", "value": "6"}
                        ],
                        textField: 'display',
                        valueField: 'value',
                      )),
                  Container(
                      padding: EdgeInsets.all(10),
                      child: DropDownFormField(
                        titleText: 'Lote Actual: ' + perdido.lote.toString(),
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
                  Container(
                    child: Column(
                      children: <Widget>[
                        Text("Fecha de Enfundado Actual: " +
                            perdido.fechaRegistro),
                        Row(
                          children: <Widget>[
                            Text(fecha_registro == null
                                ? "No ha seleccionado fecha"
                                : fecha_registro.toString()),
                            Spacer(),
                            ElevatedButton(
                                onPressed: () {
                                  showDatePicker(
                                          context: context,
                                          initialDate: fecha_registro == null
                                              ? DateTime.now()
                                              : fecha_registro,
                                          firstDate: DateTime(2001),
                                          lastDate: DateTime(2222))
                                      .then((date) {
                                    setState(() {
                                      fecha_registro = date;
                                    });
                                  });
                                },
                                child: Icon(Icons.date_range))
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      child: DropDownFormField(
                        titleText:
                            'Semana Actual: ' + perdido.semana.toString(),
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
                  Container(
                      padding: EdgeInsets.all(10),
                      child: DropDownFormField(
                        titleText: 'Motivo Actual: ' + perdido.motivo,
                        hintText: 'Elija un Nuevo Motivo',
                        value: motivo,
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
                          {"display": "52", "value": "1"},
                          {"display": "54", "value": "6"}
                        ],
                        textField: 'display',
                        valueField: 'value',
                      )),
                  ElevatedButton(
                    child: Text("Actualizar",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                    onPressed: _saveForm,
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
