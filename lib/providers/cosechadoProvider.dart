import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:banavanmov/model/cosechado.dart';
import 'dart:io';
import 'package:banavanmov/exception/customException.dart';
import 'package:banavanmov/publicarRacimoJBodega.dart';

class CosechadoProvider {
  //final String url = 'https://api.jsonbin.io/b/60b12ffc893b7c555b1dc945';
  final String url = 'https://coco-backend-api.herokuapp.com/api/cosechado/';

  //POST
  Future<bool> sendCosechado(NewObject newObject) async {
    print("Aqui esta el racimo cosechado: " + newObject.toJson().toString());
    /*final response = await http.post(url + "create",
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode(perdido.toJson()));
    if (response.statusCode == 200) {
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
  Future<bool> updateCosechado(Cosechado cosechado) async {
    final response =
        await http.put(url + cosechado.id.toString(), body: cosechado.toJson());
    final decodeData = json.decode(response.body);

    //print(decodeData);
    return true;
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
