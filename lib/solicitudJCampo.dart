import 'package:banavanmov/mainJCampo.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

class SolicitudJC extends StatefulWidget {
  @override
  SolicitudJCState createState() => SolicitudJCState();
}

class SolicitudJCState extends State<SolicitudJC> {
  List<dynamic> tipoSolicitud = [
    {"display": "Cosecha", "value": "Cosecha"},
    {"display": "Cosecha", "value": "Cosecha"}
  ];
  String _selectedTipo, _selectedTipoResult;
  String _selectedLote, _selectedLoteResult;
  int _selectedTrabajadores, _selectedTrabajadoresResult;
  String _selectedMensaje, _selectedMensajeResult;

  final formKey = new GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _selectedTipo = '';
    _selectedTipoResult = '';
  }

  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _selectedTipoResult = _selectedTipo;
        _selectedLoteResult = _selectedLote;
        _selectedTrabajadoresResult = _selectedTrabajadores;
        _selectedMensajeResult = _selectedMensaje;
      });
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
                    child: DropDownFormField(
                      titleText: 'Tipo de Solicitud',
                      hintText: 'Elija un tipo',
                      value: _selectedTipo,
                      validator: (value) {
                        if (value == null) {
                          return "Por favor seleccione un valor";
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
                      dataSource: [
                        {"display": "Cosecha", "value": "Cosecha"},
                        {"display": "Personal", "value": "Personal"}
                      ],
                      textField: 'display',
                      valueField: 'value',
                    )),
                Container(
                    padding: EdgeInsets.all(10),
                    child: DropDownFormField(
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
                      dataSource: [
                        {"display": "1", "value": "1"},
                        {"display": "2", "value": "2"}
                      ],
                      textField: 'display',
                      valueField: 'value',
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Trabajadores',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(top: 10, bottom: 10)),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Por favor seleccion un valor";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _selectedTrabajadores = int.parse(value);
                      });
                    },
                  ),
                ),
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
                      child: Text('Guardar'), onPressed: _saveForm),
                )
              ]),
            ),
          ),
        ));
  }
}
