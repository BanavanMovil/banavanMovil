import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:banavanmov/model/cosechado.dart';

class CosechadoProvider {
  final String url = 'https://api.jsonbin.io/b/60b12ffc893b7c555b1dc945';

  //POST
  Future<bool> postCosechado(Cosechado cosechado) async {
    final response = await http.post(url, body: cosechado.toJson());
    final decodeData = json.decode(response.body);

    print(decodeData);
    return true;
  }

  //PUT
  Future<bool> updateCosechado(Cosechado cosechado) async {
    final response =
        await http.put(url + cosechado.id.toString(), body: cosechado.toJson());
    final decodeData = json.decode(response.body);

    print(decodeData);
    return true;
  }

  Future<List<Cosechado>> getAllCosechado() async {
    final response = await http.get(url);
    final List<dynamic> decodedData = json.decode(response.body);
    final List<Cosechado> cosechados = new List();

    if (decodedData == null) return [];

    decodedData.forEach((dona) {
      final cosecha = Cosechado.fromJson(dona);
      cosechados.add(cosecha);
      //print(cosecha.id.toString() + ' ' + cosecha.colorCinta);
    });
    return cosechados;
  }
}
