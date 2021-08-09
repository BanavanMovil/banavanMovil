import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:banavanmov/model/perdido.dart';
import 'dart:io';
import 'package:banavanmov/exception/customException.dart';

class PerdidoProvider {
  final String url = 'https://api.jsonbin.io/b/60b12f05a5cd4a5576a9933e';
  //final String url = 'https://coco-backend-api.herokuapp.com/api/perdido/';

  //POST
  Future<bool> postPerdido(Perdido perdido) async {
    final response = await http.post(url, body: perdido.toJson());
    final decodeData = json.decode(response.body);

    //print(decodeData);
    return true;
  }

  //PUT
  Future<bool> updatePerdido(Perdido perdido) async {
    final response =
        await http.put(url + perdido.id.toString(), body: perdido.toJson());
    final decodeData = json.decode(response.body);

    //print(decodeData);
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
        //print(responseJson);
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
