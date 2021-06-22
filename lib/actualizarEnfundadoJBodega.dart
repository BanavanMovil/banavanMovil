import 'package:banavanmov/model/enfundado.dart';
import 'package:banavanmov/providers/enfundadoProvider.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ActualizarEnfundadoJB extends StatefulWidget {
  Enfundado enfunde;
  ActualizarEnfundadoJB(Enfundado enfunde) {
    this.enfunde = enfunde;
  }

  @override
  ActualizarEnfundadoJBState createState() =>
      ActualizarEnfundadoJBState(enfunde);
}

class ActualizarEnfundadoJBState extends State<ActualizarEnfundadoJB> {
  Enfundado enfundado;
  final _formKey = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();
  String trabajador, trabajadorResult;
  String lote, loteResult;
  DateTime fecha_entrega;
  String semana, semanaResult;
  String fundas_recibidas, fundas_recibidasResult;
  String fundas_entregadas, fundas_entregadasResult;
  String color, colorResult;
  ActualizarEnfundadoJBState(Enfundado enfunde) {
    this.enfundado = enfunde;
  }

  @override
  void initState() {
    super.initState();
    trabajador = '';
    semana = '';
    fundas_entregadas = '';
    fundas_recibidas = '';
    lote = '';
    color = '';
    trabajador = '';
    semanaResult = '';
    fundas_entregadasResult = '';
    fundas_recibidasResult = '';
    loteResult = '';
    colorResult = '';
  }

  validarCampos() {
    return loteResult.isNotEmpty ||
        trabajadorResult != null ||
        semanaResult != null ||
        fundas_entregadasResult != null ||
        fundas_recibidas != null ||
        fecha_entrega != null;
  }

  _saveForm() {
    print(validarCampos());
    if (validarCampos()) {
      EnfundadoProvider ep = new EnfundadoProvider();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Enfundado Actualizado')));
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
        title: Text('Actualizar Enfundado'),
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
                      child:
                          Text('Id de Enfundado: ' + enfundado.id.toString())),
                  Container(
                      padding: EdgeInsets.all(10),
                      child: DropDownFormField(
                        titleText: 'Trabajador Actual: ' + enfundado.trabajador,
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
                        titleText: 'Lote Actual: ' + enfundado.lote.toString(),
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
                            enfundado.fechaEntrega),
                        Row(
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
                        )
                      ],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      child: DropDownFormField(
                        titleText:
                            'Semana Actual: ' + enfundado.semana.toString(),
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
                      child: Column(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text(
                        "Fundas Recibidas Actual: " +
                            enfundado.fundasRecibidas.toString(),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    new ListTile(
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
                          decoration: InputDecoration(
                            labelText: "Número de Fundas Recibidas",
                          )),
                    ),
                  ])),
                  Container(
                      child: Column(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text(
                        "Fundas Entregadas Actual: " +
                            enfundado.fundasEntregadas.toString(),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    new ListTile(
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
                          decoration: InputDecoration(
                            labelText: "Número de Fundas Entregadas",
                          )),
                    ),
                  ])),
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
      //backgroundColor: Colors.green,
    );
  }
}
