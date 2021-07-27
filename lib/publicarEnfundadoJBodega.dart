//https://flutter-es.io/docs/cookbook/navigation/navigation-basics
import 'package:banavanmov/model/color.dart';
import 'package:banavanmov/model/lote.dart';
import 'package:banavanmov/providers/colorProvider.dart';
import 'package:banavanmov/model/personnel.dart';
import 'package:banavanmov/providers/personnelProvider.dart';
import 'package:banavanmov/model/semana.dart';
import 'package:banavanmov/providers/semanaProvider.dart';
import 'package:banavanmov/providers/loteProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:banavanmov/model/enfundado.dart';
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
  DateTime fecha_entrega;
  String usuario, personnelResult;
  String semana, semanaResult;
  String lote, loteResult;
  String lote2;
  String fundas_entregadas, fundas_entregadasResult;
  String fundas_recibidas, fundas_recibidasResult;
  String color, colorResult;

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
                            var personalDS = crearDataSourcePersonnel(personal);
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
                    /*Container(
                        padding: EdgeInsets.all(10),
                        child: DropDownFormField(
                          titleText: 'Trabajador',
                          hintText: 'Elija el Trabajador',
                          value: usuario,
                          validator: (value) {
                            if (value == null) {
                              return "Por favor seleccione un trabajador.";
                            }
                            return null;
                          },
                          onChanged: (newValue) {
                            setState(() {
                              usuario = newValue;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              usuario = value;
                            });
                          },
                          dataSource: [
                            {
                              "display": "Carlos Salazar",
                              "value": "Carlos Salazar"
                            },
                            {
                              "display": "Livingston Perez",
                              "value": "Livingston Perez"
                            }
                          ],
                          textField: 'display',
                          valueField: 'value',
                        )),*/
                    Container(
                        padding: EdgeInsets.all(10),
                        child: DropDownFormField(
                          titleText: 'Lote',
                          hintText: 'Elija el Lote',
                          value: lote,
                          validator: (value) {
                            if (value == null) {
                              return "Por favor seleccione un lote";
                            }
                            return null;
                          },
                          onChanged: (newValue) {
                            setState(() {
                              lote = newValue;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              lote = value;
                            });
                          },
                          dataSource: [
                            {"display": "1", "value": "1"},
                            {"display": "2", "value": "2"},
                            {"display": "3", "value": "3"},
                            {"display": "4", "value": "4"}
                          ],
                          textField: 'display',
                          valueField: 'value',
                        )),
                    /*Center(
                      child: FutureBuilder(
                        future: LoteProvider().todosLosLotes(),
                        builder: (BuildContext context,
                            AsyncSnapshot<Map<String, List<Lote>>> snapshot) {
                          if (snapshot.hasData) {
                            var lote = snapshot.data;
                            var loteDS = crearDataSourceLote(lote);
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
                    ),*/
                    /*Center(
                      child: FutureBuilder(
                        future: ColorProvider().getAll(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Colour>> snapshot) {
                          if (snapshot.hasData) {
                            var colores = snapshot.data;
                            var coloresDS = crearDataSourceLote(colores);
                            return Container(
                                padding: EdgeInsets.all(10),
                                child: DropDownFormField(
                                  titleText: 'Color',
                                  hintText: 'Elija el Color',
                                  value: lote2,
                                  validator: (value) {
                                    if (value == null) {
                                      return "Por favor seleccione un lote";
                                    }
                                    return null;
                                  },
                                  onChanged: (newValue) {
                                    setState(() {
                                      lote2 = newValue;
                                    });
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      lote2 = value;
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
                    new ListTile(
                        //leading: const Icon(Icons.star),
                        title: Row(
                      children: <Widget>[
                        Text(fecha_entrega == null
                            ? "No ha seleccionado fecha"
                            : fecha_entrega.toString()),
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
                                  .then((date) {
                                setState(() {
                                  fecha_entrega = date;
                                });
                              });
                            },
                            child: Icon(Icons.date_range))
                      ],
                    )),
                    /*Container(
                        padding: EdgeInsets.all(10),
                        child: DropDownFormField(
                          titleText: 'Semana',
                          hintText: 'Elija la Semana',
                          value: semana,
                          validator: (value) {
                            if (value == null) {
                              return "Por favor elija una semana.";
                            }
                            return null;
                          },
                          onChanged: (newValue) {
                            setState(() {
                              semana = newValue;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              semana = value;
                            });
                          },
                          dataSource: [
                            {"display": "52", "value": "52"},
                            {"display": "53", "value": "53"},
                            {"display": "54", "value": "54"},
                            {"display": "55", "value": "55"},
                            {"display": "56", "value": "56"},
                            {"display": "57", "value": "57"}
                          ],
                          textField: 'display',
                          valueField: 'value',
                        )),*/
                    Center(
                      child: FutureBuilder(
                        future: SemanaProvider().getAll(),
                        builder: (BuildContext context,
                            //AsyncSnapshot<Map<String, List<Semana>>> snapshot) {
                            AsyncSnapshot<List<Semana>> snapshot) {
                          if (snapshot.hasData) {
                            var semana = snapshot.data;
                            var semanaDS = crearDataSourceSemana(semana);
                            return Container(
                                padding: EdgeInsets.all(10),
                                child: DropDownFormField(
                                  titleText: 'Semana',
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
                    new ListTile(
                      //leading: const Icon(Icons.contact_phone),

                      title: TextFormField(
                          //controller: _controller,
                          keyboardType: TextInputType.number,
                          onChanged: (newValue) {
                            setState(() {
                              fundas_recibidas = newValue;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              fundas_recibidas = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Por favor ingrese un valor.";
                            }
                            return null;
                          },
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            labelText: "Número de Fundas Recibidas",
                            //hintText: "whatever you want",
                            //icon: Icon(Icons.phone_iphone)
                          )),
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
                                  titleText: 'Color',
                                  hintText: 'Elija el Color',
                                  value: colorResult,
                                  validator: (value) {
                                    if (value == null) {
                                      return "Por favor seleccione un lote";
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
                    ),
                    /*Container(
                        padding: EdgeInsets.all(10),
                        child: DropDownFormField(
                          titleText: 'Color de cinta',
                          hintText: 'Elija el Color',
                          value: color,
                          validator: (value) {
                            if (value == null) {
                              return "Por favor elija un color.";
                            }
                            return null;
                          },
                          onChanged: (newValue) {
                            setState(() {
                              color = newValue;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              color = value;
                            });
                          },
                          dataSource: [
                            {"display": "Rojo", "value": "Rojo"},
                            {"display": "Verde", "value": "Verde"},
                            {"display": "Azul", "value": "Azul"},
                            {"display": "Amarillo", "value": "Amarillo"}
                          ],
                          textField: 'display',
                          valueField: 'value',
                        )),*/
                    new ElevatedButton(
                      child: Text("Guardar",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15, color: Colors.white)),
                      onPressed: uploadStatusEnfundado,
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

  void uploadStatusEnfundado() async {
    //print(_formKey.currentState.validate());
    //print(colorResult);
    if (_formKey.currentState.validate()) {
      EnfundadoProvider ep = new EnfundadoProvider();
      //ep.postEnfundado(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Enfundado Creado')));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        //return Footer();
        return EnfundadoVista();
      }));
    }
    /*Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      //return Footer();
      return EnfundadoVista();
    }));*/
    // }
  }

  crearDataSourceColor(List<Colour> colores) {
    var lista = [];
    /*var lista2 = [
      {"display": "Rojo", "value": "Rojo"},
      {"display": "Verde", "value": "Verde"},
      {"display": "Azul", "value": "Azul"},
      {"display": "Amarillo", "value": "Amarillo"}
    ];
    print(lista2);*/
    colores.forEach((element) {
      //print(element.id.toString() + element.nombre.toString());
      var pedazo = {
        "display": element.nombre.toString(),
        "value": element.nombre.toString()
      };
      lista.add(pedazo);
    });
    //print(lista);
    return lista;
  }

  crearDataSourcePersonnel(List<Personnel> personal) {
    var lista = [];
    /*var lista2 = [
      {"display": "Rojo", "value": "Rojo"},
      {"display": "Verde", "value": "Verde"},
      {"display": "Azul", "value": "Azul"},
      {"display": "Amarillo", "value": "Amarillo"}
    ];
    print(lista2);*/
    personal.forEach((element) {
      //print(element.id.toString() + element.nombre.toString());
      var pedazo = {
        "display":
            element.nombres.toString() + ' ' + element.apellidos.toString(),
        "value": element.nombres.toString() + ' ' + element.apellidos.toString()
      };
      if (element.activo.toString() == '1') {
        lista.add(pedazo);
      }
    });
    //print(lista);
    return lista;
  }

  //cargarSemana() {
  //  print(SemanaProvider().getAll());
  //}

  crearDataSourceSemana(List<Semana> semanas) {
    //print(semanas);
    var lista = [];
    /*var lista2 = [
      {"display": "Rojo", "value": "Rojo"},
      {"display": "Verde", "value": "Verde"},
      {"display": "Azul", "value": "Azul"},
      {"display": "Amarillo", "value": "Amarillo"}
    ];
    print(lista2);*/
    //List<Semana> semana = semanas["semanas"];
    //print(semana);
    semanas.forEach((element) {
      //print(element.id.toString() + element.nombre.toString());
      var pedazo = {
        "display": element.numero.toString(),
        "value": element.numero.toString()
      };

      lista.add(pedazo);
    });
    //print(lista);
    return lista;
  }
  /*crearDataSourceLote(Map<String, List<Lote>> lotes) {
    var lista = [];
    /*var lista2 = [
      {"display": "Rojo", "value": "Rojo"},
      {"display": "Verde", "value": "Verde"},
      {"display": "Azul", "value": "Azul"},
      {"display": "Amarillo", "value": "Amarillo"}
    ];
    print(lista2);*/
    //print(lote);
    var lote = lotes["lotes"];
    lote.forEach((element) {
      //print(element.id.toString() + element.nombre.toString());
      var pedazo = {
        "display": element.numero.toString(),
        "value": element.numero.toString()
      };

      lista.add(pedazo);
    });
    //print(lista);
    return lista;
  }*/
}
