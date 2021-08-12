import 'package:banavanmov/model/perdido.dart';
import 'package:banavanmov/providers/perdidoProvider.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

import 'package:flutter_number_picker/flutter_number_picker.dart';

import 'package:flutter/material.dart';
import 'package:banavanmov/vistaPerdidosJBodega.dart';

import 'package:banavanmov/model/color.dart';

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

  String _selectedId, _selectedIdResult;

  String _selectedLote, _selectedLoteResult;
  int _selectedCantidad, _selectedCantidadResult;
  String _selectedUser, _selectedUserResult;
  String _selectedPerdidaMotivo, _selectedPerdidaMotivoResult;
  DateTime _selectedFecha, _selectedFechaResult;
  //String _selectedSemana, _selectedSemanaResult;

  String _selectedColor, _selectedColorResult;

  PerdidoProvider pp;

  final formKey = GlobalKey<FormState>();

  /*String trabajador, personnelResult;
  String lote, loteResult;
  // ignore: non_constant_identifier_names
  DateTime fecha_registro;
  String semana, semanaResult;
  String color, colorResult;
  String motivo, motivoResult;*/

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
    _selectedCantidad = 0;
    _selectedCantidadResult = 0;
    _selectedUser = '';
    _selectedUserResult = '';
    _selectedPerdidaMotivo = '';
    _selectedPerdidaMotivoResult = '';
    //_selectedSemana = '';
    //_selectedSemanaResult = '';
    _selectedColor = '';
    _selectedColorResult = '';

    pp = new PerdidoProvider();

    cargarDatosLotes();
    cargarDatosColores();
    cargarDatosUsers();
    cargarDatosSemanas();
    cargarDatosSemanasColores();
    cargarDatosMotivos();

    /*trabajador = '';
    semana = '';
    lote = '';
    color = '';
    motivo = '';
    personnelResult = '';
    semanaResult = '';
    loteResult = '';
    colorResult = '';
    motivoResult = '';*/
  }

  _saveForm(/*BuildContext context*/) {
    print("Entra al boton guardar");
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        //_selectedIdResult = _selectedId;
        _selectedLoteResult = _selectedLote;
        _selectedCantidadResult = _selectedCantidad;
        _selectedUserResult = _selectedUser;
        _selectedPerdidaMotivoResult = _selectedPerdidaMotivo;
        _selectedFechaResult = _selectedFecha;
        //_selectedSemanaResult = _selectedSemana;
        _selectedColorResult = _selectedColor;
      });

      List<String> _arrayNewFecha = _selectedFechaResult.toString().split(' ');

      NewObjectTwo not = new NewObjectTwo(
          id: int.parse(perdido.id.toString()),
          lote_id: int.parse(_selectedLoteResult),
          cantidad: _selectedCantidadResult,
          user_id: int.parse(_selectedUserResult),
          perdida_motivo_id: int.parse(_selectedPerdidaMotivoResult),
          //fecha: _selectedFechaResult.toString(),
          fecha: _arrayNewFecha[0],
          color_id: int.parse(_selectedColorResult));

      pp.updatePerdido(not);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Racimo Cosechado Actualizado'),
          action: SnackBarAction(
            label: 'Cerrar',
            onPressed: () {
              // Code to execute.
            },
          )));

      /*Cosechado c = new Cosechado(
          id: -1,
          lote_id: int.parse(_selectedLoteResult),
          cantidad: _selectedCantidadResult,
          user_id: int.parse(_selectedUserResult),
          //fecha: _selectedFechaResult.toString(),
          fecha: _arrayNewFecha[0],
          semana_id: int.parse(_selectedSemanaResult));*/

      /*cp.sendCosechado(c);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Racimo Cosechado Creado'),
          action: SnackBarAction(
            label: 'Cerrar',
            onPressed: () {
              // Code to execute.
            },
          )));*/

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        //return Footer();
        return PerdidosVista();
      }));
    }
  }

  /*validarCampos() {
    return loteResult.isNotEmpty ||
        personnelResult != null ||
        semanaResult != null ||
        motivoResult != null ||
        fecha_registro != null;
  }*/

  /*_saveForm() {
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
  }*/

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
                      child: Text('Id de Enfundado: ' + perdido.id.toString())),
                  /*Center(
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
                                    perdido.user_id.toString(),
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
                  ),*/
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
                    CustomNumberPicker(
                      initialValue: 0,
                      maxValue: 10000,
                      minValue: 0,
                      onValue: (value) {
                        this._selectedCantidad = value;
                        print(this._selectedCantidad);
                      },
                    )

                    /*new ListTile(
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
                          decoration: InputDecoration(
                            labelText: "Número de Racimos Cosechados",
                          )),
                    ),*/
                  ])),
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
                        Text("Fecha de Cosechado Actual: " + perdido.fecha),
                        Row(
                          children: <Widget>[
                            Text(_selectedFecha == null
                                ? "No ha seleccionado fecha"
                                : _selectedFecha.toString()),
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
                                      .then((date) {
                                    setState(() {
                                      _selectedFecha = date;
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
                  /*Center(
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
                                    perdido.lote_id.toString(),
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
                  ),*/
                  /*Container(
                    child: Column(
                      children: <Widget>[
                        Text("Fecha de Enfundado Actual: " + perdido.fecha),
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
                                    perdido.semana_id.toString(),
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
                                    perdido.perdida_motivo_id.toString(),
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
                  ),*/
                  /*ElevatedButton(
                    child: Text("Actualizar",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                    onPressed: _saveForm,
                  ),*/
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

  crearDataSourcePersonnel(List<Personnel> personal) {
    var lista = [];

    personal.forEach((element) {
      var pedazo = {
        "display":
            element.nombres.toString() + ' ' + element.apellidos.toString(),
        "value": element.id.toString()
      };
      if (element.activo.toString() == '1') {
        lista.add(pedazo);
      }
    });
    return lista;
  }

  /*crearDataSourceSemana(List<Semana> semanas) {
    var lista = [];

    semanas.forEach((element) {
      var pedazo = {
        "display": element.numero.toString(),
        "value": element.id.toString()
      };

      lista.add(pedazo);
    });
    return lista;
  }*/

  crearDataSourceLote(List<Lote> lotes) {
    var lista = [];

    lotes.forEach((element) {
      var pedazo = {
        "display": element.numero.toString(),
        "value": element.id.toString()
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
        "value": element.id.toString()
      };

      lista.add(pedazo);
    });
    return lista;
  }
}
