//https://flutter-es.io/docs/cookbook/navigation/navigation-basics
import 'package:flutter/material.dart';
import 'package:banavanmov/vistaPerdidosJBodega.dart';
import 'package:banavanmov/providers/perdidoProvider.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:banavanmov/model/perdido.dart';

import 'package:flutter_number_picker/flutter_number_picker.dart';

import 'package:banavanmov/model/color.dart';
import 'package:banavanmov/providers/colorProvider.dart';

import 'package:banavanmov/model/lote.dart';
import 'package:banavanmov/model/motivo.dart';
import 'package:banavanmov/providers/motivoProvider.dart';
import 'package:banavanmov/model/personnel.dart';
import 'package:banavanmov/providers/personnelProvider.dart';
import 'package:banavanmov/model/semana.dart';
import 'package:banavanmov/providers/semanaProvider.dart';
import 'package:banavanmov/providers/loteProvider.dart';

class PublicarPerdidoJB extends StatefulWidget {
  @override
  _PublicarPerdidoJBState createState() => _PublicarPerdidoJBState();
}

class _PublicarPerdidoJBState extends State<PublicarPerdidoJB> {
  final globalKey = GlobalKey<ScaffoldState>();

  String _selectedLote, _selectedLoteResult;
  int _selectedCantidad, _selectedCantidadResult;
  String _selectedUser, _selectedUserResult;
  String _selectedPerdidaMotivo, _selectedPerdidaMotivoResult;
  DateTime _selectedFecha, _selectedFechaResult;
  String _selectedSemana, _selectedSemanaResult;

  PerdidoProvider pp;

  final formKey = GlobalKey<FormState>();

  //String usuario, personnelResult;
  //DateTime fecha_entrega;
  //String semana, semanaResult;
  //String lote, loteResult;
  //String color, colorResult;
  //String motivo, motivoResult;

  @override
  void initState() {
    super.initState();

    _selectedLote = '';
    _selectedLoteResult = '';
    _selectedCantidad = 0;
    _selectedCantidadResult = 0;
    _selectedUser = '';
    _selectedUserResult = '';
    _selectedPerdidaMotivo = '';
    _selectedPerdidaMotivoResult = '';
    _selectedSemana = '';
    _selectedSemanaResult = '';

    pp = new PerdidoProvider();
  }

  _saveForm(/*BuildContext context*/) {
    print("Entra al boton guardar");
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _selectedLoteResult = _selectedLote;
        _selectedCantidadResult = _selectedCantidad;
        _selectedUserResult = _selectedUser;
        _selectedPerdidaMotivoResult = _selectedPerdidaMotivo;
        _selectedFechaResult = _selectedFecha;
        _selectedSemanaResult = _selectedSemana;
      });

      List<String> _arrayNewFecha = _selectedFechaResult.toString().split(' ');

      Perdido p = new Perdido(
          id: -1,
          lote_id: int.parse(_selectedLoteResult),
          cantidad: _selectedCantidadResult,
          user_id: int.parse(_selectedUserResult),
          perdida_motivo_id: int.parse(_selectedPerdidaMotivoResult),
          //fecha: _selectedFechaResult.toString(),
          fecha: _arrayNewFecha[0],
          semana_id: int.parse(_selectedSemanaResult));

      pp.sendPerdido(p);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Racimo Perdido Creado'),
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
              key: formKey,
              child: Scrollbar(
                child: ListView(
                  children: <Widget>[
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
                                  titleText: 'Trabajador',
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
                    new ListTile(
                        //leading: const Icon(Icons.star),
                        title: Row(
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
                    )),
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
                                  titleText: 'Semana',
                                  hintText: 'Elija la Semana',
                                  value: _selectedSemana,
                                  validator: (value) {
                                    if (value == null) {
                                      return "Por favor seleccione una semana";
                                    }
                                    return null;
                                  },
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedSemana = newValue;
                                    });
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      _selectedSemana = value;
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
                        future: LoteProvider().todosLosLotes(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Lote>> snapshot) {
                          if (snapshot.hasData) {
                            var lote = snapshot.data;
                            var loteDS = crearDataSourceLote(lote);
                            return Container(
                                padding: EdgeInsets.all(10),
                                child: DropDownFormField(
                                  titleText: 'Lote',
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
                    /*Center(
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
                                  titleText: 'Color',
                                  hintText: 'Elija el Color',
                                  value: colorResult,
                                  validator: (value) {
                                    if (value == null) {
                                      return "Por favor seleccione un color";
                                    }
                                    return null;
                                  },
                                  onChanged: (newValue) {
                                    setState(() {
                                      colorResult = newValue;
                                    });
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      colorResult = value;
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
                    ),*/
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Column(children: [
                          Text(
                            "Cantidad:",
                            textAlign: TextAlign.left,
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
                        ])),
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
                                  titleText: 'Motivo',
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
                    /*new ElevatedButton(
                      child: Text("Guardar",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15, color: Colors.white)),
                      onPressed: uploadStatusPerdido,
                    )*/
                    Center(
                        child: ElevatedButton(
                            child: Text('Guardar'), onPressed: _saveForm)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /*void uploadStatusPerdido() async {
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
  }*/

  /*crearDataSourceColor(List<Colour> colores) {
    var lista = [];

    colores.forEach((element) {
      var pedazo = {
        "display": element.nombre.toString(),
        "value": element.nombre.toString()
      };
      lista.add(pedazo);
    });
    return lista;
  }*/

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

  crearDataSourceSemana(List<Semana> semanas) {
    var lista = [];

    semanas.forEach((element) {
      var pedazo = {
        "display": element.numero.toString(),
        "value": element.id.toString()
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
