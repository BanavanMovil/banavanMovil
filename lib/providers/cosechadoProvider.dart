import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:banavanmov/model/cosechado.dart';
import 'dart:io';
import 'package:banavanmov/exception/customException.dart';

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

  /*Future<List<Cosechado>> getAllCosechado() async {
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
  }*/

  Future<List<dynamic>> getAll() async {
    var responseJson;
    try {
      final resp = await http.get(url);
      responseJson = _response(resp);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
