import 'package:flutter/material.dart';
//
//

import 'package:banavanmov/publicarPerdidoJBodega.dart';
import 'package:banavanmov/providers/perdidoProvider.dart';
import 'package:banavanmov/model/perdido.dart';
import 'package:banavanmov/blocs/perdidoBloc.dart';
import 'package:banavanmov/response.dart';
import 'package:banavanmov/actualizarPerdidoJBodega.dart';

class PerdidosVista extends StatefulWidget {
  @override
  _PerdidosVistaState createState() => _PerdidosVistaState();
}

class _PerdidosVistaState extends State<PerdidosVista> {
  final PerdidoProvider pv = new PerdidoProvider();
  bool isBusqueda = false;
  PerdidoBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = PerdidoBloc();
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
                        "Lote: " + p.lote_id.toString(),
                        style: TextStyle(fontSize: 10),
                      ),
                    ])),
                Padding(
                    padding: const EdgeInsets.only(left: 10, top: 7.0),
                    child: Row(children: <Widget>[
                      Text(
                        "Reportado por: " + p.user_id.toString(),
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
                          p.perdida_motivo_id.toString()),
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
