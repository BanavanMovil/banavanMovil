import 'package:banavanmov/blocs/solicitudesBloc.dart';
import 'package:banavanmov/model/solicitud.dart';
import 'package:banavanmov/providers/actividadProvider.dart';
import 'package:banavanmov/response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/actividad.dart';

class SolicitudesJC extends StatefulWidget {
  @override
  _SolicitudesJCState createState() => _SolicitudesJCState();
}

class _SolicitudesJCState extends State<SolicitudesJC> {
  final ActividadProvider ap = new ActividadProvider();
  bool isBusqueda = false;
  SolicitudBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = SolicitudBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: !isBusqueda
            ? Text('Jefe de Campo')
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
        onRefresh: () => _bloc.fetchAllSolicitudes(),
        child: StreamBuilder<Response<List<Solicitud>>>(
          stream: _bloc.solicitudListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
                  break;
                case Status.COMPLETED:
                  return SolicitudList(solicitudes: snapshot.data.data);
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchAllSolicitudes(),
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
      //floatingActionButton: botonNuevaActividad(context),
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

class SolicitudList extends StatelessWidget {
  final List<Solicitud> solicitudes;
  const SolicitudList({Key key, this.solicitudes}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return solicitudes == null
        ? Text("No se encontraron Solicitudes")
        : ListView.builder(
            itemCount: solicitudes.length,
            itemBuilder: (context, index) {
              return _crearCartaActividad(context, solicitudes[index]);
            },
          );
  }

  Widget _crearCartaActividad(BuildContext context, Solicitud e) {
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
                        "Solicitud ID: " + e.id.toString(),
                        style: TextStyle(fontSize: 10),
                      ),
                      Spacer(),
                      Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {},
                          ))
                    ])),
                Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5.0),
                    child: Row(children: <Widget>[
                      Text("Trabajadores Requeridos: "),
                      Text(
                        e.personal_requerido.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ])),
                Placeholder(
                  fallbackHeight: 10,
                  fallbackWidth: 100,
                  color: Colors.transparent,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5.0),
                    child: Row(children: <Widget>[
                      Text("Numero de Lote: "),
                      Text(
                        e.lote_id.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ])),
                Placeholder(
                  fallbackHeight: 10,
                  fallbackWidth: 100,
                  color: Colors.transparent,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5.0),
                    child: Row(children: <Widget>[
                      Text("Fecha: "),
                      Text(
                        e.fecha_actividad.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ])),
                Placeholder(
                  fallbackHeight: 10,
                  fallbackWidth: 100,
                  color: Colors.transparent,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5.0),
                    child: Row(children: <Widget>[
                      Text("Mensaje: "),
                      Text(
                        e.mensaje,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ])),
                Placeholder(
                  fallbackHeight: 10,
                  fallbackWidth: 100,
                  color: Colors.transparent,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5.0),
                    child: Row(children: <Widget>[
                      Text("Estado: "),
                      Text(
                        e.is_answered
                            ? (e.is_accepted ? "Aceptado" : "Rechazado")
                            : "En espera",
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
                  elevation: 4.0, onPressed: () {}, child: Text("SI")),
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
