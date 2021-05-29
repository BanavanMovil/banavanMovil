//import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
//import 'package:izijob/clases/empleo.dart';
//
//
import 'package:banavanmov/model/enfundado.dart';
import 'package:banavanmov/providers/enfundadoProvider.dart';

import 'package:banavanmov/publicarEnfundadoJBodega.dart';

//import 'DetailEmpleo.dart';

//import 'globals.dart' as globals;

class EnfundadoVista extends StatefulWidget {
  @override
  _EnfundadoVistaState createState() => _EnfundadoVistaState();
}

class _EnfundadoVistaState extends State<EnfundadoVista> {
  //List<Empleo> empleoList = [];
  //List<Empleo> filteredEmpleoList = [];
  final EnfundadoProvider ep = new EnfundadoProvider();
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
      body: Container(
          //padding: const EdgeInsets.all(5.0),
          //child: filteredEmpleoList.length == 0
          child: 1 == 0
              ? Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("No hay Enfundado",
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
                      future: ep.getAllEnfundado(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Enfundado>> snapshot) {
                        if (snapshot.hasData) {
                          final enfundados = snapshot.data;
                          return ListView.builder(
                              itemCount: enfundados.length,
                              itemBuilder: (context, i) =>
                                  _crearItem(enfundados[i]));
                        } else {
                          return CircularProgressIndicator();
                        }
                      }),
                )),
      floatingActionButton: botonEmpleo(),
    );
  }

  Widget _crearItem(Enfundado e) {
    return Card(
      child: Column(children: <Widget>[
        Text("Lote: " + e.lote.toString()),
        Text(e.trabajador.toString()),
        Text("Fecha de Entrega: " + e.fechaEntrega.toString()),
        Text("Número de Fundas Entregadas: " + e.fundasEntregadas.toString()),
        Text("Número de Fundas Recibidas: " + e.fundasRecibidas.toString()),
        //Text("Semana: " + e.semana.toString()),
        //Text("Color de cinta: " + e.colorCinta)
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
          return PublicarEnfundadoJB();
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
