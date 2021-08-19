import 'package:banavanmov/model/perdido.dart';
import 'package:banavanmov/providers/perdidoProvider.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

import 'package:flutter_number_picker/flutter_number_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:banavanmov/vistaPerdidosJBodega.dart';

import 'package:banavanmov/model/color.dart';
import 'package:intl/intl.dart';

import 'package:banavanmov/model/lote.dart';
import 'package:banavanmov/model/personnel.dart';
import 'package:banavanmov/providers/personnelProvider.dart';
import 'package:banavanmov/model/semana.dart';
import 'package:banavanmov/providers/semanaProvider.dart';
import 'package:banavanmov/providers/loteProvider.dart';
import 'package:banavanmov/model/motivo.dart';
import 'package:banavanmov/providers/motivoProvider.dart';
import 'package:banavanmov/model/color.dart';
import 'package:banavanmov/providers/colorProvider.dart';

import 'package:banavanmov/utils/dataSource.dart';

class NewObjectTwo {
  int id;
  int lote_id;
  int cantidad;
  int user_id;
  String fecha;
  int color_id;
  int perdida_motivo_id;

  NewObjectTwo({
    this.id,
    this.lote_id,
    this.cantidad,
    this.user_id,
    this.color_id,
    this.fecha,
    this.perdida_motivo_id,
  });

  factory NewObjectTwo.fromJson(Map<String, dynamic> json) => NewObjectTwo(
        id: json['id'],
        lote_id: json['lote_id'],
        cantidad: json['cantidad'],
        user_id: json['user_id'],
        color_id: json['color_id'],
        fecha: json['fecha'],
        perdida_motivo_id: json['perdida_motivo_id'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'lote_id': lote_id,
        'cantidad': cantidad,
        'user_id': user_id,
        'color_id': color_id,
        'fecha': fecha,
        'perdida_motivo_id': perdida_motivo_id,
      };
}

class ActualizarPerdidoJB extends StatefulWidget {
  Perdido perdido;
  ActualizarPerdidoJB(Perdido perdido) {
    this.perdido = perdido;
  }

  @override
  ActualizarPerdidoJBState createState() => ActualizarPerdidoJBState(perdido);
}

Map<String, String> todosLotes = {};
Map<String, String> todosColores = {};
Map<String, String> todosUsers = {};
Map<String, String> todosSemanas = {};
Map<String, String> todosSemanasColores = {};
Map<String, String> todosMotivos = {};

class ActualizarPerdidoJBState extends State<ActualizarPerdidoJB> {
  Perdido perdido;
  //final _formKey = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();

  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final DateFormat secondFormatter = DateFormat('yyyy-MM-dd');

  String _selectedId, _selectedIdResult;

  String _selectedLote, _selectedLoteResult;
  String _selectedCantidad, _selectedCantidadResult;
  String _selectedUser, _selectedUserResult;
  String _selectedPerdidaMotivo, _selectedPerdidaMotivoResult;
  DateTime _selectedFecha, _selectedFechaResult;
  String _selectedSemana, _selectedSemanaResult;

  String _selectedColor, _selectedColorResult;

  PerdidoProvider pp;

  final formKey = GlobalKey<FormState>();

  ActualizarPerdidoJBState(Perdido perdido) {
    this.perdido = perdido;
  }

  @override
  void initState() {
    super.initState();

    _selectedId = '';
    _selectedIdResult = '';

    _selectedLote = '';
    _selectedLoteResult = '';
    _selectedCantidad = '';
    _selectedCantidadResult = '';
    _selectedUser = '';
    _selectedUserResult = '';
    _selectedPerdidaMotivo = '';
    _selectedPerdidaMotivoResult = '';
    _selectedSemana = '';
    _selectedSemanaResult = '';
    _selectedColor = '';
    _selectedColorResult = '';

    pp = new PerdidoProvider();

    cargarDatosLotes();
    cargarDatosColores();
    cargarDatosUsers();
    cargarDatosSemanas();
    cargarDatosSemanasColores();
    cargarDatosMotivos();
  }

  _saveForm(/*BuildContext context*/) async {
    print("Entra al boton guardar");
    var form = formKey.currentState;
    if (form.validate() && _selectedFecha != null) {
      form.save();
      setState(() {
        _selectedLoteResult = _selectedLote;
        _selectedCantidadResult = _selectedCantidad;
        _selectedUserResult = _selectedUser;
        _selectedPerdidaMotivoResult = _selectedPerdidaMotivo;
        _selectedFechaResult = _selectedFecha;
        _selectedColorResult = _selectedColor;
      });

      NewObjectTwo not = new NewObjectTwo(
          id: int.parse(perdido.id.toString()),
          lote_id: int.parse(_selectedLoteResult),
          cantidad: int.parse(_selectedCantidadResult),
          user_id: int.parse(_selectedUserResult),
          perdida_motivo_id: int.parse(_selectedPerdidaMotivoResult),
          fecha: secondFormatter.format(_selectedFecha),
          color_id: int.parse(_selectedColorResult));

      if (await pp.updatePerdido(not)) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Racimo Perdido Actualizado'),
            action: SnackBarAction(
              label: 'Cerrar',
              onPressed: () {
                // Code to execute.
              },
            )));

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          //return Footer();
          return PerdidosVista();
        }));
      } else {
        _showDialogConfirm(context);
      }
    }
  }

  _showDialogConfirm(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (context) {
          return SimpleDialog(
            title: Center(child: Text("Error en los Datos")),
            children: <Widget>[
              Center(child: Text("No existe una semana para ese color.")),
              Placeholder(
                fallbackHeight: 7,
                fallbackWidth: 100,
                color: Colors.transparent,
              ),
              //Center(child: Text("")),
              Center(child: Text("Ese color no cumple con los")),
              Center(child: Text("requerimientos de edad.")),

              Placeholder(
                fallbackHeight: 10,
                fallbackWidth: 100,
                color: Colors.transparent,
              ),
              Center(
                  child: RaisedButton(
                      child: Text("Ok"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })),
            ],
          );
        });
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
              key: formKey,
              child: Scrollbar(
                child: ListView(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('Id de Perdido: ' + perdido.id.toString())),
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
                                titleText: 'Lote Actual: ' +
                                    todosLotes[perdido.lote_id.toString()],
                                hintText: 'Elija el Lote',
                                value: _selectedLote,
                                validator: (value) {
                                  if (value == null) {
                                    return "Por favor seleccione un lote";
                                  }
                                  return null;
                                },
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedLote = newValue;
                                  });
                                },
                                onSaved: (value) {
                                  setState(() {
                                    _selectedLote = value;
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
                      child: Column(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text(
                        "Número de Racimos Actual: " +
                            perdido.cantidad.toString(),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    new ListTile(
                      //leading: const Icon(Icons.supervisor_account),

                      title: TextFormField(
                          //controller: _controller,
                          keyboardType: TextInputType.number,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedCantidad = newValue;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              _selectedCantidad = value;
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
                            labelText: "Número de Racimos Perdidos",
                            //hintText: "whatever you want",
                            //icon: Icon(Icons.phone_iphone)
                          )),
                    ),
                  ])),
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
                                titleText: 'Trabajador Actual: ' +
                                    todosUsers[perdido.user_id.toString()],
                                hintText: 'Elija el Trabajador',
                                value: _selectedUser,
                                validator: (value) {
                                  if (value == null) {
                                    return "Por favor seleccione un trabajador";
                                  }
                                  return null;
                                },
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedUser = newValue;
                                  });
                                },
                                onSaved: (value) {
                                  setState(() {
                                    _selectedUser = value;
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
                  Container(
                    child: Column(
                      children: <Widget>[
                        Text("Fecha de Perdido Actual: " +
                            perdido.fecha.toString()),
                        Row(
                          children: <Widget>[
                            Text(_selectedFecha == null
                                ? "No ha seleccionado fecha"
                                : formatter.format(_selectedFecha)),
                            Spacer(),
                            ElevatedButton(
                                onPressed: () {
                                  showDatePicker(
                                          context: context,
                                          initialDate: _selectedFecha == null
                                              ? DateTime.now()
                                              : _selectedFecha,
                                          firstDate: DateTime(2001),
                                          lastDate: DateTime(2222))
                                      .then((date) async {
                                    if (date != null) {
                                      //print("FECHA: " + date.toString());
                                      setState(() {
                                        _selectedFecha = date;
                                      });
                                      return SemanaProvider()
                                          .getDateData(formatter.format(date));
                                    } else {
                                      setState(() {
                                        _selectedFecha = null;
                                      });
                                    }
                                  }).then((value) {
                                    //print("MAPA: " + value['numero']);
                                    setState(() {
                                      _selectedSemana =
                                          value['numero'].toString();

                                      _selectedSemanaResult =
                                          value['id'].toString();
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
                    padding: EdgeInsets.only(left: 15),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Semana: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                            Text(_selectedFecha != null
                                ? _selectedSemana.toString()
                                : '--')
                          ],
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: FutureBuilder(
                      future: MotivoProvider().getAll(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Motivo>> snapshot) {
                        if (snapshot.hasData) {
                          var motivos = snapshot.data;
                          var motivosDS =
                              DataSource().crearDataSourceMotivo(motivos);
                          return Container(
                              padding: EdgeInsets.all(10),
                              child: DropDownFormField(
                                titleText: 'Motivo Actual: ' +
                                    todosMotivos[
                                        perdido.perdida_motivo_id.toString()],
                                hintText: 'Elija el Motivo',
                                value: _selectedPerdidaMotivo,
                                validator: (value) {
                                  if (value == null) {
                                    return "Por favor seleccione un motivo";
                                  }
                                  return null;
                                },
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedPerdidaMotivo = newValue;
                                  });
                                },
                                onSaved: (value) {
                                  setState(() {
                                    _selectedPerdidaMotivo = value;
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
                  Center(
                    child: FutureBuilder(
                      future: ColorProvider().getAll(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Colour>> snapshot) {
                        if (snapshot.hasData) {
                          var colores = snapshot.data;
                          var coloresDS = crearDataSourceColor(colores);
                          return Container(
                              padding: EdgeInsets.all(10),
                              child: DropDownFormField(
                                titleText: 'Color Actual: ' +
                                    todosColores[todosSemanasColores[
                                        perdido.semana_id.toString()]],
                                hintText: 'Elija el Color',
                                value: _selectedColor,
                                validator: (value) {
                                  if (value == null) {
                                    return "Por favor seleccione un color";
                                  }
                                  return null;
                                },
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedColor = newValue;
                                  });
                                },
                                onSaved: (value) {
                                  setState(() {
                                    _selectedColor = value;
                                  });
                                },
                                dataSource: coloresDS,
                                textField: 'display',
                                valueField: 'value',
                              ));
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  ),
                  Center(
                      child: ElevatedButton(
                          child: Text('Actualizar'), onPressed: _saveForm)),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void cargarDatosLotes() async {
    LoteProvider _provider = LoteProvider();
    Future<List<Lote>> _futureOfList = _provider.todosLosLotes();
    List<Lote> list = await _futureOfList;
    list.forEach((element) {
      var newLote = Map<String, String>();
      newLote[element.id.toString()] = element.numero.toString();
      todosLotes.addAll(newLote);
    });
  }

  void cargarDatosColores() async {
    ColorProvider _provider = ColorProvider();
    Future<List<Colour>> _futureOfList = _provider.getAll();
    List<Colour> list = await _futureOfList;
    list.forEach((element) {
      var newColor = Map<String, String>();
      newColor[element.id.toString()] = element.nombre.toString();
      todosColores.addAll(newColor);
    });
    //var powerRanger = todosColores["17"];
    //print(powerRanger);
  }

  void cargarDatosUsers() async {
    PersonnelProvider _provider = PersonnelProvider();
    Future<List<Personnel>> _futureOfList = _provider.getAll();
    List<Personnel> list = await _futureOfList;
    list.forEach((element) {
      var newPersonnel = Map<String, String>();
      newPersonnel[element.id.toString()] =
          element.nombres.toString() + " " + element.apellidos.toString();
      todosUsers.addAll(newPersonnel);
    });
    //var powerRanger = todosColores["17"];
    //print(powerRanger);
  }

  void cargarDatosSemanas() async {
    SemanaProvider _provider = SemanaProvider();
    Future<List<Semana>> _futureOfList = _provider.getAll();
    List<Semana> list = await _futureOfList;
    list.forEach((element) {
      var newSemana = Map<String, String>();
      newSemana[element.id.toString()] = element.numero.toString();
      todosSemanas.addAll(newSemana);
    });
    //var powerRanger = todosColores["17"];
    //print(powerRanger);
  }

  void cargarDatosMotivos() async {
    MotivoProvider _provider = MotivoProvider();
    Future<List<Motivo>> _futureOfList = _provider.getAll();
    List<Motivo> list = await _futureOfList;
    list.forEach((element) {
      var newMotivo = Map<String, String>();
      newMotivo[element.id.toString()] = element.titulo.toString();
      todosMotivos.addAll(newMotivo);
    });
    //var powerRanger = todosColores["17"];
    //print(powerRanger);
  }

  void cargarDatosSemanasColores() async {
    SemanaProvider _provider = SemanaProvider();
    Future<List<Semana>> _futureOfList = _provider.getAll();
    List<Semana> list = await _futureOfList;
    list.forEach((element) {
      var newSemana = Map<String, String>();
      newSemana[element.id.toString()] = element.color_id.toString();
      todosSemanasColores.addAll(newSemana);
    });
    //var powerRanger = todosColores["17"];
    //print(powerRanger);
  }

  crearDataSourceColor(List<Colour> colores) {
    var lista = [];

    colores.forEach((element) {
      var pedazo = {
        "display": element.nombre.toString(),
        "value": element.id.toString()
      };
      lista.add(pedazo);
    });
    return lista;
  }
}
