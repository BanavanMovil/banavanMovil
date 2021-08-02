import 'package:banavanmov/model/enfundado.dart';
import 'package:banavanmov/providers/enfundadoProvider.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:banavanmov/vistaEnfundadoJBodega.dart';

import 'package:banavanmov/model/color.dart';
import 'package:banavanmov/model/lote.dart';
import 'package:banavanmov/providers/colorProvider.dart';
import 'package:banavanmov/model/personnel.dart';
import 'package:banavanmov/providers/personnelProvider.dart';
import 'package:banavanmov/model/semana.dart';
import 'package:banavanmov/providers/semanaProvider.dart';
import 'package:banavanmov/providers/loteProvider.dart';

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
  String user, personnelResult;
  String lote, loteResult;
  DateTime fecha;
  String semana, semanaResult;
  String fundas_entregadas, fundas_entregadasResult;
  ActualizarEnfundadoJBState(Enfundado enfunde) {
    this.enfundado = enfunde;
  }

  @override
  void initState() {
    super.initState();
    user = '';
    semana = '';
    fundas_entregadas = '';
    lote = '';
    personnelResult = '';
    semanaResult = '';
    fundas_entregadasResult = '';
    loteResult = '';
  }

  validarCampos() {
    return loteResult.isNotEmpty ||
        personnelResult != null ||
        semanaResult != null ||
        fundas_entregadasResult != null ||
        fecha != null;
  }

  _saveForm() {
    print(validarCampos());
    //print(trabajadorResult);
    //print(semanaResult);
    //print(fundas_entregadasResult);
    //print(fundas_recibidasResult);
    //print(fecha_entrega);

    if (validarCampos()) {
      EnfundadoProvider ep = new EnfundadoProvider();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Enfundado Actualizado')));
      //trabajadorResult = "null";
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        //return Footer();
        return EnfundadoVista();
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
                                titleText: 'Trabajador Actual: ' +
                                    enfundado.user_id.toString(),
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
                                titleText: 'Lote Actual: ' +
                                    enfundado.lote_id.toString(),
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
                        Text("Fecha de Enfundado Actual: " + enfundado.fecha),
                        Row(
                          children: <Widget>[
                            Text(fecha == null
                                ? "No ha seleccionado fecha"
                                : fecha.toString()),
                            Spacer(),
                            ElevatedButton(
                                onPressed: () {
                                  showDatePicker(
                                          context: context,
                                          initialDate: fecha == null
                                              ? DateTime.now()
                                              : fecha,
                                          firstDate: DateTime(2001),
                                          lastDate: DateTime(2222))
                                      .then((date) {
                                    setState(() {
                                      fecha = date;
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
                                    enfundado.semana_id.toString(),
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
                  Container(
                      child: Column(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text(
                        "Fundas Entregadas Actual: " +
                            enfundado.fundas_entregadas.toString(),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    new ListTile(
                      title: TextFormField(
                          //controller: _controller,
                          keyboardType: TextInputType.number,
                          onChanged: (newValue) {
                            setState(() {
                              fundas_entregadasResult = newValue;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              fundas_entregadasResult = value;
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
}
