//https://flutter-es.io/docs/cookbook/navigation/navigation-basics
import 'package:flutter/material.dart';
import 'package:banavanmov/vistaPerdidosJBodega.dart';
import 'package:banavanmov/providers/perdidoProvider.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:banavanmov/model/perdido.dart';

import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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
import 'package:banavanmov/utils/dataSource.dart';
import 'package:banavanmov/model/newObjectP.dart';

class PublicarPerdidoJB extends StatefulWidget {
  @override
  _PublicarPerdidoJBState createState() => _PublicarPerdidoJBState();
}

class _PublicarPerdidoJBState extends State<PublicarPerdidoJB> {
  final globalKey = GlobalKey<ScaffoldState>();

  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final DateFormat secondFormatter = DateFormat('yyyy-MM-dd');

  String _selectedLote, _selectedLoteResult;
  String _selectedCantidad, _selectedCantidadResult;
  String _selectedUser, _selectedUserResult;
  String _selectedPerdidaMotivo, _selectedPerdidaMotivoResult;
  DateTime _selectedFecha, _selectedFechaResult;
  String _selectedSemana, _selectedSemanaResult;

  String _selectedColor, _selectedColorResult;

  bool key = false;

  PerdidoProvider pp;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

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
  }

  Future<bool> _saveForm() async {
    var form = formKey.currentState;
    if (form.validate() && _selectedFecha != null) {
      form.save();
      NewObject no = new NewObject(
          lote_id: int.parse(_selectedLote),
          cantidad: int.parse(_selectedCantidad),
          user_id: int.parse(_selectedUser),
          perdida_motivo_id: int.parse(_selectedPerdidaMotivo),
          fecha: secondFormatter.format(_selectedFecha),
          color_id: int.parse(_selectedColor));
      print("Se va a enviar el perdido");
      return pp.sendPerdido(no);
    } else {
      key = true;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Datos Erroneos o incompletos'),
          action: SnackBarAction(
            label: 'Cerrar',
            onPressed: () {
              // Code to execute.
            },
          )));
      return true;
    }
  }

  /*_saveForm(/*BuildContext context*/) async {
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

      NewObject no = new NewObject(
          //id: -1,
          lote_id: int.parse(_selectedLoteResult),
          cantidad: int.parse(_selectedCantidadResult),
          user_id: int.parse(_selectedUserResult),
          perdida_motivo_id: int.parse(_selectedPerdidaMotivoResult),
          fecha: secondFormatter.format(_selectedFecha),
          color_id: int.parse(_selectedColorResult));

      if (await pp.sendPerdido(no)) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Racimo Perdido Creado'),
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
  }*/

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
              //Center(child: Text("Reg??strese. Gracias!")),
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
                            var personalDS =
                                DataSource().crearDataSourcePersonnel(personal);
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
                                  _selectedSemana = value['numero'].toString();

                                  _selectedSemanaResult =
                                      value['id'].toString();
                                });
                              });
                            },
                            child: Icon(Icons.date_range))
                      ],
                    )),
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
                        future: LoteProvider().todosLosLotes(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Lote>> snapshot) {
                          if (snapshot.hasData) {
                            var lote = snapshot.data;
                            var loteDS = DataSource().crearDataSourceLote(lote);
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
                            labelText: "N??mero de Racimos Perdidos",
                            //hintText: "whatever you want",
                            //icon: Icon(Icons.phone_iphone)
                          )),
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
                    Center(
                      child: FutureBuilder(
                        future: ColorProvider().getAll(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Colour>> snapshot) {
                          if (snapshot.hasData) {
                            var colores = snapshot.data;
                            var coloresDS =
                                DataSource().crearDataSourceColor(colores);
                            return Container(
                                padding: EdgeInsets.all(10),
                                child: DropDownFormField(
                                  titleText: 'Color',
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
                      child: Text('Guardar'),
                      onPressed: () {
                        _saveForm().then((value) {
                          if (value && key) {
                            print("Complete los datos");
                            key = false;
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: const Text('Complete los datos'),
                                action: SnackBarAction(
                                  label: 'Cerrar',
                                  onPressed: () {
                                    // Code to execute.
                                  },
                                )));
                          } else if (value && !key) {
                            print("Aqui esta el Perdido creado");
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    const Text('Perdido Creado Correctamente'),
                                action: SnackBarAction(
                                  label: 'Cerrar',
                                  onPressed: () {
                                    // Code to execute.
                                  },
                                )));
                          } else {
                            _showDialogConfirm(context);
                            /*ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: const Text(
                                    'Ocurrio un problema al crear el enfundado'),
                                action: SnackBarAction(
                                  label: 'Cerrar',
                                  onPressed: () {
                                    // Code to execute.
                                  },
                                )));*/
                          }
                        });
                      }, // _saveForm
                    )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
