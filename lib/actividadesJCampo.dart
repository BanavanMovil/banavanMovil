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
  final ActividadProvider ap = new ActividadProvider();
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
            ? Text('Jefe de Campo \n    Actividades')
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
      floatingActionButton: botonNuevaActividad(context),
    );
  }

  Widget botonNuevaActividad(BuildContext context) {
    //if (globals.isLoggedIn) {
    return FloatingActionButton(
      backgroundColor: Colors.orange,
      onPressed: () {
        //if (globals.isLoggedIn) {
        createAlertDialog(context).then((value) {
          if (value == "No se envio nada" || value == null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text('Nada Enviado'),
                action: SnackBarAction(
                  label: 'Cerrar',
                  onPressed: () {
                    // Code to execute.
                  },
                )));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text('Actividad Creada'),
                action: SnackBarAction(
                  label: 'Cerrar',
                  onPressed: () {
                    // Code to execute.
                  },
                )));
          }
        });
      },
      //},
      child: const Icon(Icons.add),
    );
    //}
    //return Row();
  }

  createAlertDialog(BuildContext context) {
    TextEditingController nuevaActividad = new TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Coloque el nombre de la nueva actividad: "),
            content: TextField(
              controller: nuevaActividad,
            ),
            actions: <Widget>[
              MaterialButton(
                  elevation: 4.0, onPressed: () {}, child: Text("Cancelar")),
              MaterialButton(
                  elevation: 4.0,
                  onPressed: () {
                    if (nuevaActividad.text != null ||
                        nuevaActividad.text.toString().trim() != "") {
                      Actividad a = new Actividad(
                          id: -1, nombre: nuevaActividad.text.toString());
                      ap.createActividad(a);
                      Navigator.of(context).pop(nuevaActividad.text.toString());
                    } else {
                      Navigator.of(context).pop("No se envio nada");
                    }
                  },
                  child: Text("Crear"))
            ],
          );
        });
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
                              createAlertDialog(context, e);
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

  createAlertDialog(BuildContext context, Actividad a) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
                "Esta seguro que desea eliminar la Actividad: " + a.nombre),
            actions: <Widget>[
              MaterialButton(
                  elevation: 4.0,
                  onPressed: () {
                    ActividadProvider().deleteActividad(a).then((value) {
                      if (value) {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                const Text('Actividad Eliminada Exitosamente!'),
                            action: SnackBarAction(
                              label: 'Cerrar',
                              onPressed: () {
                                // Code to execute.
                              },
                            )));
                      } else {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                const Text('No se pudo eliminar la actividad.'),
                            action: SnackBarAction(
                              label: 'Cerrar',
                              onPressed: () {
                                // Code to execute.
                              },
                            )));
                      }
                    });
                  },
                  child: Text("SI")),
              MaterialButton(
                  elevation: 4.0,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("NO"))
            ],
          );
        });
  }
}
