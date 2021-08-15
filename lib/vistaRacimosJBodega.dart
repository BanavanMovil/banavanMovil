import 'package:banavanmov/model/cosechado.dart';
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:banavanmov/publicarRacimoJBodega.dart';
import 'package:banavanmov/response.dart';
import 'package:banavanmov/blocs/cosechadoBloc.dart';
import 'package:banavanmov/providers/cosechadoProvider.dart';
import 'package:banavanmov/actualizarRacimoJBodega.dart';

import 'package:banavanmov/model/lote.dart';
import 'package:banavanmov/providers/loteProvider.dart';

import 'package:banavanmov/model/color.dart';
import 'package:banavanmov/providers/colorProvider.dart';

import 'package:banavanmov/model/personnel.dart';
import 'package:banavanmov/providers/personnelProvider.dart';

import 'package:banavanmov/model/semana.dart';
import 'package:banavanmov/providers/semanaProvider.dart';

class RacimosVista extends StatefulWidget {
  @override
  _RacimosVistaState createState() => _RacimosVistaState();
}

Map<String, String> todosLotes = {};
Map<String, String> todosColores = {};
Map<String, String> todosUsers = {};
Map<String, String> todosSemanas = {};
Map<String, String> todosSemanasColores = {};

class _RacimosVistaState extends State<RacimosVista> {
  final CosechadoProvider cv = new CosechadoProvider();
  bool isBusqueda = false;
  CosechadoBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = CosechadoBloc();
    cargarDatosLotes();
    cargarDatosColores();
    cargarDatosUsers();
    cargarDatosSemanas();
    cargarDatosSemanasColores();
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
                  text: "Racimos Cosechados", style: TextStyle(fontSize: 18.0)),
            ],
          ),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0, fontFamily: 'Karla'),
        ),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchAllCosechados(),
        child: StreamBuilder<Response<List<Cosechado>>>(
          stream: _bloc.movieListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
                  break;
                case Status.COMPLETED:
                  return CosechadoList(cosechados: snapshot.data.data);

                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchAllCosechados(),
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: botonCosechado(),
    );
  }

  Widget botonCosechado() {
    return FloatingActionButton(
      backgroundColor: Colors.orange,
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PublicarRacimoJB();
        }));
      },
      child: const Icon(Icons.add),
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
      if (element.rol.toString() == 'Trabajador' &&
          element.activo.toString() == '1') {
        var newPersonnel = Map<String, String>();
        newPersonnel[element.id.toString()] =
            element.nombres.toString() + " " + element.apellidos.toString();
        todosUsers.addAll(newPersonnel);
      }
    });
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

  void cargarDatosSemanasColores() async {
    SemanaProvider _provider = SemanaProvider();
    Future<List<Semana>> _futureOfList = _provider.getAll();
    List<Semana> list = await _futureOfList;
    list.forEach((element) {
      var newSemana = Map<String, String>();
      newSemana[element.id.toString()] = element.color_id.toString();
      todosSemanasColores.addAll(newSemana);
    });
  }
}

class CosechadoList extends StatelessWidget {
  final List<Cosechado> cosechados;
  const CosechadoList({Key key, this.cosechados}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return cosechados == null
        ? Text("No se encontraron Racimos Cosechados")
        : ListView.builder(
            itemCount: cosechados.length,
            itemBuilder: (context, index) {
              return _crearCartaCosechado(context, cosechados[index]);
            },
          );
  }

  Widget _crearCartaCosechado(BuildContext context, Cosechado c) {
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
                            TextSpan(
                              text: todosLotes[c.lote_id.toString()].toString(),
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
                                text: "Trabajador: ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: todosUsers[c.user_id.toString()].toString(),
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
                              text: c.cantidad.toString(),
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
                                text: "Semana de Cosecha: ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: c.semana_cosecha.toString(),
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
                                text: "Fecha: ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: c.fecha.toString(),
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
                              text: todosColores[
                                  todosSemanasColores[c.semana_id.toString()]],
                            ),
                          ],
                        ),
                      )
                    ])),
                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: const Text('EDITAR'),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ActualizarCosechadoJB(c);
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
