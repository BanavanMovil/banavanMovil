import 'package:banavanmov/blocs/personnelBloc.dart';
import 'package:banavanmov/misc/personnelListTile.dart';
import 'package:banavanmov/model/personnel.dart';
import 'package:banavanmov/model/solicitud.dart';
import 'package:banavanmov/providers/personnelProvider.dart';
import 'package:banavanmov/providers/solicitudProvider.dart';
import 'package:banavanmov/response.dart';
import 'package:flutter/material.dart';

class AsignarPersonalJC extends StatefulWidget {
  final Solicitud solicitud;
  @override
  _AsignarPersonalJCState createState() => _AsignarPersonalJCState();

  AsignarPersonalJC({Key key, this.solicitud}) : super(key: key);
}

class _AsignarPersonalJCState extends State<AsignarPersonalJC> {
  Solicitud solicitud;
  List<Personnel> personal;
  PersonnelBloc _bloc;
  @override
  void initState() {
    super.initState();
    solicitud = widget.solicitud;
    personal = [];
    _bloc = PersonnelBloc();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trabajadores a seleccionar"),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchAllPersonnel(),
        child: StreamBuilder<Response<List<Personnel>>>(
          stream: _bloc.personnelListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print("ESTATUS: " + snapshot.data.data.toString());
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
                  break;
                case Status.COMPLETED:
                  return PersonnelList(personal: snapshot.data.data);
                  break;
                case Status.ERROR:
                  //print("VA A DAR ERROR");
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchAllPersonnel(),
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
}

class PersonnelList extends StatefulWidget {
  final List<Personnel> personal;
  final Solicitud solicitud;
  const PersonnelList({Key key, this.personal = const [], this.solicitud})
      : super(key: key);
  @override
  _PersonnelListState createState() => _PersonnelListState();
}

class _PersonnelListState extends State<PersonnelList> {
  List<Personnel> personalElegido;
  Solicitud solicitud;
  @override
  initState() {
    super.initState();
    personalElegido = widget.personal;
    solicitud = widget.solicitud;
  }

  @override
  Widget build(BuildContext context) {
    //final provider = Provider.of<PersonnelNotifier>(context);
    //final allPersonnel = provider.personnel;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Asignar Personal \n Personal Requerido: ${solicitud.personal_requerido}",
          textAlign: TextAlign.center,
        ),
      ),
      body: FutureBuilder(
        future: PersonnelProvider().getAll(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Personnel>> snapshot) {
          if (snapshot.hasData) {
            final allPersonnel = snapshot.data;
            return ListView(
              children: allPersonnel.map((p) {
                final isSelected = personalElegido.contains(p);

                return PersonnelListTileWidget(
                  personnel: p,
                  seleccionado: isSelected,
                  onSelectedChanged: seleccionPersonal,
                );
              }).toList(),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: sendButton(context),
    );
  }

  seleccionPersonal(Personnel p) {
    final seleccionado = personalElegido.contains(p);
    setState(() {
      print("CAMBIA DE ESTADO");

      seleccionado ? personalElegido.remove(p) : personalElegido.add(p);
      print(personalElegido.toString());
    });
  }

  Widget sendButton(BuildContext context) {
    final label = "Ha seleccionado ${personalElegido.length} trabajadores.";

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 52, vertical: 12),
      color: null,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          minimumSize: Size.fromHeight(40),
          primary: solicitud.personal_requerido == personalElegido.length
              ? Colors.white
              : Colors.black,
        ),
        child: Text(
          label,
          style: TextStyle(
              color: solicitud.personal_requerido == personalElegido.length
                  ? Colors.black
                  : Colors.white,
              fontSize: 16),
        ),
        onPressed: enviarTrabajadores,
      ),
    );
  }

  void enviarTrabajadores() {
    print("Aqui va el post a user actividad");
    if (solicitud.personal_requerido == personalElegido.length) {
      SolicitudProvider()
          .sendTrabajadores(solicitud, listadoIdsTrabajadores(personalElegido))
          .then((value) {
        if (value) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text('Trabajadores Asignados Correctamente.'),
              action: SnackBarAction(
                label: 'Cerrar',
                onPressed: () {
                  // Code to execute.
                },
              )));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content:
                  const Text('Ocurrio un problema al enviar la informacion.'),
              action: SnackBarAction(
                label: 'Cerrar',
                onPressed: () {
                  // Code to execute.
                },
              )));
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('El numero de trabajadores no es el exacto'),
          action: SnackBarAction(
            label: 'Cerrar',
            onPressed: () {
              // Code to execute.
            },
          )));
    }
  }

  List<int> listadoIdsTrabajadores(List<Personnel> lista) {
    List<int> nuevaLista = [];
    lista.forEach((element) {
      nuevaLista.add(element.id);
    });
    return nuevaLista;
  }
}
