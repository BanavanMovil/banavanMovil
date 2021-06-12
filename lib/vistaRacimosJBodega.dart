import 'package:banavanmov/model/cosechado.dart';
import 'package:flutter/material.dart';
import 'package:banavanmov/providers/cosechadoProvider.dart';

//
//
import 'package:banavanmov/publicarRacimoJBodega.dart';

class RacimosVista extends StatefulWidget {
  @override
  _RacimosVistaState createState() => _RacimosVistaState();
}

class _RacimosVistaState extends State<RacimosVista> {
  final CosechadoProvider cv = new CosechadoProvider();
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
              "Lote: " + c.lote.toString(),
              style: TextStyle(fontSize: 10),
            ),
            Placeholder(
              fallbackHeight: 5,
              fallbackWidth: 100,
              color: Colors.transparent,
            ),
            Text("Numero de Racimos Cosechados: " + c.numRacimos.toString()),
            Placeholder(
              fallbackHeight: 5,
              fallbackWidth: 100,
              color: Colors.transparent,
            ),
            Text("Semana: " + c.semana.toString()),
            Placeholder(
              fallbackHeight: 5,
              fallbackWidth: 100,
              color: Colors.transparent,
            ),
            Text("Color de cinta: " + c.colorCinta),
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
          return PublicarRacimoJB();
        }));
      },
      //},
      child: const Icon(Icons.add),
    );
    //}
    //return Row();
  }
}
