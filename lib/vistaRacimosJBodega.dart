import 'package:banavanmov/model/cosechado.dart';
import 'package:flutter/material.dart';
import 'package:banavanmov/providers/cosechadoProvider.dart';

//
//
import 'package:banavanmov/publicarRacimoJBodega.dart';
import 'package:banavanmov/response.dart';
import 'package:banavanmov/blocs/cosechadoBloc.dart';

class RacimosVista extends StatefulWidget {
  @override
  _RacimosVistaState createState() => _RacimosVistaState();
}

class _RacimosVistaState extends State<RacimosVista> {
  final CosechadoProvider cv = new CosechadoProvider();
  bool isBusqueda = false;
  CosechadoBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = CosechadoBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      /*body: Container(
          //padding: const EdgeInsets.all(5.0),
          //child: filteredEmpleoList.length == 0
          child: 1 == 0
              ? Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("No hay Racimos Cosechados",
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
                      future: cv.getAllCosechado(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Cosechado>> snapshot) {
                        if (snapshot.hasData) {
                          final cosechados = snapshot.data;
                          return ListView.builder(
                              itemCount: cosechados.length,
                              itemBuilder: (context, i) =>
                                  _crearItem(cosechados[i]));
                        } else {
                          return CircularProgressIndicator();
                        }
                      }),
                )),*/

      floatingActionButton: botonCosechado(),
    );
  }

  Widget _crearItem(Cosechado c) {
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
              "Lote: " + c.lote.toString(),
              style: TextStyle(fontSize: 10),
            ),
            Placeholder(
              fallbackHeight: 5,
              fallbackWidth: 100,
              color: Colors.transparent,
            ),
            Text("Numero de Racimos Cosechados: " + c.numRacimos.toString()),
            Placeholder(
              fallbackHeight: 5,
              fallbackWidth: 100,
              color: Colors.transparent,
            ),
            Text("Semana: " + c.semana.toString()),
            Placeholder(
              fallbackHeight: 5,
              fallbackWidth: 100,
              color: Colors.transparent,
            ),
            Text("Color de cinta: " + c.colorCinta),
            Placeholder(
              fallbackHeight: 10,
              fallbackWidth: 100,
              color: Colors.transparent,
            ),
          ]),
    );
  }

  Widget botonCosechado() {
    //if (globals.isLoggedIn) {
    return FloatingActionButton(
      backgroundColor: Colors.blue[900],
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
}

class CosechadoList extends StatelessWidget {
  final List<Cosechado> cosechados;
  const CosechadoList({Key key, this.cosechados}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cosechados.length,
      itemBuilder: (context, index) {
        return _crearCartaCosechado(cosechados[index]);
      },
    );
  }
}

Widget _crearCartaCosechado(Cosechado c) {
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
                      "Lote: " + c.lote.toString(),
                      style: TextStyle(fontSize: 10),
                    ),
                  ])),
              Padding(
                  padding: const EdgeInsets.only(left: 10, top: 7.0),
                  child: Row(children: <Widget>[
                    Text(
                      "Número de racimos cosechados: " +
                          c.numRacimos.toString(),
                      style: TextStyle(),
                    ),
                  ])),
              Padding(
                  padding: const EdgeInsets.only(left: 10, top: 7.0),
                  child: Row(children: <Widget>[
                    Text("Semana: " + c.semana.toString()),
                  ])),
              Padding(
                  padding: const EdgeInsets.only(left: 10, top: 7.0),
                  child: Row(children: <Widget>[
                    Text("Color de Cinta: " + c.colorCinta),
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
