import 'package:banavanmov/providers/loginProvider.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:banavanmov/model/perdido.dart';
import 'dart:io';
import 'package:banavanmov/exception/customException.dart';
import 'package:banavanmov/model/newObjectP.dart';
import 'package:banavanmov/actualizarPerdidoJBodega.dart';
import 'package:banavanmov/model/newObjectAP.dart';

class PerdidoProvider {
  //final String url = 'https://api.jsonbin.io/b/60b12f05a5cd4a5576a9933e';
  final String url = 'https://coco-backend-api.herokuapp.com/api/perdido/';

  //POST
  Future<bool> sendPerdido(NewObject newObject) async {
    var token = await LoginProvider.getToken();
    print("Aqui esta el racimo perdido:" + newObject.toJson().toString());
    final response = await http.post(url + "create",
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode(newObject.toJson()));
    if (response.statusCode == 201) {
      print("Este es el status code: " + response.statusCode.toString());
      print("Racimo Perdido Creado");
      return true;
    } else {
      print(response.body);
      print("Este es el status code: " + response.statusCode.toString());
      print("Algo paso");
      return false;
    }
  }

  //PUT
  Future<bool> updatePerdido(NewObjectTwo newObjectt) async {
    var token = await LoginProvider.getToken();
    print("Aqui esta el racimo perdido: " + newObjectt.toJson().toString());
    final response = await http.put(url + "update",
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode(newObjectt.toJson()));
    if (response.statusCode == 200) {
      print("Este es el status code: " + response.statusCode.toString());
      print("Racimo Cosechado Actualizado");
      return true;
    } else {
      print(response.body);
      print("Este es el status code: " + response.statusCode.toString());
      print("Algo paso");
      return false;
    }
  }

  Future<List<Perdido>> getAllPerdido() async {
    var token = await LoginProvider.getToken();
    final response = await http.get(url + 'get', headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    final List<dynamic> decodedData = json.decode(response.body);
    final List<Perdido> perdidos = [];

    if (decodedData == null) return [];

    decodedData.forEach((dona) {
      final perdido = Perdido.fromJson(dona);
      perdidos.add(perdido);
      //print(perdido.id.toString() + perdido.motivo);
    });
    return perdidos;
  }

  Future<List<dynamic>> getAll() async {
    var token = await LoginProvider.getToken();
    var responseJson;
    try {
      final resp = await http.get(url + 'get', headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
      responseJson = _response(resp);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson["registros"];
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
