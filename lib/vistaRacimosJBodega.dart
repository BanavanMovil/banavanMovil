//import 'package:firebase_database/firebase_database.dart';
import 'package:banavanmov/model/cosechado.dart';
import 'package:flutter/material.dart';
import 'package:banavanmov/providers/cosechadoProvider.dart';
//import 'package:izijob/clases/empleo.dart';
//
//
import 'package:banavanmov/publicarRacimoJBodega.dart';

//import 'DetailEmpleo.dart';

//import 'globals.dart' as globals;

class RacimosVista extends StatefulWidget {
  @override
  _RacimosVistaState createState() => _RacimosVistaState();
}

class _RacimosVistaState extends State<RacimosVista> {
  //List<Empleo> empleoList = [];
  //List<Empleo> filteredEmpleoList = [];
  final CosechadoProvider cv = new CosechadoProvider();
  bool isBusqueda = false;

  @override
  void initState() {
    super.initState();
    /*DatabaseReference empleoRef =
        FirebaseDatabase.instance.reference().child("Empleo");
    empleoRef.once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      empleoList.clear();

      for (var individualKey in keys) {
        Empleo empleo = Empleo(
            data[individualKey]['titulo'],
            data[individualKey]['descripcion'],
            data[individualKey]['telefono'],
            data[individualKey]['email'],
            data[individualKey]['categoria'],
            data[individualKey]['fechaP'],
            data[individualKey]['tiempoP'],
            data[individualKey]['idUser'],
            data[individualKey]['experiencia'],
            data[individualKey]['sueldo'],
            data[individualKey]['vacantes']);

        /*empleoList.add(empleo);
        filteredEmpleoList.add(empleo);*/
        //Agrega y ordena
        setState(() {
          empleoList.add(empleo);
          filteredEmpleoList.add(empleo);
          empleoList
              .sort((a, b) => a.fechaPublicado.compareTo(b.fechaPublicado));
          filteredEmpleoList
              .sort((a, b) => a.fechaPublicado.compareTo(b.fechaPublicado));
        });
      }
    });*/
  }

  /*void _filterEmpleos(value) {
    setState(() {
      filteredEmpleoList = empleoList
          .where((empleos) =>
              empleos.categoria.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }*/

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
      body: Container(
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
                )),
      floatingActionButton: botonEmpleo(),
    );
  }

  Widget _crearItem(Cosechado c) {
    return Card(
      child: Column(children: <Widget>[
        Text("Lote: " + c.lote.toString()),
        Text("Numero de Racimos Cosechados: " + c.numRacimos.toString()),
        Text("Semana: " + c.semana.toString()),
        Text("Color de cinta: " + c.colorCinta)
      ]),
    );
  }

  Widget botonEmpleo() {
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

  /*Widget postsEmpleo(Empleo empleo) {
    return Card(
        elevation: 10.0,
        margin: EdgeInsets.all(14.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailEmpleo(empleo: empleo),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      empleo.titulo,
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      //style: Theme.of(context).textTheme.subtitle1,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      empleo.fechaPublicado,
                      style: Theme.of(context).textTheme.subtitle2,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  empleo.descripcion,
                  style: Theme.of(context).textTheme.bodyText2,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Categoría: " + empleo.categoria,
                  style: Theme.of(context).textTheme.caption,
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Vacantes: " + empleo.vacantes,
                    style: Theme.of(context).textTheme.caption,
                    /*style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 21.0,
                      )*/
                  ),
                )
              ],
            ),
          ),
        ));
  }*/
}
