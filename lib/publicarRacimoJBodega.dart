//https://flutter-es.io/docs/cookbook/navigation/navigation-basics
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:banavanmov/model/cosechado.dart';
import 'package:banavanmov/vistaRacimosJBodega.dart';
import 'package:banavanmov/providers/cosechadoProvider.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

class PublicarRacimoJB extends StatefulWidget {
  @override
  _PublicarRacimoJBState createState() => _PublicarRacimoJBState();
}

class _PublicarRacimoJBState extends State<PublicarRacimoJB> {
  final _formKey = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();
  String semana, semanaResult;
  String lote, loteResult;
  String color, colorResult;
  String numRacimo, numRacimoResult;

  @override
  void initState() {
    super.initState();
    semana = '';
    lote = '';
    color = '';
    numRacimo = '';
    semanaResult = '';
    loteResult = '';
    colorResult = '';
    numRacimoResult = '';
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text('Registro Racimo'),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Form(
              key: _formKey,
              child: Scrollbar(
                child: ListView(
                  children: <Widget>[
                    new ListTile(
                      //leading: const Icon(Icons.contact_phone),

                      title: TextFormField(
                          //controller: _controller,
                          keyboardType: TextInputType.number,
                          onChanged: (newValue) {
                            setState(() {
                              numRacimo = newValue;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              numRacimo = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Por favor ingrese un valor.";
                            }
                            return null;
                          },
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            labelText: "Número de Racimos",
                            //hintText: "whatever you want",
                            //icon: Icon(Icons.phone_iphone)
                          )),
                    ),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: DropDownFormField(
                          titleText: 'Semana',
                          hintText: 'Elija la Semana',
                          value: semana,
                          validator: (value) {
                            if (value == null) {
                              return "Por favor elija una semana.";
                            }
                            return null;
                          },
                          onChanged: (newValue) {
                            setState(() {
                              semana = newValue;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              semana = value;
                            });
                          },
                          dataSource: [
                            {"display": "52", "value": "52"},
                            {"display": "53", "value": "53"},
                            {"display": "54", "value": "54"},
                            {"display": "55", "value": "55"},
                            {"display": "56", "value": "56"},
                            {"display": "57", "value": "57"}
                          ],
                          textField: 'display',
                          valueField: 'value',
                        )),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: DropDownFormField(
                          titleText: 'Lote',
                          hintText: 'Elija el Lote',
                          value: lote,
                          validator: (value) {
                            if (value == null) {
                              return "Por favor seleccione un lote";
                            }
                            return null;
                          },
                          onChanged: (newValue) {
                            setState(() {
                              lote = newValue;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              lote = value;
                            });
                          },
                          dataSource: [
                            {"display": "1", "value": "1"},
                            {"display": "2", "value": "2"},
                            {"display": "3", "value": "3"},
                            {"display": "4", "value": "4"}
                          ],
                          textField: 'display',
                          valueField: 'value',
                        )),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: DropDownFormField(
                          titleText: 'Color de cinta',
                          hintText: 'Elija el Color',
                          value: color,
                          validator: (value) {
                            if (value == null) {
                              return "Por favor elija un color.";
                            }
                            return null;
                          },
                          onChanged: (newValue) {
                            setState(() {
                              color = newValue;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              color = value;
                            });
                          },
                          dataSource: [
                            {"display": "Rojo", "value": "Rojo"},
                            {"display": "Verde", "value": "Verde"},
                            {"display": "Azul", "value": "Azul"},
                            {"display": "Amarillo", "value": "Amarillo"}
                          ],
                          textField: 'display',
                          valueField: 'value',
                        )),
                    new ElevatedButton(
                      child: Text("Guardar",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15, color: Colors.white)),
                      onPressed: uploadStatusRacimo,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void uploadStatusRacimo() async {
    print(_formKey.currentState.validate());
    if (_formKey.currentState.validate()) {
      CosechadoProvider cp = new CosechadoProvider();
      //ep.postEnfundado(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Racimo Creado')));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        //return Footer();
        return RacimosVista();
      }));
    }
  }
}
