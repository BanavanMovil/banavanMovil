import 'package:banavanmov/model/perdido.dart';
import 'package:banavanmov/providers/perdidoProvider.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:banavanmov/vistaPerdidosJBodega.dart';

import 'package:banavanmov/model/color.dart';
import 'package:banavanmov/providers/colorProvider.dart';

import 'package:banavanmov/model/lote.dart';
import 'package:banavanmov/model/personnel.dart';
import 'package:banavanmov/providers/personnelProvider.dart';
import 'package:banavanmov/model/semana.dart';
import 'package:banavanmov/providers/semanaProvider.dart';
import 'package:banavanmov/providers/loteProvider.dart';
import 'package:banavanmov/model/motivo.dart';
import 'package:banavanmov/providers/motivoProvider.dart';

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
  String trabajador, personnelResult;
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
    personnelResult = '';
    semanaResult = '';
    loteResult = '';
    colorResult = '';
    motivoResult = '';
  }

  validarCampos() {
    return loteResult.isNotEmpty ||
        personnelResult != null ||
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
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        //return Footer();
        return PerdidosVista();
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
                  Center(
                    child: FutureBuilder(
                      future: PersonnelProvider().getAll(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Personnel>> snapshot) {
                        if (snapshot.hasData) {
                          var personal = snapshot.data;
                          var personalDS = crearDataSourcePersonnel(personal);
                          return Container(
                              padding: EdgeInsets.all(10),
                              child: DropDownFormField(
                                titleText:
                                    'Trabajador Actual: ' + perdido.trabajador,
                                hintText: 'Elija el Trabajador',
                                value: personnelResult,
                                validator: (value) {
                                  if (value == null) {
                                    return "Por favor seleccione un trabajador";
                                  }
                                  return null;
                                },
                                onChanged: (newValue) {
                                  setState(() {
                                    personnelResult = newValue;
                                  });
                                },
                                onSaved: (value) {
                                  setState(() {
                                    personnelResult = value;
                                  });
                                },
                                dataSource: personalDS,
                                textField: 'display',
                                valueField: 'value',
                              ));
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  ),
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
                                titleText:
                                    'Lote Actual: ' + perdido.lote.toString(),
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
                  Center(
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
                                    perdido.semana.toString(),
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
                  ),
                  Center(
                    child: FutureBuilder(
                      future: MotivoProvider().getAll(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Motivo>> snapshot) {
                        if (snapshot.hasData) {
                          var motivos = snapshot.data;
                          var motivosDS = crearDataSourceMotivo(motivos);
                          return Container(
                              padding: EdgeInsets.all(10),
                              child: DropDownFormField(
                                titleText: 'Motivo Actual: ' +
                                    perdido.motivo.toString(),
                                hintText: 'Elija el Motivo',
                                value: motivoResult,
                                validator: (value) {
                                  if (value == null) {
                                    return "Por favor seleccione un motivo";
                                  }
                                  return null;
                                },
                                onChanged: (newValue) {
                                  setState(() {
                                    motivoResult = newValue;
                                  });
                                },
                                onSaved: (value) {
                                  setState(() {
                                    motivoResult = value;
                                  });
                                },
                                dataSource: motivosDS,
                                textField: 'display',
                                valueField: 'value',
                              ));
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  ),
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

  crearDataSourceColor(List<Colour> colores) {
    var lista = [];

    colores.forEach((element) {
      var pedazo = {
        "display": element.nombre.toString(),
        "value": element.nombre.toString()
      };
      lista.add(pedazo);
    });
    return lista;
  }

  crearDataSourcePersonnel(List<Personnel> personal) {
    var lista = [];

    personal.forEach((element) {
      var pedazo = {
        "display":
            element.nombres.toString() + ' ' + element.apellidos.toString(),
        "value": element.nombres.toString() + ' ' + element.apellidos.toString()
      };
      if (element.activo.toString() == '1') {
        lista.add(pedazo);
      }
    });
    return lista;
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

  crearDataSourceMotivo(List<Motivo> motivos) {
    var lista = [];

    motivos.forEach((element) {
      var pedazo = {
        "display": element.titulo.toString(),
        "value": element.titulo.toString()
      };

      lista.add(pedazo);
    });
    return lista;
  }
}
