import 'package:banavanmov/model/cosechado.dart';
import 'dart:async';

import 'package:flutter/material.dart';

//
//
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

class _RacimosVistaState extends State<RacimosVista> {
  final CosechadoProvider cv = new CosechadoProvider();
  bool isBusqueda = false;
  CosechadoBloc _bloc;

  //List<String> lista = [];

  //var newRanger = Map<String, String>();

  @override
  void initState() {
    super.initState();
    _bloc = CosechadoBloc();
    cargarDatosLotes();
    cargarDatosColores();
    cargarDatosUsers();
    cargarDatosSemanas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(
          TextSpan(
            //text: 'Lote: ', // default text style
            children: <TextSpan>[
              /*TextSpan(
                                text: ' beautiful ',
                                style: TextStyle(fontStyle: FontStyle.italic)),*/
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
        //automaticallyImplyLeading: false,
        /*actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            tooltip: 'Show Snackbar',
            onPressed: () {
              /*Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Login();
              }));*/
            },
          ),
        ],*/
      ),
      /*appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: !isBusqueda
            ? Text('     Jefe de Bodega\nRacimos Cosechados')
            : TextField(
                onChanged: (value) {
                  //_filterEmpleos(value);
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                    hintText: "Filtra por Semana",
                    hintStyle: TextStyle(color: Colors.white)),
              ),
        actions: <Widget>[
          isBusqueda
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      this.isBusqueda = false;
                      //filteredEmpleoList = empleoList;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      this.isBusqueda = true;
                    });
                  },
                )
        ],
      ),*/
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
    //if (globals.isLoggedIn) {
    return FloatingActionButton(
      backgroundColor: Colors.orange,
      onPressed: () {
        //if (globals.isLoggedIn) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PublicarRacimoJB();
        }));
      },
      //},
      child: const Icon(Icons.add),
    );
    //}
    //return Row();
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
                      /*Text(
                        "Lote: " + todosLotes[c.lote_id.toString()],
                        style: TextStyle(fontSize: 10),
                      ),*/
                      Text.rich(
                        TextSpan(
                          //text: 'Lote: ', // default text style
                          children: <TextSpan>[
                            /*TextSpan(
                                text: ' beautiful ',
                                style: TextStyle(fontStyle: FontStyle.italic)),*/
                            TextSpan(
                                text: "Lote: ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: todosLotes[c.lote_id.toString()].toString(),
                              //style: TextStyle(fontWeight: FontWeight.bold)
                            ),
                          ],
                        ),
                      )
                    ])),
                Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10.0),
                    child: Row(children: <Widget>[
                      /*Text(
                        "Trabajador: " + todosUsers[c.user_id.toString()],
                        style: TextStyle(),
                      ),*/
                      Text.rich(
                        TextSpan(
                          //text: 'Lote: ', // default text style
                          children: <TextSpan>[
                            /*TextSpan(
                                text: ' beautiful ',
                                style: TextStyle(fontStyle: FontStyle.italic)),*/
                            TextSpan(
                                text: "Trabajador: ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: todosUsers[c.user_id.toString()].toString(),
                              //style: TextStyle(fontWeight: FontWeight.bold)
                            ),
                          ],
                        ),
                      )
                    ])),
                Padding(
                    padding: const EdgeInsets.only(left: 10, top: 7.0),
                    child: Row(children: <Widget>[
                      /*Text(
                        "Número de racimos cosechados: " +
                            c.cantidad.toString(),
                        style: TextStyle(),
                      ),*/
                      Text.rich(
                        TextSpan(
                          //text: 'Lote: ', // default text style
                          children: <TextSpan>[
                            /*TextSpan(
                                text: ' beautiful ',
                                style: TextStyle(fontStyle: FontStyle.italic)),*/
                            TextSpan(
                                text: "Cantidad: ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: c.cantidad.toString(),
                              //style: TextStyle(fontWeight: FontWeight.bold)
                            ),
                          ],
                        ),
                      )
                    ])),
                Padding(
                    padding: const EdgeInsets.only(left: 10, top: 7.0),
                    child: Row(children: <Widget>[
                      /*Text("Semana: " +
                          todosSemanas[c.semana_id.toString()].toString()),*/
                      Text.rich(
                        TextSpan(
                          //text: 'Lote: ', // default text style
                          children: <TextSpan>[
                            /*TextSpan(
                                text: ' beautiful ',
                                style: TextStyle(fontStyle: FontStyle.italic)),*/
                            TextSpan(
                                text: "Semana: ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: todosSemanas[c.semana_id.toString()]
                                  .toString(),
                              //style: TextStyle(fontWeight: FontWeight.bold)
                            ),
                          ],
                        ),
                      )
                    ])),
                Padding(
                    padding: const EdgeInsets.only(left: 10, top: 7.0),
                    child: Row(children: <Widget>[
                      /*Text("Fecha: " + c.fecha.toString()),*/
                      Text.rich(
                        TextSpan(
                          //text: 'Lote: ', // default text style
                          children: <TextSpan>[
                            /*TextSpan(
                                text: ' beautiful ',
                                style: TextStyle(fontStyle: FontStyle.italic)),*/
                            TextSpan(
                                text: "Fecha: ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: c.fecha.toString(),
                              //style: TextStyle(fontWeight: FontWeight.bold)
                            ),
                          ],
                        ),
                      )
                    ])),
                /*Padding(
                    padding: const EdgeInsets.only(left: 280.0, top: 0.0),
                    child: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ActualizarCosechadoJB(c);
                        }));
                      },
                    )),*/
                /*Placeholder(
                  fallbackHeight: 10,
                  fallbackWidth: 100,
                  color: Colors.transparent,
                ),*/
                ButtonBar(
                  children: <Widget>[
                    /*FlatButton(
                      child: const Text('BTN1'),
                      onPressed: () {/* ... */},
                    ),*/
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
