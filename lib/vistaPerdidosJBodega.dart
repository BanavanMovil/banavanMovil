import 'package:flutter/material.dart';
//
//

import 'package:banavanmov/publicarPerdidoJBodega.dart';
import 'package:banavanmov/providers/perdidoProvider.dart';
import 'package:banavanmov/model/perdido.dart';
import 'package:banavanmov/blocs/perdidoBloc.dart';
import 'package:banavanmov/response.dart';

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
      /*body: Container(
          //padding: const EdgeInsets.all(5.0),
          //child: filteredEmpleoList.length == 0
          child: 1 == 0
              ? Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("No hay Racimos Perdidos",
                            style: TextStyle(
                              fontFamily: 'Varela',
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(
                          height: 20.0,
                        ),
                        CircularProgressIndicator()
                      ]),
                )
              : Center(
                  child: FutureBuilder(
                      future: pv.getAllPerdido(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Perdido>> snapshot) {
                        if (snapshot.hasData) {
                          final perdidos = snapshot.data;
                          return ListView.builder(
                              itemCount: perdidos.length,
                              itemBuilder: (context, i) =>
                                  _crearItem(perdidos[i]));
                        } else {
                          return CircularProgressIndicator();
                        }
                      }),
                )),*/
      floatingActionButton: botonPerdido(),
    );
  }

  Widget _crearItem(Perdido p) {
    return Card(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Placeholder(
              fallbackHeight: 10,
              fallbackWidth: 100,
              color: Colors.transparent,
            ),
            Text(
              "Lote: " + p.lote.toString(),
              style: TextStyle(fontSize: 10),
            ),
            Placeholder(
              fallbackHeight: 5,
              fallbackWidth: 100,
              color: Colors.transparent,
            ),
            Text(
              "Reportado por: " + p.trabajador.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Placeholder(
              fallbackHeight: 5,
              fallbackWidth: 100,
              color: Colors.transparent,
            ),
            Text("Fecha de Reporte: " + p.fechaRegistro.toString()),
            Placeholder(
              fallbackHeight: 5,
              fallbackWidth: 100,
              color: Colors.transparent,
            ),
            Text("Motivo de pérdida: " + p.motivo.toString()),
            Placeholder(
              fallbackHeight: 5,
              fallbackWidth: 100,
              color: Colors.transparent,
            ),
            Text("Color de cinta: " + p.colorCinta.toString()),
            Placeholder(
              fallbackHeight: 10,
              fallbackWidth: 100,
              color: Colors.transparent,
            ),
          ]),
    );
  }

  Widget botonPerdido() {
    //if (globals.isLoggedIn) {
    return FloatingActionButton(
      backgroundColor: Colors.blue[900],
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
    return ListView.builder(
      itemCount: perdidos.length,
      itemBuilder: (context, index) {
        return _crearCartaPerdido(perdidos[index]);
      },
    );
  }
}

Widget _crearCartaPerdido(Perdido p) {
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
                      "Lote: " + p.lote.toString(),
                      style: TextStyle(fontSize: 10),
                    ),
                  ])),
              Padding(
                  padding: const EdgeInsets.only(left: 10, top: 7.0),
                  child: Row(children: <Widget>[
                    Text(
                      "Reportado por: " + p.trabajador.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ])),
              Padding(
                  padding: const EdgeInsets.only(left: 10, top: 7.0),
                  child: Row(children: <Widget>[
                    Text("Fecha de Reporte: " + p.fechaRegistro.toString()),
                  ])),
              Padding(
                  padding: const EdgeInsets.only(left: 10, top: 7.0),
                  child: Row(children: <Widget>[
                    Text("Motivo de pérdida: " + p.motivo),
                    /*Spacer(),
                    Padding(
                        padding: const EdgeInsets.only(right: 0.0, top: 0.0),
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            print("TO DO");
                          },
                        ))*/
                  ])),
              Padding(
                  padding: const EdgeInsets.only(left: 10, top: 7.0),
                  child: Row(children: <Widget>[
                    Text("Color de cinta: " + p.colorCinta),
                  ])),
              /*Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(left: 280.0, top: 0.0),
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            print("TO DO");
                          },
                        ))
                  ]),*/
              Padding(
                  padding: const EdgeInsets.only(left: 280.0, top: 0.0),
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      print("TO DO");
                    },
                  )),

              /*Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5.0),
                  child: Row(children: <Widget>[
                    Text("Hora fin: " + e.fechaEntrega),
                  ])),*/
              Placeholder(
                fallbackHeight: 10,
                fallbackWidth: 100,
                color: Colors.transparent,
              ),
            ]),
      ));
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
