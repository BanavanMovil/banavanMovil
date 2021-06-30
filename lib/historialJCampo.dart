import 'package:banavanmov/blocs/jCampoBloc.dart';
import 'package:banavanmov/model/jCampo.dart';
import 'package:banavanmov/providers/perdidoProvider.dart';
import 'package:flutter/material.dart';
import 'package:banavanmov/response.dart';

class HistorialJC extends StatefulWidget {
  @override
  _HistorialJCState createState() => _HistorialJCState();
}

class _HistorialJCState extends State<HistorialJC> {
  JCampoBloc _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = JCampoBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial de Cosecha'),
        backgroundColor: Colors.orange,
      ),
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchAllDailyInfo(),
        child: StreamBuilder<Response<List<JefeCampoModel>>>(
          stream: _bloc.jcListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
                  break;
                case Status.COMPLETED:
                  return JCampoList(jefeCampoInfo: snapshot.data.data);
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchAllDailyInfo(),
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  void prueba() {
    //jc.getInfo();
    PerdidoProvider ep = new PerdidoProvider();
    ep.getAllPerdido();
  }
}

class JCampoList extends StatelessWidget {
  final List<JefeCampoModel> jefeCampoInfo;
  const JCampoList({Key key, this.jefeCampoInfo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: jefeCampoInfo.length,
      itemBuilder: (context, index) {
        return _crearCartaInfo(jefeCampoInfo[index]);
      },
    );
  }
}

Widget _crearCartaInfo(JefeCampoModel e) {
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
                      e.nombres + " " + e.apellidos,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ])),
              Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5.0),
                  child: Row(children: <Widget>[
                    Text("Fecha: " + e.fechaLabor),
                  ])),
              Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5.0),
                  child: Row(children: <Widget>[
                    Text("HoraInicio: " + e.horaInicio),
                  ])),
              Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5.0),
                  child: Row(children: <Widget>[
                    Text("Hora fin: " + e.horaFin),
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
