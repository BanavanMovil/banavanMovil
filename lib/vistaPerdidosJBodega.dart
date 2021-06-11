import 'package:flutter/material.dart';
//
//

import 'package:banavanmov/publicarPerdidoJBodega.dart';
import 'package:banavanmov/providers/perdidoProvider.dart';
import 'package:banavanmov/model/perdido.dart';

class PerdidosVista extends StatefulWidget {
  @override
  _PerdidosVistaState createState() => _PerdidosVistaState();
}

class _PerdidosVistaState extends State<PerdidosVista> {
  final PerdidoProvider pv = new PerdidoProvider();
  bool isBusqueda = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: !isBusqueda
            ? Text('   Jefe de Bodega\nRacimos Perdidos')
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
                        Text("No hay Racimos Perdidos",
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
                      future: pv.getAllPerdido(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Perdido>> snapshot) {
                        if (snapshot.hasData) {
                          final perdidos = snapshot.data;
                          return ListView.builder(
                              itemCount: perdidos.length,
                              itemBuilder: (context, i) =>
                                  _crearItem(perdidos[i]));
                        } else {
                          return CircularProgressIndicator();
                        }
                      }),
                )),
      floatingActionButton: botonEmpleo(),
    );
  }

  Widget _crearItem(Perdido p) {
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
              "Lote: " + p.lote.toString(),
              style: TextStyle(fontSize: 10),
            ),
            Placeholder(
              fallbackHeight: 5,
              fallbackWidth: 100,
              color: Colors.transparent,
            ),
            Text(
              "Reportado por: " + p.trabajador.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Placeholder(
              fallbackHeight: 5,
              fallbackWidth: 100,
              color: Colors.transparent,
            ),
            Text("Fecha de Reporte: " + p.fechaRegistro.toString()),
            Placeholder(
              fallbackHeight: 5,
              fallbackWidth: 100,
              color: Colors.transparent,
            ),
            Text("Motivo de pérdida: " + p.motivo.toString()),
            Placeholder(
              fallbackHeight: 5,
              fallbackWidth: 100,
              color: Colors.transparent,
            ),
            Text("Color de cinta: " + p.colorCinta.toString()),
            Placeholder(
              fallbackHeight: 10,
              fallbackWidth: 100,
              color: Colors.transparent,
            ),
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
          return PublicarPerdidoJB();
        }));
      },
      //},
      child: const Icon(Icons.add),
    );
    //}
    //return Row();
  }
}
