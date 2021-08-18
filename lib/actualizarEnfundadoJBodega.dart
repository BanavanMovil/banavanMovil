import 'package:banavanmov/model/enfundado.dart';
import 'package:banavanmov/providers/enfundadoProvider.dart';
import 'package:banavanmov/utils/dataSource.dart';
import 'package:banavanmov/utils/util.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

import 'package:flutter/material.dart';
import 'package:banavanmov/vistaEnfundadoJBodega.dart';

import 'package:banavanmov/model/color.dart';
import 'package:banavanmov/model/lote.dart';

import 'package:banavanmov/model/personnel.dart';
import 'package:banavanmov/providers/personnelProvider.dart';
import 'package:banavanmov/model/semana.dart';
import 'package:banavanmov/providers/semanaProvider.dart';
import 'package:banavanmov/providers/loteProvider.dart';
import 'package:intl/intl.dart';

class ActualizarEnfundadoJB extends StatefulWidget {
  final Enfundado enfunde;
  final Map<String, dynamic> datos;
  ActualizarEnfundadoJB({this.enfunde, this.datos});

  @override
  ActualizarEnfundadoJBState createState() =>
      ActualizarEnfundadoJBState(enfunde);
}

class ActualizarEnfundadoJBState extends State<ActualizarEnfundadoJB> {
  Enfundado enfundado;
  final _formKey = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final DateFormat secondFormatter = DateFormat('yyyy-MM-dd');
  String user, personnelResult;
  String lote, loteResult;
  DateTime fecha;
  String semana, semanaResult;
  String color;
  Map<String, dynamic> datos;
  EnfundadoProvider ep;
  // ignore: non_constant_identifier_names
  String fundas_entregadas, fundas_entregadasResult;
  ActualizarEnfundadoJBState(Enfundado enfunde) {
    this.enfundado = enfunde;
  }

  @override
  void initState() {
    super.initState();
    datos = widget.datos;
    user = '';
    semana = '';
    fundas_entregadas = '';
    lote = '';
    personnelResult = '';
    semanaResult = '';
    fundas_entregadasResult = '';
    loteResult = '';
    ep = new EnfundadoProvider();
  }

  validarCampos() {
    return loteResult.isNotEmpty ||
        personnelResult != null ||
        semanaResult != null ||
        fundas_entregadasResult != null ||
        fecha != null;
  }

  _saveForm() {
    var form = _formKey.currentState;
    print("Semana: " + semana);
    if (form.validate() && fecha != null) {
      form.save();
      print("Personnel Result: " + personnelResult);
      Enfundado e = new Enfundado(
          id: enfundado.id,
          lote_id: int.parse(loteResult),
          user_id: int.parse(personnelResult),
          fundas_entregadas: int.parse(fundas_entregadasResult),
          fecha: secondFormatter.format(fecha),
          semana_id: int.parse(semanaResult),
          cantidad: int.parse(fundas_entregadasResult));
      print("Se va a actualizar el enfundado");
      ep.updateEnfundado(e);
      print("Seactualizo enfundado");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Datos Erroneos o incompletos'),
          action: SnackBarAction(
            label: 'Cerrar',
            onPressed: () {
              // Code to execute.
            },
          )));
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
                          var personalDS =
                              DataSource().crearDataSourcePersonnel(personal);
                          return Container(
                              padding: EdgeInsets.all(10),
                              child: DropDownFormField(
                                titleText:
                                    'Trabajador Actual: ' + datos['trabajador'],
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
                          var loteDS = DataSource().crearDataSourceLote(lote);
                          return Container(
                              padding: EdgeInsets.all(10),
                              child: DropDownFormField(
                                titleText:
                                    'Lote Actual: ' + datos['lote'].toString(),
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
                                : secondFormatter.format(fecha)),
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
                                      .then((date) async {
                                    if (date != null) {
                                      print("FECHA: " + date.toString());
                                      setState(() {
                                        fecha = date;
                                      });
                                      return SemanaProvider()
                                          .getDateData(formatter.format(date));
                                    } else {
                                      setState(() {
                                        fecha = null;
                                      });
                                    }
                                  }).then((value) {
                                    print("MAPA: " + value['numero']);
                                    setState(() {
                                      color = value['color_code'];
                                      semana = value['numero'].toString();
                                      //color = value['color_code'];
                                      //print(color);
                                      //print("TERMINA EL SET STATE");
                                      semanaResult = value['id'].toString();
                                    });
                                    /*setState(() {
                                  semana = value['id'];
                                });*/
                                  });
                                },
                                child: Icon(Icons.date_range))
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                      child: Row(
                    children: <Widget>[
                      Text(
                        "Semana Actual: ",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text(datos['semana'].numero),
                      Text("   "),
                      Text(
                        "Semana Nueva:  ",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text(fecha != null ? semana.toString() : "--")
                    ],
                  )),
                  Container(
                      child: Row(
                    children: <Widget>[
                      Text(
                        "Color Actual: ",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(Icons.crop_square_sharp),
                        onPressed: () {},
                        color: DataSource().getColorFromHex(datos['color']),
                      ),
                      Text("   "),
                      Text(
                        "Color  Nuevo:  ",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      fecha != null
                          ? IconButton(
                              icon: Icon(Icons.crop_square_sharp),
                              onPressed: () {},
                              color: DataSource().getColorFromHex(color),
                            )
                          : Text("--")
                    ],
                  )),
                  Container(
                      child: Column(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 5.0, top: 10.0),
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
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Ingrese un valor.";
                            }
                            return null;
                          },
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
}
