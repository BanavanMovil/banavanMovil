import 'package:banavanmov/blocs/actividadBloc.dart';
import 'package:banavanmov/providers/actividadProvider.dart';
import 'package:banavanmov/response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/actividad.dart';

class ActividadesJC extends StatefulWidget {
  @override
  _ActividadesJCState createState() => _ActividadesJCState();
}

class _ActividadesJCState extends State<ActividadesJC> {
  final ActividadProvider ep = new ActividadProvider();
  bool isBusqueda = false;
  ActividadBloc _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = ActividadBloc();
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
        onRefresh: () => _bloc.fetchAllActividades(),
        child: StreamBuilder<Response<List<Actividad>>>(
          stream: _bloc.actividadListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
                  break;
                case Status.COMPLETED:
                  return ActividadList(actividades: snapshot.data.data);
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchAllActividades(),
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: botonNuevaActividad(),
    );
  }

  Widget botonNuevaActividad() {
    //if (globals.isLoggedIn) {
    return FloatingActionButton(
      backgroundColor: Colors.orange,
      onPressed: () {
        //if (globals.isLoggedIn) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SnackBar(content: Text("Hola"));
        }));
      },
      //},
      child: const Icon(Icons.add),
    );
    //}
    //return Row();
  }
}

class ActividadList extends StatelessWidget {
  final List<Actividad> actividades;
  const ActividadList({Key key, this.actividades}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: actividades.length,
      itemBuilder: (context, index) {
        return _crearCartaActividad(context, actividades[index]);
      },
    );
  }

  Widget _crearCartaActividad(BuildContext context, Actividad e) {
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
                        "Actividad ID: " + e.id.toString(),
                        style: TextStyle(fontSize: 10),
                      ),
                      Spacer(),
                      Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return SnackBar(content: Text("Hola"));
                              }));
                            },
                          ))
                    ])),
                Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5.0),
                    child: Row(children: <Widget>[
                      Text(
                        e.nombre,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ])),
                Placeholder(
                  fallbackHeight: 10,
                  fallbackWidth: 100,
                  color: Colors.transparent,
                ),
              ]),
        ));
  }
}
