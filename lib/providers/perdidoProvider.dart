import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:banavanmov/model/perdido.dart';

class PerdidoProvider {
  final String url = 'https://api.jsonbin.io/b/60b12f05a5cd4a5576a9933e';
  //final String url = 'https://api.jsonbin.io/b/60b2c67392af611956f5da02';

  //POST
  Future<bool> postPerdido(Perdido perdido) async {
    final response = await http.post(url, body: perdido.toJson());
    final decodeData = json.decode(response.body);

    print(decodeData);
    return true;
  }

  //PUT
  Future<bool> updatePerdido(Perdido perdido) async {
    final response =
        await http.put(url + perdido.id.toString(), body: perdido.toJson());
    final decodeData = json.decode(response.body);

    print(decodeData);
    return true;
  }

  Future<List<Perdido>> getAllPerdido() async {
    final response = await http.get(url);
    final List<dynamic> decodedData = json.decode(response.body);
    final List<Perdido> perdidos = new List();

    if (decodedData == null) return [];

    decodedData.forEach((dona) {
      final perdido = Perdido.fromJson(dona);
      perdidos.add(perdido);
      //print(perdido.id.toString() + perdido.motivo);
    });
    return perdidos;
  }
}
