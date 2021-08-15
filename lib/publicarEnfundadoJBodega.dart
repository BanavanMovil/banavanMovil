//https://flutter-es.io/docs/cookbook/navigation/navigation-basics
import 'package:banavanmov/model/enfundado.dart';
import 'package:banavanmov/model/lote.dart';

import 'package:banavanmov/model/personnel.dart';
import 'package:banavanmov/providers/personnelProvider.dart';

import 'package:banavanmov/providers/semanaProvider.dart';
import 'package:banavanmov/providers/loteProvider.dart';
import 'package:banavanmov/utils/dataSource.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

import 'package:banavanmov/vistaEnfundadoJBodega.dart';
import 'package:banavanmov/providers/enfundadoProvider.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

class PublicarEnfundadoJB extends StatefulWidget {
  @override
  _PublicarEnfundadoJBState createState() => _PublicarEnfundadoJBState();
}

class _PublicarEnfundadoJBState extends State<PublicarEnfundadoJB> {
  final _formKey = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final DateFormat secondFormatter = DateFormat('yyyy-MM-dd');
  // ignore: non_constant_identifier_names
  DateTime fecha_entrega, fecha_entregaResult;
  String usuario, personnelResult;
  String semana, semanaResult;
  String lote, loteResult;
  String lote2;
  // ignore: non_constant_identifier_names
  String fundas_entregadas, fundas_entregadasResult;
  // ignore: non_constant_identifier_names
  String fundas_recibidas, fundas_recibidasResult;
  String color, colorResult;

  EnfundadoProvider ep;
  @override
  void initState() {
    super.initState();
    usuario = '';
    semana = '';
    fundas_entregadas = '';
    fundas_recibidas = '';
    lote = '';
    color = '';
    personnelResult = '';
    semanaResult = '';
    fundas_entregadasResult = '';
    fundas_recibidasResult = '';
    loteResult = '';
    colorResult = '';
    ep = new EnfundadoProvider();
  }

  Future<bool> _saveForm() async {
    var form = _formKey.currentState;
    if (form.validate() && fecha_entrega != null) {
      form.save();
      Enfundado e = new Enfundado(
          id: -1,
          lote_id: int.parse(loteResult),
          user_id: int.parse(personnelResult),
          fundas_entregadas: int.parse(fundas_entregadas),
          fecha: secondFormatter.format(fecha_entrega),
          semana_id: int.parse(semana),
          cantidad: int.parse(fundas_entregadas));
      print("Se va a enviar el enfundado");
      return ep.postEnfundado(e);
    } else {
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

  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text('Registro Enfundador'),
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
                                  titleText: 'Lote',
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
                    new ListTile(
                        //leading: const Icon(Icons.star),
                        title: Row(
                      children: <Widget>[
                        Text(fecha_entrega == null
                            ? "No ha seleccionado fecha"
                            : formatter.format(fecha_entrega)),
                        Spacer(),
                        ElevatedButton(
                            onPressed: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: fecha_entrega == null
                                          ? DateTime.now()
                                          : fecha_entrega,
                                      firstDate: DateTime(2001),
                                      lastDate: DateTime(2222))
                                  .then((date) async {
                                if (date != null) {
                                  print("FECHA: " + date.toString());
                                  setState(() {
                                    fecha_entrega = date;
                                  });
                                  return SemanaProvider()
                                      .getDateData(formatter.format(date));
                                } else {
                                  setState(() {
                                    fecha_entrega = null;
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
                              Text(fecha_entrega != null
                                  ? semana.toString()
                                  : '--')
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "Color: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                              fecha_entrega == null
                                  ? Text("--")
                                  : IconButton(
                                      color: color != null
                                          ? DataSource().getColorFromHex(color)
                                          : Colors.accents,
                                      icon: Icon(Icons.crop_square_outlined),
                                      onPressed: () {},
                                    )
                            ],
                          ),
                        ],
                      ),
                    ),
                    new ListTile(
                      //leading: const Icon(Icons.supervisor_account),

                      title: TextFormField(
                          //controller: _controller,
                          keyboardType: TextInputType.number,
                          onChanged: (newValue) {
                            setState(() {
                              fundas_entregadas = newValue;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              fundas_entregadas = value;
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
                            labelText: "Número de Fundas Entregadas",
                            //hintText: "whatever you want",
                            //icon: Icon(Icons.phone_iphone)
                          )),
                    ),
                    new ElevatedButton(
                      child: Text("Guardar",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15, color: Colors.white)),
                      onPressed: () {
                        _saveForm().then((value) {
                          if (value) {
                            print("Aqui esta el enfundado creado");
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: const Text(
                                    'Enfundado Creado Correctamente'),
                                action: SnackBarAction(
                                  label: 'Cerrar',
                                  onPressed: () {
                                    // Code to execute.
                                  },
                                )));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: const Text(
                                    'Ocurrio un problema al crear el enfundado'),
                                action: SnackBarAction(
                                  label: 'Cerrar',
                                  onPressed: () {
                                    // Code to execute.
                                  },
                                )));
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      //backgroundColor: Colors.green,
    );
  }
}
