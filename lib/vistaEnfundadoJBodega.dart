import 'package:banavanmov/actualizarEnfundadoJBodega.dart';
import 'package:banavanmov/model/color.dart';
import 'package:banavanmov/model/lote.dart';
import 'package:banavanmov/model/personnel.dart';
import 'package:banavanmov/model/semana.dart';
import 'package:banavanmov/providers/colorProvider.dart';
import 'package:banavanmov/providers/loteProvider.dart';
import 'package:banavanmov/providers/personnelProvider.dart';
import 'package:banavanmov/providers/semanaProvider.dart';
import 'package:banavanmov/utils/dataSource.dart';
import 'package:banavanmov/utils/util.dart';
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
  List<Lote> lotes;
  List<Personnel> personal;
  List<Semana> semanas;
  List<Colour> colores;
  @override
  void initState() {
    super.initState();
    _bloc = EnfundadoBloc();
    LoteProvider().todosLosLotes().then((value) {
      setState(() {
        lotes = value;
      });
    });
    PersonnelProvider().getAll().then((value) {
      setState(() {
        personal = value;
      });
    });
    SemanaProvider().getAll().then((value) {
      setState(() {
        semanas = value;
      });
    });
    ColorProvider().getAll().then((value) {
      setState(() {
        colores = value;
      });
    });
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
              TextSpan(text: "Enfundado", style: TextStyle(fontSize: 18.0)),
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
      ),*/
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
                  return EnfundadoList(
                    enfundados: snapshot.data.data,
                    datos: {
                      "lotes": lotes,
                      "personal": personal,
                      "semana": semanas,
                      "colores": colores
                    },
                  );
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
  final Map<String, dynamic> datos;
  const EnfundadoList({Key key, this.enfundados, this.datos}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: enfundados.length,
      itemBuilder: (context, index) {
        return _crearCartaEnfundado(context, enfundados[index]);
      },
    );
  }

  Widget _crearCartaEnfundado(BuildContext context, Enfundado e) {
    var semana = Util().obtenerSemanaDeId(e.id, datos['semana']);
    var color;
    if (semana != null) {
      color =
          Util().obtenerColorDeId(int.parse(semana.color_id), datos['colores']);
    }

    var lote = Util().obtenerLoteDeId(e.lote_id, datos['lotes']);
    var trabajador = Util().obtenerTrabajadorDeId(
        int.parse(e.user_id.toString()), datos['personal']);
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
                        "Lote: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(lote.toString()),
                      Spacer(),
                      Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ActualizarEnfundadoJB(
                                  enfunde: e,
                                  datos: {
                                    "lote": lote,
                                    'trabajador': trabajador,
                                    "semana": semana,
                                    'color': color
                                  },
                                );
                              }));
                            },
                          ))
                    ])),
                Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5.0),
                    child: Row(children: <Widget>[
                      Text(
                        trabajador != null ? trabajador : "--",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ])),
                Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5.0),
                    child: Row(children: <Widget>[
                      Text(
                        "Semana: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(semana != null ? semana.numero : "--")
                    ])),
                Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5.0),
                    child: Row(children: <Widget>[
                      Text(
                        "Color de Cinta: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(Icons.crop_square_rounded),
                        onPressed: () {},
                        color: DataSource().getColorFromHex(color),
                      ),
                      Spacer(),
                    ])),
                Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5.0),
                    child: Row(children: <Widget>[
                      Text(
                        "Fecha: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(e.fecha)
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
