import 'package:banavanmov/mainJCampo.dart';
import 'package:flutter/material.dart';

class SolicitudJC extends StatefulWidget {
  @override
  SolicitudJCState createState() => SolicitudJCState();
}

class SolicitudJCState extends State<SolicitudJC> {
  List<String> tipoSolicitud = ['Cosecha', 'Personal'];
  String _selectedTipo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Solicitud',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),
        ),
        backgroundColor: Colors.blue.shade600,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Card(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Container(
              child: DropdownButton(
                  hint: Text('Tipo de Solicitud'),
                  value: _selectedTipo,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedTipo = newValue;
                    });
                  },
                  items: tipoSolicitud.map((e) {
                    return DropdownMenuItem(child: Text(e), value: e);
                  }).toList()),
            ),
            Container(
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                minLines: 10,
                maxLines: null,
                decoration: InputDecoration(
                    labelText: 'Mensaje',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.only(top: 10, bottom: 10)),
                validator: (value) {
                  if (value.isEmpty) {
                    return "No hay nada aun";
                  }
                },
                onSaved: (value) {
                  //aqui se hace algo
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                  child: Text('Guardar'),
                  onPressed: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MainJCampo();
                    }));
                  }),
            )
          ]),
        ),
      ),
    );
  }
}
