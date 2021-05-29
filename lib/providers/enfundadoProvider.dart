import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:banavanmov/model/enfundado.dart';

class EnfundadoProvider {
  final String url = 'https://api.jsonbin.io/b/60b1246bd0f4985540539053';

  //POST
  Future<bool> postEnfundado(Enfundado enfundado) async {
    final response = await http.post(url, body: enfundado.toJson());
    final decodeData = json.decode(response.body);

    print(decodeData);
    return true;
  }

  //PUT
  Future<bool> updateEnfundado(Enfundado enfundado) async {
    final response =
        await http.put(url + enfundado.id.toString(), body: enfundado.toJson());
    final decodeData = json.decode(response.body);

    print(decodeData);
    return true;
  }

  Future<List<Enfundado>> getAllEnfundado() async {
    final response = await http.get(url);
    final List<dynamic> decodedData = json.decode(response.body);
    final List<Enfundado> enfundados = new List();

    if (decodedData == null) return [];

    decodedData.forEach((dona) {
      final enfunde = Enfundado.fromJson(dona);
      enfundados.add(enfunde);
      print(enfunde.id.toString() + ' ' + enfunde.trabajador);
    });
    return enfundados;
  }
}
