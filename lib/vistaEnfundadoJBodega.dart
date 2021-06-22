import 'package:banavanmov/actualizarEnfundadoJBodega.dart';
import 'package:flutter/material.dart';
//
//
import 'package:banavanmov/model/enfundado.dart';
import 'package:banavanmov/providers/enfundadoProvider.dart';
import 'package:banavanmov/response.dart';
import 'package:banavanmov/publicarEnfundadoJBodega.dart';
import 'package:banavanmov/blocs/enfundadoBloc.dart';

class EnfundadoVista extends StatefulWidget {
  @override
  _EnfundadoVistaState createState() => _EnfundadoVistaState();
}

class _EnfundadoVistaState extends State<EnfundadoVista> {
  final EnfundadoProvider ep = new EnfundadoProvider();
  bool isBusqueda = false;
  EnfundadoBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = EnfundadoBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: !isBusqueda
            ? Text('Jefe de Bodega \n    Enfundado')
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
        onRefresh: () => _bloc.fetchAllEnfundados(),
        child: StreamBuilder<Response<List<Enfundado>>>(
          stream: _bloc.movieListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
                  break;
                case Status.COMPLETED:
                  return EnfundadoList(enfundados: snapshot.data.data);
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchAllEnfundados(),
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: botonEnfundado(),
    );
  }

  Widget botonEnfundado() {
    //if (globals.isLoggedIn) {
    return FloatingActionButton(
      backgroundColor: Colors.orange,
      onPressed: () {
        //if (globals.isLoggedIn) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PublicarEnfundadoJB();
        }));
      },
      //},
      child: const Icon(Icons.add),
    );
    //}
    //return Row();
  }
}

class EnfundadoList extends StatelessWidget {
  final List<Enfundado> enfundados;
  const EnfundadoList({Key key, this.enfundados}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: enfundados.length,
      itemBuilder: (context, index) {
        return _crearCartaEnfundado(context, enfundados[index]);
      },
    );
  }
}

Widget _crearCartaEnfundado(BuildContext context, Enfundado e) {
  return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5.0),
                  child: Row(children: <Widget>[
                    Text(
                      "Lote: " + e.lote.toString(),
                      style: TextStyle(fontSize: 10),
                    ),
                  ])),
              Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5.0),
                  child: Row(children: <Widget>[
                    Text(
                      e.trabajador,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ])),
              Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5.0),
                  child: Row(children: <Widget>[
                    Text("Semana: " + e.semana.toString()),
                  ])),
              Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5.0),
                  child: Row(children: <Widget>[
                    Text("Color de Cinta: " + e.colorCinta),
                    Spacer(),
                    Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ActualizarEnfundadoJB(e);
                            }));
                          },
                        ))
                  ])),
              Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5.0),
                  child: Row(children: <Widget>[
                    Text("Hora fin: " + e.fechaEntrega),
                  ])),
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
