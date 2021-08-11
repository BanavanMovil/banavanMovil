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

class PerdidosVista extends StatefulWidget {
  @override
  _PerdidosVistaState createState() => _PerdidosVistaState();
}

Map<String, String> todosLotes = {};
Map<String, String> todosColores = {};
Map<String, String> todosUsers = {};
Map<String, String> todosSemanas = {};
Map<String, String> todosMotivos = {};

class _PerdidosVistaState extends State<PerdidosVista> {
  final PerdidoProvider pv = new PerdidoProvider();
  bool isBusqueda = false;
  PerdidoBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = PerdidoBloc();

    cargarDatosLotes();
    cargarDatosColores();
    cargarDatosUsers();
    cargarDatosSemanas();
    cargarDatosMotivos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: !isBusqueda
            ? Text('   Jefe de Bodega\nRacimos Perdidos')
            : TextField(
                onChanged: (value) {
                  //_filterEmpleos(value);
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
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
                  return PerdidoList(perdidos: snapshot.data.data);
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
    //if (globals.isLoggedIn) {
    return FloatingActionButton(
      backgroundColor: Colors.orange,
      onPressed: () {
        //if (globals.isLoggedIn) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PublicarPerdidoJB();
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
}

class PerdidoList extends StatelessWidget {
  final List<Perdido> perdidos;
  const PerdidoList({Key key, this.perdidos}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return perdidos == null
        ? Text("No se encontraron Racimos Perdidos")
        : ListView.builder(
            itemCount: perdidos.length,
            itemBuilder: (context, index) {
              return _crearCartaPerdido(context, perdidos[index]);
            },
          );

    /*? ListView.builder(
            itemCount: perdidos.length,
            itemBuilder: (context, index) {
              return _crearCartaPerdido(context, perdidos[index]);
            },
          )
        : Text("No se encontraron Racimos Perdidos");*/
  }

  Widget _crearCartaPerdido(BuildContext context, Perdido p) {
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
                      Text(
                        "Lote: " + todosLotes[p.lote_id.toString()],
                        style: TextStyle(fontSize: 10),
                      ),
                    ])),
                Padding(
                    padding: const EdgeInsets.only(left: 10, top: 7.0),
                    child: Row(children: <Widget>[
                      Text(
                        "Reportado por: " + todosUsers[p.user_id.toString()],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ])),
                Padding(
                    padding: const EdgeInsets.only(left: 10, top: 7.0),
                    child: Row(children: <Widget>[
                      Text("Fecha de Reporte: " + p.fecha.toString()),
                    ])),
                Padding(
                    padding: const EdgeInsets.only(left: 10, top: 7.0),
                    child: Row(children: <Widget>[
                      Text("Motivo de pérdida: " +
                          todosMotivos[p.perdida_motivo_id.toString()]),
                    ])),
                /*Padding(
                    padding: const EdgeInsets.only(left: 10, top: 7.0),
                    child: Row(children: <Widget>[
                      Text("Color de cinta: " + p.colorCinta),
                    ])),*/
                Padding(
                    padding: const EdgeInsets.only(left: 280.0, top: 0.0),
                    child: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ActualizarPerdidoJB(p);
                        }));
                      },
                    )),
                Placeholder(
                  fallbackHeight: 10,
                  fallbackWidth: 100,
                  color: Colors.transparent,
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
