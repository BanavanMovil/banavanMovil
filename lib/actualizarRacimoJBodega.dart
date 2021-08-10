import 'package:banavanmov/model/cosechado.dart';
import 'package:banavanmov/providers/cosechadoProvider.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

import 'package:flutter/material.dart';
import 'package:banavanmov/vistaRacimosJBodega.dart';

import 'package:banavanmov/model/lote.dart';
import 'package:banavanmov/model/semana.dart';
import 'package:banavanmov/providers/semanaProvider.dart';
import 'package:banavanmov/providers/loteProvider.dart';

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
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        //return Footer();
        return RacimosVista();
      }));
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
                  Center(
                    child: FutureBuilder(
                      future: LoteProvider().todosLosLotes(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Lote>> snapshot) {
                        if (snapshot.hasData) {
                          var lote = snapshot.data;
                          var loteDS = crearDataSourceLote(lote);
                          return Container(
                              padding: EdgeInsets.all(10),
                              child: DropDownFormField(
                                titleText: 'Lote Actual: ' +
                                    cosechado.lote_id.toString(),
                                hintText: 'Elija el Lote',
                                value: loteResult,
                                validator: (value) {
                                  if (value == null) {
                                    return "Por favor seleccione un lote";
                                  }
                                  return null;
                                },
                                onChanged: (newValue) {
                                  setState(() {
                                    loteResult = newValue;
                                  });
                                },
                                onSaved: (value) {
                                  setState(() {
                                    loteResult = value;
                                  });
                                },
                                dataSource: loteDS,
                                textField: 'display',
                                valueField: 'value',
                              ));
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  ),
                  /*Center(
                    child: FutureBuilder(
                      future: SemanaProvider().getAll(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Semana>> snapshot) {
                        if (snapshot.hasData) {
                          var semana = snapshot.data;
                          var semanaDS = crearDataSourceSemana(semana);
                          return Container(
                              padding: EdgeInsets.all(10),
                              child: DropDownFormField(
                                titleText: 'Semana Actual: ' +
                                    cosechado.semana_id.toString(),
                                hintText: 'Elija la Semana',
                                value: semanaResult,
                                validator: (value) {
                                  if (value == null) {
                                    return "Por favor seleccione una semana";
                                  }
                                  return null;
                                },
                                onChanged: (newValue) {
                                  setState(() {
                                    semanaResult = newValue;
                                  });
                                },
                                onSaved: (value) {
                                  setState(() {
                                    semanaResult = value;
                                  });
                                },
                                dataSource: semanaDS,
                                textField: 'display',
                                valueField: 'value',
                              ));
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  ),*/
                  Container(
                      child: Column(children: <Widget>[
                    /*Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text(
                        "Número de Racimos Actual: " +
                            cosechado.cantidad.toString(),
                        textAlign: TextAlign.left,
                      ),
                    ),*/
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

  crearDataSourceSemana(List<Semana> semanas) {
    var lista = [];

    semanas.forEach((element) {
      var pedazo = {
        "display": element.numero.toString(),
        "value": element.numero.toString()
      };

      lista.add(pedazo);
    });
    return lista;
  }

  crearDataSourceLote(List<Lote> lotes) {
    var lista = [];

    lotes.forEach((element) {
      var pedazo = {
        "display": element.numero.toString(),
        "value": element.numero.toString()
      };

      lista.add(pedazo);
    });
    return lista;
  }
}
