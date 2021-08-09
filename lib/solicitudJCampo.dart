import 'package:banavanmov/model/solicitud.dart';
import 'package:banavanmov/providers/solicitudProvider.dart';

import 'package:banavanmov/model/actividad.dart';
import 'package:banavanmov/model/lote.dart';
import 'package:banavanmov/model/solicitudTipo.dart';
import 'package:banavanmov/providers/actividadProvider.dart';
import 'package:banavanmov/providers/loteProvider.dart';
import 'package:banavanmov/providers/solicitudTipoProvider.dart';

import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';

class SolicitudJC extends StatefulWidget {
  @override
  SolicitudJCState createState() => SolicitudJCState();
}

class SolicitudJCState extends State<SolicitudJC> {
  List<Lote> lotes;
  String prueba;
  String _selectedTipo, _selectedTipoResult;
  String _selectedLote, _selectedLoteResult;
  int _selectedTrabajadores, _selectedTrabajadoresResult;
  String _selectedMensaje, _selectedMensajeResult;
  String _selectedActividad, _selectedActividadResult;
  DateTime _selectedFecha, _selectedFechaResult;
  SolicitudProvider sp;
  final formKey = new GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _selectedTipo = '';
    _selectedTipoResult = '';
    _selectedLote = '';
    _selectedLoteResult = '';
    _selectedTrabajadores = 0;
    _selectedTrabajadoresResult = 0;
    _selectedMensaje = '';
    _selectedMensajeResult = '';
    _selectedActividad = '';
    _selectedActividadResult = '';

    sp = new SolicitudProvider();
  }

  _saveForm(/*BuildContext context*/) {
    print("Entra al boton guardar");
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _selectedTipoResult = _selectedTipo;
        _selectedLoteResult = _selectedLote;
        _selectedTrabajadoresResult = _selectedTrabajadores;
        _selectedMensajeResult = _selectedMensaje;
        _selectedActividadResult = _selectedActividad;
        _selectedFechaResult = _selectedFecha;
      });

      Solicitud s = new Solicitud(
          id: -1,
          lote_id: int.parse(_selectedLoteResult),
          solicitud_tipo_id: int.parse(_selectedTipoResult),
          user_id: 1,
          mensaje: _selectedMensajeResult,
          personal_requerido: _selectedTrabajadoresResult,
          fecha_actividad: _selectedFecha.toString(),
          is_accepted: false,
          is_answered: false,
          is_used: false,
          actividad_id: int.parse(_selectedActividadResult));

      sp.sendSolicitud(s);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Solicitud Creada'),
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
        appBar: AppBar(
          title: Text(
            'Solicitud',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),
          ),
          backgroundColor: Colors.orange,
          centerTitle: true,
        ),
        body: Center(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
                Container(
                    padding: EdgeInsets.all(10),
                    child: FutureBuilder(
                      future: SolicitudTipoProvider().getAll(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<SolicitudTipo>> snapshot) {
                        if (snapshot.hasData) {
                          var tipos = snapshot.data;
                          var tiposDS = crearDataSourceSolicitudTipo(tipos);
                          return DropDownFormField(
                            titleText: 'Solicitud',
                            hintText: 'Elija el tipo de Solicitud',
                            value: _selectedTipo,
                            validator: (value) {
                              if (value == null) {
                                return "Por favor seleccion un valor";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (newValue) {
                              setState(() {
                                _selectedTipo = newValue;
                              });
                            },
                            onSaved: (value) {
                              setState(() {
                                _selectedTipo = value;
                              });
                            },
                            dataSource: tiposDS,
                            textField: 'display',
                            valueField: 'value',
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    )),
                Container(
                    padding: EdgeInsets.all(10),
                    child: FutureBuilder(
                      future: LoteProvider().todosLosLotes(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Lote>> snapshot) {
                        if (snapshot.hasData) {
                          var lotes = snapshot.data;
                          var loteDS = crearDataSourceLote(lotes);
                          return DropDownFormField(
                            titleText: 'Lote',
                            hintText: 'Elija un lote',
                            value: _selectedLote,
                            validator: (value) {
                              if (value == null) {
                                return "Por favor seleccion un valor";
                              } else {
                                return null;
                              }
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
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    )),
                Container(
                    padding: EdgeInsets.all(10),
                    child: FutureBuilder(
                      future: ActividadProvider().getAll(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Actividad>> snapshot) {
                        if (snapshot.hasData) {
                          var actividades = snapshot.data;
                          var actividadesDS =
                              crearDataSourceActividad(actividades);
                          return DropDownFormField(
                            titleText: 'Actividad',
                            hintText: 'Elija la Actividad',
                            value: _selectedActividad,
                            validator: (value) {
                              if (value == null) {
                                return "Por favor seleccion un valor";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (newValue) {
                              setState(() {
                                _selectedActividad = newValue;
                              });
                            },
                            onSaved: (value) {
                              setState(() {
                                _selectedActividad = value;
                              });
                            },
                            dataSource: actividadesDS,
                            textField: 'display',
                            valueField: 'value',
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    )),
                Container(
                    padding: EdgeInsets.all(10),
                    child: Column(children: [
                      Text(
                        "Numero de Trabajadores:",
                        textAlign: TextAlign.left,
                      ),
                      CustomNumberPicker(
                        initialValue: 0,
                        maxValue: 10000,
                        minValue: 0,
                        onValue: (value) {
                          this._selectedTrabajadores = value;
                          print(this._selectedTrabajadores);
                        },
                      )
                    ])),
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
                              print(_selectedFecha);
                              //_selectedFechaResult = _selectedFecha;
                            });
                          });
                        },
                        child: Icon(Icons.date_range))
                  ],
                )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    minLines: 7,
                    maxLines: null,
                    decoration: InputDecoration(
                        labelText: 'Mensaje',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(top: 10, bottom: 10)),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Por favor de una descripcion para la solicitud";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _selectedMensaje = value;
                      });
                    },
                  ),
                ),
                Center(
                    child: ElevatedButton(
                        child: Text('Guardar'), onPressed: _saveForm)),
              ]),
            ),
          ),
        ));
  }

  crearDataSourceLote(List<Lote> lotes) {
    var lista = [];

    //print(lista2);
    lotes.forEach((element) {
      //print(element.id.toString() + element.numero.toString());
      var pedazo = {
        "display": element.numero.toString(),
        "value": element.id.toString()
      };
      lista.add(pedazo);
    });
    //print(lista);
    return lista;
  }

  crearDataSourceSolicitudTipo(List<SolicitudTipo> tipos) {
    var lista = [];

    //print(lista2);
    tipos.forEach((element) {
      //print(element.id.toString() + element.titulo.toString());
      var pedazo = {
        "display": element.titulo.toString(),
        "value": element.id.toString()
      };
      lista.add(pedazo);
    });
    //print(lista);
    return lista;
  }

  crearDataSourceActividad(List<Actividad> actividades) {
    var lista = [];

    //print(lista2);
    actividades.forEach((element) {
      //print(element.id.toString() + element.nombre.toString());
      var pedazo = {
        "display": element.nombre.toString(),
        "value": element.id.toString()
      };
      lista.add(pedazo);
    });
    //print(lista);
    return lista;
  }
}
