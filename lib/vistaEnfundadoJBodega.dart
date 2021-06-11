import 'package:flutter/material.dart';
//
//
import 'package:banavanmov/model/enfundado.dart';
import 'package:banavanmov/providers/enfundadoProvider.dart';

import 'package:banavanmov/publicarEnfundadoJBodega.dart';

class EnfundadoVista extends StatefulWidget {
  @override
  _EnfundadoVistaState createState() => _EnfundadoVistaState();
}

class _EnfundadoVistaState extends State<EnfundadoVista> {
  final EnfundadoProvider ep = new EnfundadoProvider();
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
              "Lote: " + e.lote.toString(),
              style: TextStyle(fontSize: 10),
            ),
            Placeholder(
              fallbackHeight: 5,
              fallbackWidth: 100,
              color: Colors.transparent,
            ),
            Text(
              e.trabajador.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Placeholder(
              fallbackHeight: 5,
              fallbackWidth: 100,
              color: Colors.transparent,
            ),
            Text("Fecha de Entrega: " + e.fechaEntrega.toString()),
            Placeholder(
              fallbackHeight: 5,
              fallbackWidth: 100,
              color: Colors.transparent,
            ),
            Text("Número de Fundas Entregadas: " +
                e.fundasEntregadas.toString()),
            Placeholder(
              fallbackHeight: 5,
              fallbackWidth: 100,
              color: Colors.transparent,
            ),
            Text("Número de Fundas Recibidas: " + e.fundasRecibidas.toString()),
            Placeholder(
              fallbackHeight: 10,
              fallbackWidth: 100,
              color: Colors.transparent,
            ),
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
}
