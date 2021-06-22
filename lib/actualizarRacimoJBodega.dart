import 'package:banavanmov/model/cosechado.dart';
import 'package:banavanmov/providers/cosechadoProvider.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ActualizarCosechadoJB extends StatefulWidget {
  Cosechado cosechado;
  ActualizarCosechadoJB(Cosechado cosechado) {
    this.cosechado = cosechado;
  }

  @override
  ActualizarCosechadoJBState createState() =>
      ActualizarCosechadoJBState(cosechado);
}

class ActualizarCosechadoJBState extends State<ActualizarCosechadoJB> {
  Cosechado cosechado;
  final _formKey = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();
  String lote, loteResult;
  String semana, semanaResult;
  String color, colorResult;
  String numRacimos, numRacimosResult;
  ActualizarCosechadoJBState(Cosechado cosechado) {
    this.cosechado = cosechado;
  }

  @override
  void initState() {
    super.initState();
    semana = '';
    lote = '';
    color = '';
    numRacimos = '';
    semanaResult = '';
    loteResult = '';
    colorResult = '';
    numRacimosResult = '';
  }

  validarCampos() {
    return loteResult.isNotEmpty ||
        semanaResult != null ||
        numRacimosResult != null;
  }

  _saveForm() {
    print(validarCampos());
    if (validarCampos()) {
      CosechadoProvider cp = new CosechadoProvider();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Cosechado Actualizado')));
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
        title: Text('Actualizar Racimo Cosechado'),
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
                          Text('Id de Cosechado: ' + cosechado.id.toString())),
                  Container(
                      padding: EdgeInsets.all(10),
                      child: DropDownFormField(
                        titleText: 'Lote Actual: ' + cosechado.lote.toString(),
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
                      padding: EdgeInsets.all(10),
                      child: DropDownFormField(
                        titleText:
                            'Semana Actual: ' + cosechado.semana.toString(),
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
                        "Número de Racimos Actual: " +
                            cosechado.numRacimos.toString(),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    new ListTile(
                      title: TextFormField(
                          //controller: _controller,
                          keyboardType: TextInputType.number,
                          onChanged: (newValue) {
                            setState(() {
                              numRacimosResult = newValue;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              numRacimosResult = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: "Número de Racimos Cosechados",
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
    );
  }
}
