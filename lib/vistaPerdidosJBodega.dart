import 'package:flutter/material.dart';
//
//

import 'package:banavanmov/publicarPerdidoJBodega.dart';
import 'package:banavanmov/providers/perdidoProvider.dart';
import 'package:banavanmov/model/perdido.dart';
import 'package:banavanmov/blocs/perdidoBloc.dart';
import 'package:banavanmov/response.dart';
import 'package:banavanmov/actualizarPerdidoJBodega.dart';

import 'package:banavanmov/model/lote.dart';
import 'package:banavanmov/providers/loteProvider.dart';

import 'package:banavanmov/model/color.dart';
import 'package:banavanmov/providers/colorProvider.dart';

import 'package:banavanmov/model/personnel.dart';
import 'package:banavanmov/providers/personnelProvider.dart';

import 'package:banavanmov/model/semana.dart';
import 'package:banavanmov/providers/semanaProvider.dart';

import 'package:banavanmov/model/motivo.dart';
import 'package:banavanmov/providers/motivoProvider.dart';

import 'package:banavanmov/utils/util.dart';

class PerdidosVista extends StatefulWidget {
  @override
  _PerdidosVistaState createState() => _PerdidosVistaState();
}

/*Map<String, String> todosLotes = {};
Map<String, String> todosColores = {};
Map<String, String> todosUsers = {};
Map<String, String> todosSemanas = {};
Map<String, String> todosMotivos = {};
Map<String, String> todosSemanasColores = {};*/

class _PerdidosVistaState extends State<PerdidosVista> {
  final PerdidoProvider pv = new PerdidoProvider();
  bool isBusqueda = false;
  PerdidoBloc _bloc;
  List<Lote> lotes;
  List<Personnel> personal;
  List<Semana> semanas;
  List<Colour> colores;
  List<Motivo> motivos;

  @override
  void initState() {
    super.initState();
    _bloc = PerdidoBloc();

    LoteProvider().todosLosLotes().then((value) {
      setState(() {
        lotes = value;
      });
    });
    PersonnelProvider().getAll().then((value) {
      setState(() {
        personal = value;
      });
    });
    SemanaProvider().getAll().then((value) {
      setState(() {
        semanas = value;
      });
    });
    ColorProvider().getAll().then((value) {
      setState(() {
        colores = value;
      });
    });
    MotivoProvider().getAll().then((value) {
      setState(() {
        motivos = value;
      });
    });

    /*cargarDatosLotes();
    cargarDatosColores();
    cargarDatosUsers();
    cargarDatosSemanas();
    cargarDatosMotivos();
    cargarDatosSemanasColores();*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(
          TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: "Jefe de Bodega\n",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                  text: "Racimos Perdidos", style: TextStyle(fontSize: 18.0)),
            ],
          ),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0, fontFamily: 'Karla'),
        ),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchAllPerdidos(),
        child: StreamBuilder<Response<List<Perdido>>>(
          stream: _bloc.movieListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
                  break;
                case Status.COMPLETED:
                  return PerdidoList(perdidos: snapshot.data.data, datos: {
                    "lotes": lotes,
                    "personal": personal,
                    "semana": semanas,
                    "colores": colores,
                    "motivos": motivos,
                  });
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchAllPerdidos(),
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: botonPerdido(),
    );
  }

  Widget botonPerdido() {
    return FloatingActionButton(
      backgroundColor: Colors.orange,
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PublicarPerdidoJB();
        }));
      },
      child: const Icon(Icons.add),
    );
  }

  /*void cargarDatosLotes() async {
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
  }*/
}

class PerdidoList extends StatelessWidget {
  final List<Perdido> perdidos;
  final Map<String, dynamic> datos;
  const PerdidoList({Key key, this.perdidos, this.datos}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return (perdidos == null || perdidos.length == 0)
        ? Center(
            child: Text(
              "No se encontraron Racimos Perdidos",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        : ListView.builder(
            itemCount: perdidos.length,
            itemBuilder: (context, index) {
              return _crearCartaPerdido(context, perdidos[index]);
            },
          );
    /*return perdidos == null
        ? Text("No se encontraron Racimos Perdidos")
        : ListView.builder(
            itemCount: perdidos.length,
            itemBuilder: (context, index) {
              return _crearCartaPerdido(context, perdidos[index]);
            },
          );*/
  }

  Widget _crearCartaPerdido(BuildContext context, Perdido p) {
    var semana =
        Util().obtenerSemanaDeId(int.parse(p.semana_id), datos['semana']);
    var color;
    if (semana != null) {
      color = Util()
          .obtenerColorNDeId(int.parse(semana.color_id), datos['colores']);
    }
    var motivo = Util()
        .obtenerMotivoDeId(int.parse(p.perdida_motivo_id), datos['motivos']);
    var lote = Util().obtenerLoteDeId(int.parse(p.lote_id), datos['lotes']);
    var trabajador = Util().obtenerTrabajadorDeId(
        int.parse(p.user_id.toString()), datos['personal']);
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10.0),
                    child: Row(children: <Widget>[
                      Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: "Lote: ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: lote.toString()
                                //todosLotes[p.lote_id.toString()].toString(),
                                ),
                          ],
                        ),
                      )
                    ])),
                Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10.0),
                    child: Row(children: <Widget>[
                      Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: "Reportado por: ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: trabajador != null ? trabajador : "--",
                              //todosUsers[p.user_id.toString()].toString(),
                            ),
                          ],
                        ),
                      )
                    ])),
                Padding(
                    padding: const EdgeInsets.only(left: 10, top: 7.0),
                    child: Row(children: <Widget>[
                      Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: "Cantidad: ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: p.cantidad.toString(),
                            ),
                          ],
                        ),
                      )
                    ])),
                Padding(
                    padding: const EdgeInsets.only(left: 10, top: 7.0),
                    child: Row(children: <Widget>[
                      Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: "Semana de Pérdida: ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: p.semana_perdida.toString(),
                            ),
                          ],
                        ),
                      )
                    ])),
                Padding(
                    padding: const EdgeInsets.only(left: 10, top: 7.0),
                    child: Row(children: <Widget>[
                      Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: "Fecha de Reporte: ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: p.fecha.toString(),
                            ),
                          ],
                        ),
                      )
                    ])),
                Padding(
                    padding: const EdgeInsets.only(left: 10, top: 7.0),
                    child: Row(children: <Widget>[
                      Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: "Motivo de pérdida: ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: motivo.toString(),
                              //todosMotivos[
                              //  p.perdida_motivo_id.toString()]
                            ),
                          ],
                        ),
                      )
                    ])),
                Padding(
                    padding: const EdgeInsets.only(left: 10, top: 7.0),
                    child: Row(children: <Widget>[
                      Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: "Color: ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: color.toString(),
                              //todosColores[
                              //  todosSemanasColores[p.semana_id.toString()]],
                            ),
                          ],
                        ),
                      )
                    ])),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      child: const Text('EDITAR'),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ActualizarPerdidoJB(p);
                        }));
                      },
                    ),
                  ],
                ),
              ]),
        ));
  }
}

class Error extends StatelessWidget {
  final String errorMessage;
  final Function onRetryPressed;
  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            child: Text(
              'Retry',
            ),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;
  const Loading({Key key, this.loadingMessage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
          ),
        ],
      ),
    );
  }
}
