import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:banavanmov/model/perdido.dart';
import 'dart:io';
import 'package:banavanmov/exception/customException.dart';
import 'package:banavanmov/publicarPerdidoJBodega.dart';

class PerdidoProvider {
  //final String url = 'https://api.jsonbin.io/b/60b12f05a5cd4a5576a9933e';
  final String url = 'https://coco-backend-api.herokuapp.com/api/perdido/';

  //POST
  Future<bool> sendPerdido(NewObject newObject) async {
    print("Aqui esta el racimo perdido:" + newObject.toJson().toString());
    /*final response = await http.post(url + "create",
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
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
    }*/
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
    final response = await http.get(url + 'get');
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
    var responseJson;
    try {
      final resp = await http.get(url + 'get');
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
